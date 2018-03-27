package Mail::AuthenticationResults::Token::Space;
# ABSTRACT: Class for modelling AuthenticationResults Header parts detected as spaces

require 5.008;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Token';

=head1 DESCRIPTION

Token representing a space

=cut

sub is {
    my ( $self ) = @_;
    return 'space';
}

sub new {
    my ($self) = @_;
    croak 'Space tokens are not used in parsing';
}

sub parse {
    my ($self) = @_;
    croak 'Space tokens are not used in parsing';
}

sub remainder {
    my ($self) = @_;
    croak 'Space tokens are not used in parsing';
}


1;

