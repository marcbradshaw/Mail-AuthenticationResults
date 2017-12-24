package Mail::AuthenticationResults::Header::SubEntry;
# VERSION
use strict;
use warnings;

sub HAS_KEY{ return 1; }
sub HAS_VALUE{ return 1; }
sub HAS_CHILDREN{ return 1; }

use base 'Mail::AuthenticationResults::Header::Base';

sub add_child {
    my ( $self, $child ) = @_;
    if ( ref $child eq 'Mail::AuthenticationResults::Header::Comment' ) {
        $self->SUPER::add_child( $child );
    }
    else {
        die 'cannot add a non-comment child to a sub entry';
    }
    return;
}

1;
