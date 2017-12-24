package Mail::AuthenticationResults::Header::Base;
# VERSION
use strict;
use warnings;
use Scalar::Util qw{ weaken };
use Carp;

use Mail::AuthenticationResults::Header::Group;

sub HAS_KEY{ return 0; }
sub HAS_VALUE{ return 0; }
sub HAS_CHILDREN{ return 0; }

sub new {
    my ( $class ) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub set_key {
    my ( $self, $key ) = @_;
    croak 'Does not have key' if ! $self->HAS_KEY();
    $self->{ 'key' } = $key;
    return $self;
}

sub key {
    my ( $self ) = @_;
    croak 'Does not have key' if ! $self->HAS_KEY();
    return $self->{ 'key' } // q{};
}

sub set_value {
    my ( $self, $value ) = @_;
    croak 'Does not have value' if ! $self->HAS_VALUE();
    $self->{ 'value' } = $value;
    return $self;
}
sub value {
    my ( $self ) = @_;
    croak 'Does not have value' if ! $self->HAS_VALUE();
    return $self->{ 'value' } // q{};
}

sub children {
    my ( $self ) = @_;
    croak 'Does not have children' if ! $self->HAS_CHILDREN();
    return $self->{ 'children' } // [];
}

sub add_child {
    my ( $self, $child ) = @_;
    croak 'Does not have children' if ! $self->HAS_CHILDREN();
    $child->{ 'parent' } = $self;
    weaken $child->{ 'parent' };
    push @{ $self->{ 'children' } }, $child;
    return $child;
}

sub as_string {
    my ( $self ) = @_;
    my $string = $self->key() . '=' . $self->value();
    if ( $self->HAS_CHILDREN() ) {
        foreach my $child ( @{$self->children()} ) {
            $string .= ' ' . $child->as_string();
        }
    }
    return $string;
}

sub search {
    my ( $self, $search ) = @_;

    my $group = Mail::AuthenticationResults::Header::Group->new();

    my $match = 1;

    if ( exists( $search->{ 'key' } ) ) {
        if ( $self->HAS_KEY() ) {
            if ( lc $search->{ 'key' } eq lc $self->key() ) {
                $match = $match && 1;
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
        if ( $self->HAS_VALUE() ) {
            if ( lc $search->{ 'value' } eq lc $self->value() ) {
                $match = $match && 1;
            }
            else {
                $match = 0;
            }
        }
        else {
            $match = 0;
        }
    }

    if ( exists( $search->{ 'isa' } ) ) {
        if ( lc $search->{ 'isa' } eq 'entry' ) {
            if ( ref $self eq 'Mail::AuthenticationResults::Header::Entry' ) {
                $match = $match && 1;
            }
            else {
                $match = 0;
            }
        }
        if ( lc $search->{ 'isa' } eq 'subentry' ) {
            if ( ref $self eq 'Mail::AuthenticationResults::Header::SubEntry' ) {
                $match = $match && 1;
            }
            else {
                $match = 0;
            }
        }
        if ( lc $search->{ 'isa' } eq 'comment' ) {
            if ( ref $self eq 'Mail::AuthenticationResults::Header::Comment' ) {
                $match = $match && 1;
            }
            else {
                $match = 0;
            }
        }
    }

    if ( $match ) {
        $group->add_child( $self );
    }

    if ( $self->HAS_CHILDREN() ) {
        foreach my $child ( @{$self->children()} ) {
            my $childfound = $child->search( $search );
            if ( $childfound ) {
                $group->add_child( $childfound );
            }
        }
    }

    return $group;
}

1;
package Mail::AuthenticationResults::Header::Base;
