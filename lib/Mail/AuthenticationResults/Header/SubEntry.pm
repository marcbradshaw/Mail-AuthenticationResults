package Mail::AuthenticationResults::Header::SubEntry;
use strict;
use warnings;
use version; our $VERSION = version->declare('v1.0.0');

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
