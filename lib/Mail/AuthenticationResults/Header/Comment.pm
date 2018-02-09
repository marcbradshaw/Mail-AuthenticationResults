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

    $value = q{} if ! defined $value;

    $value =~ s/\t/ /g;
    $value =~ s/\n/ /g;
    $value =~ s/\r/ /g;

    my $remain = $value;
    my $depth = 0;
    my $nested_ok = 1;
    while ( length $remain > 0 ) {
        my $first = substr( $remain,0,1 );
        $remain   = substr( $remain,1 );
        $depth++ if $first eq '(';
        $depth-- if $first eq ')';
        $nested_ok = 0 if $depth == -1;
    }
    $nested_ok = 0 if $depth != 0;

    # Remove parens if nested comments would be broken by them.
    if ( ! $nested_ok ) {
        $value =~ s/\(/ /g;
        $value =~ s/\)/ /g;
    }

    $value =~ s/^\s+//;
    $value =~ s/\s+$//;
    #$value =~ s/;/ /g;

    $self->set_value( $value );
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
        croak 'Out of order parens in comment' if $depth == -1;
    }
    croak 'Mismatched parens in comment' if $depth != 0;
    croak 'Invalid characters in value' if $value =~ /\n/;
    croak 'Invalid characters in value' if $value =~ /\r/;

    $self->{ 'value' } = $value;
    return $self;
}

sub as_string {
    my ( $self ) = @_;
    my $string = '(' . $self->value() . ')';
    return $string;
}

1;
