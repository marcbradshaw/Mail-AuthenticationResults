package Mail::AuthenticationResults::Token::Assignment;
require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Token';

sub is {
    my ( $self ) = @_;
    return 'assignment';
}

sub parse {
    my ($self) = @_;

    my $header = $self->{ 'header' };
    my $value = q{};

    my $first = substr( $header,0,1 );
    croak 'not an assignment' if $first ne '=';

    $header   = substr( $header,1 );

    $self->{ 'value' } = '=';
    $self->{ 'header' } = $header;

    return;
}

1;

