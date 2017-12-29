package Mail::AuthenticationResults::Token::QuotedString;
require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Token';

sub is {
    my ( $self ) = @_;
    return 'string';
}

sub parse {
    my ($self) = @_;

    my $header = $self->{ 'header' };
    my $value = q{};

    my $first = substr( $header,0,1 );
    croak 'not a quoted string' if $first ne '"';

    while ( length $header > 0 ) {
        my $first = substr( $header,0,1 );
        $header   = substr( $header,1 );
        if ( $first eq '"' ) {
            last;
        }
        $value .= $first;
    }

    $self->{ 'value' } = $value;
    $self->{ 'header' } = $header;

    return;
}

1;

