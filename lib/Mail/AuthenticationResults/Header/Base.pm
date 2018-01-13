package Mail::AuthenticationResults::Header::Base;
# ABSTRACT: Base class for modelling parts of the Authentication Results Header

require 5.010;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ weaken refaddr };
use Carp;

use Mail::AuthenticationResults::Header::Group;

=head1 DESCRIPTION

Set of classes representing the various parts and sub parts of Authentication Results Headers.

L<Mail::AuthenticationResults::Header> represents a complete Authentication Results Header set
L<Mail::AuthenticationResults::Header::AuthServID> represents the AuthServID part of the set
L<Mail::AuthenticationResults::Header::Comment> represents a comment
L<Mail::AuthenticationResults::Header::Entry> represents a main entry
L<Mail::AuthenticationResults::Header::Group> represents a group of parts, typically as a search result
L<Mail::AuthenticationResults::Header::SubEntry> represents a sub entry part
L<Mail::AuthenticationResults::Header::Version> represents a version part

Header
    AuthServID
        Version
        Comment
        SubEntry
    Entry
        Comment
    Entry
        Comment
        SubEntry
            Comment
    Entry
        SubEntry
        SubEntry

Group
    Entry
        Comment
    SubEntry
        Comment
    Entry
        SubEntry

=cut

sub _HAS_KEY{ return 0; }
sub _HAS_VALUE{ return 0; }
sub _HAS_CHILDREN{ return 0; }
sub _ALLOWED_CHILDREN{ # uncoverable subroutine
    # does not run in Base as HAS_CHILDREN returns 0
    return 0; # uncoverable statement
}

=method new()

Return a new instance of this class

=cut

sub new {
    my ( $class ) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

=method set_key( $key )

Set the key for this instance.

Croaks if $key is invalid.

=cut

sub set_key {
    my ( $self, $key ) = @_;
    croak 'Does not have key' if ! $self->_HAS_KEY();
    croak 'Key cannot be undefined' if ! defined $key;
    croak 'Key cannot be empty' if $key eq q{};
    croak 'Invalid characters in key' if $key =~ /"/;
    $self->{ 'key' } = $key;
    return $self;
}

=method key()

Return the current key for this instance.

Croaks if this instance type can not have a key.

=cut

sub key {
    my ( $self ) = @_;
    croak 'Does not have key' if ! $self->_HAS_KEY();
    return $self->{ 'key' } // q{};
}

sub _safe_value {
    my ( $self, $value, $args ) = @_;

    $value = q{} if ! defined $value;

    $value =~ s/\t/ /g;
    $value =~ s/\n/ /g;
    $value =~ s/\r/ /g;
    $value =~ s/\(/ /g;
    $value =~ s/\)/ /g;
    $value =~ s/\\/ /g;
    $value =~ s/"/ /g;
    $value =~ s/=/ /g;

    $value =~ s/;/ /g if ! exists( $args->{ ';' } );

    $value =~ s/^\s+//;
    $value =~ s/\s+$//;

    $value =~ s/ /_/g if ! exists ( $args->{ ' ' } );

    return $value;
}

=method safe_set_value( $value )

Set the value for this instance.

Munges the value to remove invalid characters before setting.

=cut

sub safe_set_value {
    my ( $self, $value ) = @_;

    $value = $self->_safe_value( $value );
    $self->set_value( $self->_safe_value( $value, {} ) );

    $self->set_value( $value );
    return $self;
}

=method set_value( $value )

Set the value for this instance.

Croaks if the value contains invalid characters.

=cut

sub set_value {
    my ( $self, $value ) = @_;
    croak 'Does not have value' if ! $self->_HAS_VALUE();
    croak 'Value cannot be undefined' if ! defined $value;
    #croak 'Value cannot be empty' if $value eq q{};
    croak 'Invalid characters in value' if $value =~ /"/;
    $self->{ 'value' } = $value;
    return $self;
}

=method value()

Returns the current value for this instance.

=cut

sub value {
    my ( $self ) = @_;
    croak 'Does not have value' if ! $self->_HAS_VALUE();
    return $self->{ 'value' } // q{};
}

=method stringify( $value )

Returns $value with stringify rules applied.

=cut

sub stringify {
    my ( $self, $value ) = @_;
    my $string = $value // q{};

    if ( $string =~ /[\s\t \(\);]/ ) {
        $string = '"' . $string . '"';
    }

    return $string;
}

=method children()

Returns a listref of this instances children.

Croaks is this instance type can not have children.

=cut

sub children {
    my ( $self ) = @_;
    croak 'Does not have children' if ! $self->_HAS_CHILDREN();
    return $self->{ 'children' } // [];
}

=method add_parent( $parent )

Sets the parent for this instance to the supplied object.

Croaks is the relationship between $parent and $self is not valid.

=cut

sub add_parent {
    my ( $self, $parent ) = @_;
    return if ( ref $parent eq 'Mail::AuthenticationResults::Header::Group' );
    croak 'Child already has a parent' if exists $self->{ 'parent' };
    croak 'Cannot add parent' if ! $parent->_ALLOWED_CHILDREN( $self ); # uncoverable branch true
    # Does not run as test is also done in add_child before add_parent is called.
    $self->{ 'parent' } = $parent;
    weaken $self->{ 'parent' };
    return;
}

=method parent()

Returns the parent object for this instance.

=cut

sub parent {
    my ( $self ) = @_;
    return $self->{ 'parent' };
}

=method add_child( $child )

Adds $child as a child of this instance.

Croaks is the relationship between $child and $self is not valid.

=cut

sub add_child {
    my ( $self, $child ) = @_;
    croak 'Does not have children' if ! $self->_HAS_CHILDREN();
    croak 'Cannot add child' if ! $self->_ALLOWED_CHILDREN( $child );
    croak 'Cannot add a class as its own parent' if refaddr $self == refaddr $child; # uncoverable branch true
    # Does not run as there are no ALLOWED_CHILDREN results which permit this

    $child->add_parent( $self );
    push @{ $self->{ 'children' } }, $child;

    return $child;
}

=method as_string()

Returns this instance as a string.

=cut

sub as_string {
    my ( $self ) = @_;

    if ( ! $self->key() ) {
        return q{};
    }

    my $string .= $self->stringify( $self->key() );
    if ( $self->value() ) {
        $string .= '=' . $self->stringify( $self->value() );
    }
    else {
        # We special case none here
        if ( $self->key() ne 'none' ) {
             $string .= '=""';
        }
    }
    if ( $self->_HAS_CHILDREN() ) { # uncoverable branch false
        # There are no classes which run this code without having children
        foreach my $child ( @{$self->children()} ) {
            $string .= ' ' . $child->as_string();
        }
    }
    return $string;
}

=method search( $search )

Apply search rules in $search to this instance and return a
Mail::AuthenticationResults::Header::Group object containing the matches.

$search is a HASHREF with the following possible key/value pairs

=over

=item key

Match if the instance key matches the supplied value (string or regex)

=item value

Match if the instance value matches the supplied value (string or regex)

=item isa

Match is the instance class typs matches the supplied value. This is a lowercase version
of the class type, (comment,entry,subentry,etc))

