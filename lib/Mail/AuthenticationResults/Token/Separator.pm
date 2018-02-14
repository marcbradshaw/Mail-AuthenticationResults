package Mail::AuthenticationResults::Token::Separator;
# ABSTRACT: Class for modelling AuthenticationResults Header parts detected as quoted separators

require 5.008;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Token';

=head1 DESCRIPTION

Token representing a separator

=cut

sub is {
    my ( $self ) = @_;
    return 'separator';
}

sub parse {
    my ($self) = @_;

    my $header = $self->{ 'header' };
    my $value = q{};

    my $first = substr( $header,0,1 );
    croak 'not a separator' if $first ne ';';

    $header   = substr( $header,1 );

    $self->{ 'value' } = ';';
    $self->{ 'header' } = $header;

    return;
}

1;

