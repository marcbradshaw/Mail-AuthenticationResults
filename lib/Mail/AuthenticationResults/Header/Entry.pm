package Mail::AuthenticationResults::Header::Entry;
require 5.010;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ refaddr };
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

sub HAS_KEY{ return 1; }
sub HAS_VALUE{ return 1; }
sub HAS_CHILDREN{ return 1; }

sub ALLOWED_CHILDREN {
    my ( $self, $parent ) = @_;
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Comment';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::SubEntry';
    return 0;
}

sub add_child {
    my ( $self, $child ) = @_;
    croak 'Cannot add an Entry as a child of an Entry' if ref $child eq 'Mail::AuthenticationResults::Header::Entry';
    return $self->SUPER::add_child( $child );
}

sub as_string {
    my ( $self ) = @_;
    return $self->SUPER::as_string();
}

1;
