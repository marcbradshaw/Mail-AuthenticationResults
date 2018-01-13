package Mail::AuthenticationResults::Token::String;
# ABSTRACT: Class for modelling AuthenticationResults Header parts detected as strings

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

    croak 'Not a string' if $header =~ /^"/;
    croak 'Not a string' if $header =~ /^\(/;

    # Parse differently if we are post assignment (we are a value) or not (we are likely a key or key part)
    my $is_value = 0;
    my $is_first = 0;
    if ( exists ( $self->{ 'args' }->{ 'last_non_comment_type' } ) ) {
        if ( $self->{ 'args' }->{ 'last_non_comment_type' }->is() eq 'assignment' ) {
            if ( $self->{ 'args' }->{ 'last_non_comment_type' }->value() eq '=' ) {
                $is_value = 1;
            }
        }
    }
    else {
        $is_first = 1;
    }

    while ( length $header > 0 ) {
        my $first = substr( $header,0,1 );
        last if $first =~ /\s/;
        last if $first eq ';';
        last if $first eq '"' && ! $is_value && ! $is_first;
        last if $first eq '(' && ! $is_value && ! $is_first;
        last if $first eq '=' && ! $is_value && ! $is_first;
        last if $first eq '/' && ! $is_value && ! $is_first;
        last if $first eq '.' && ! $is_value && ! $is_first;

        $value .= $first;
        $header   = substr( $header,1 );
    }

    croak 'Not a string' if $value eq q{};

    $self->{ 'value' } = $value;
    $self->{ 'header' } = $header;

    return;
}

1;

