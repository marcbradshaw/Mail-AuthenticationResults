package Mail::AuthenticationResults::Header::Version;
require 5.010;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ weaken };
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

sub HAS_VALUE{ return 1; }

sub as_string {
    my ( $self ) = @_;
    return $self->value();
}

sub set_value {
    my ( $self, $value ) = @_;

    croak 'Does not have value' if ! $self->HAS_VALUE();
    croak 'Value cannot be undefined' if ! defined $value;
    croak 'Value must be numeric' if ! $value =~ /^[0-9]+$/;

    $self->{ 'value' } = $value;
    return $self;
}

1;
