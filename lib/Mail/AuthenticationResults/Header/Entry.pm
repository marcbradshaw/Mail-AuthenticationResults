package Mail::AuthenticationResults::Header::Entry;
use strict;
use warnings;
use version; our $VERSION = version->declare('v1.0.0');

use base 'Mail::AuthenticationResults::Header::Base';

sub as_string {
    my ( $self ) = @_;
    return $self->SUPER::as_string() . ';';
}

1;
