package Mail::AuthenticationResults::Header::Comment;
# ABSTRACT: Class modelling Comment parts of the Authentication Results Header

require 5.010;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ weaken };
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

=head1 DESCRIPTION

Comments may be associated with many parts of the Authentication Results set, this
class represents a comment.

Please see L<Mail::AuthenticationResults::Header::Base>

=cut

sub _HAS_VALUE{ return 1; }

sub safe_set_value {
    my ( $self, $value ) = @_;
    $self->set_value( $self->_safe_value( $value, { ' ' => 1, } ) );
    return $self;
}

sub set_value {
    my ( $self, $value ) = @_;

    my $remain = $value;
    my $depth = 0;
    while ( length $remain > 0 ) {
        my $first = substr( $remain,0,1 );
        $remain   = substr( $remain,1 );
        $depth++ if $first eq '(';
        $depth-- if $first eq ')';
        croak 'Out of order parent in comment' if $depth == -1;
    }
    croak 'Mismatched parens in comment' if $depth != 0;

    $self->{ 'value' } = $value;
    return $self;
}

sub as_string {
    my ( $self ) = @_;
    my $string = '(' . $self->value() . ')';
    return $string;
}

1;
