package Mail::AuthenticationResults::Header::SubEntry;
require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

sub HAS_KEY{ return 1; }
sub HAS_VALUE{ return 1; }
sub HAS_CHILDREN{ return 1; }

sub ALLOWED_CHILDREN {
    my ( $self, $parent ) = @_;
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Comment';
    return 0;
}

sub add_child {
    my ( $self, $child ) = @_;
    if ( ref $child eq 'Mail::AuthenticationResults::Header::Comment' ) {
        $self->SUPER::add_child( $child );
    }
    else {
        croak 'cannot add a non-comment child to a sub entry';
    }
    return;
}

1;
