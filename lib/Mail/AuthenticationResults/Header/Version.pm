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

    if ( ! $self->value() ) {
        return q{};
    }

    my $string = q{};

    if ( ref $self->parent() ne 'Mail::AuthenticationResults::Header::AuthServID' ) {
        $string = '/ ';
    }

    $string .= $self->value();

    return $string;
}

sub set_value {
    my ( $self, $value ) = @_;

    croak 'Does not have value' if ! $self->HAS_VALUE(); # uncoverable branch true
    # HAS_VALUE is 1 for this class
    croak 'Value cannot be undefined' if ! defined $value;
    croak 'Value must be numeric' if $value =~ /[^0-9]/;

    $self->{ 'value' } = $value;
    return $self;
}

1;
