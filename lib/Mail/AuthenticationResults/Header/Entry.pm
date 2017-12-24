package Mail::AuthenticationResults::Header::Entry;
# VERSION
use strict;
use warnings;

sub HAS_KEY{ return 1; }
sub HAS_VALUE{ return 1; }
sub HAS_CHILDREN{ return 1; }

use base 'Mail::AuthenticationResults::Header::Base';

sub as_string {
    my ( $self ) = @_;
    return $self->SUPER::as_string();
}

1;
