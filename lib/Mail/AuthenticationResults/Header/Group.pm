package Mail::AuthenticationResults::Header::Group;
require 5.010;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ refaddr };
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

sub HAS_CHILDREN{ return 1; }

sub ALLOWED_CHILDREN {
    my ( $self, $parent ) = @_;
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::AuthServID';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Comment';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Entry';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Group';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::SubEntry';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header';
    return 0;
}

sub add_parent {
    my ( $self ) = @_;
    croak 'Cannot add group class as a child';
    return; # uncoverable statement
}

sub add_child {
    my ( $self, $child ) = @_;
    croak 'Cannot add a class as its own parent' if refaddr $self == refaddr $child;

    if ( ref $child eq 'Mail::AuthenticationResults::Header::Group' ) {
        foreach my $subchild ( @{ $child->children() } ) {
            $self->SUPER::add_child( $subchild );
        }
        ## ToDo what to return in this case?
    }
    else {
        $self->SUPER::add_child( $child );
    }

    return $child;
}

sub as_string {
    my ( $self ) = @_;
    my $string = q{};
    return join( ";\n", map { $_->as_string() } @{ $self->children() } );
}

1;