=back

=cut

sub search {
    my ( $self, $search ) = @_;

    my $group = Mail::AuthenticationResults::Header::Group->new();

    my $match = 1;

    if ( exists( $search->{ 'key' } ) ) {
        if ( $self->_HAS_KEY() ) {
            if ( ref $search->{ 'key' } eq 'Regexp' && $self->key() =~ m/$search->{'key'}/ ) {
                $match = $match && 1; # uncoverable statement
                # $match is always 1 at this point, left this way for consistency
            }
            elsif ( lc $search->{ 'key' } eq lc $self->key() ) {
                $match = $match && 1; # uncoverable statement
                # $match is always 1 at this point, left this way for consistency
            }
            else {
                $match = 0;
            }
        }
        else {
            $match = 0;
        }
    }

    if ( exists( $search->{ 'value' } ) ) {
        if ( $self->_HAS_VALUE() ) {
            if ( ref $search->{ 'value' } eq 'Regexp' && $self->value() =~ m/$search->{'value'}/ ) {
                $match = $match && 1;
            }
            elsif ( lc $search->{ 'value' } eq lc $self->value() ) {
                $match = $match && 1;
            }
            else {
                $match = 0;
            }
        }
        else {
            $match = 0; # uncoverable statement
            # There are no code paths with the current classes which end up here
        }
    }

    if ( exists( $search->{ 'isa' } ) ) {
        if ( lc ref $self eq 'mail::authenticationresults::header::' . lc $search->{ 'isa' } ) {
            $match = $match && 1;
        }
        else {
            $match = 0;
        }
    }

    if ( $match ) {
        $group->add_child( $self );
    }

    if ( $self->_HAS_CHILDREN() ) {
        foreach my $child ( @{$self->children()} ) {
            my $childfound = $child->search( $search );
            if ( scalar @{ $childfound->children() } ) {
                $group->add_child( $childfound );
            }
        }
    }

    return $group;
}

1;

