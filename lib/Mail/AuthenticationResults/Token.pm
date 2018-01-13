package Mail::AuthenticationResults::Token;
# ABSTRACT: Base class for modelling AuthenticationResults Header parts

require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

=method new( $header, $args )

Return a new Token object parsed from the given $header string using $args

$args value depend on the subclass of Token used

=cut

sub new {
    my ( $class, $header, $args ) = @_;

    my $self = { 'args' => $args };
    bless $self, $class;

    $self->{ 'header' } = $header;
    $self->parse();

    return $self;
}

=method value()

Return the value of the current Token instance.

=cut

sub value {
    my ( $self ) = @_;
    return $self->{ 'value' };
}

=method remainder()

Return the remainder of the header string after parsing the current token out.

=cut

sub remainder {
    my ( $self ) = @_;
    return $self->{ 'header' };
}

=method parse()

Run the parser on the current $header and set up value() and remainder().

=cut

sub parse {
    my ( $self ) = @_;
    croak 'parse not implemented';
}

=method is()

Return the type of token we are.

=cut

sub is { # uncoverable subroutine
    # a base Token cannot be instantiated, and all subclasses should implement this method.
    my ( $self ) = @_; # uncoverable statement
    croak 'is not implemented'; # uncoverable statement
}

1;;

