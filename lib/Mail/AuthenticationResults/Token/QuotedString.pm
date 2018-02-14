package Mail::AuthenticationResults::Token::QuotedString;
# ABSTRACT: Class for modelling AuthenticationResults Header parts detected as quoted strings

require 5.008;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Token';

=head1 DESCRIPTION

Token representing a quoted string

=cut

sub is {
    my ( $self ) = @_;
    return 'string';
}

sub parse {
    my ($self) = @_;

    my $header = $self->{ 'header' };
    my $value = q{};

    my $first = substr( $header,0,1 );
    $header   = substr( $header,1 );
    croak 'not a quoted string' if $first ne '"';

    my $closed = 0;
    while ( length $header > 0 ) {
        my $first = substr( $header,0,1 );
        $header   = substr( $header,1 );
        if ( $first eq '"' ) {
            $closed = 1;
            last;
        }
        $value .= $first;
    }

    croak 'Quoted string not closed' if ! $closed;

    $self->{ 'value' } = $value;
    $self->{ 'header' } = $header;

    return;
}

1;

