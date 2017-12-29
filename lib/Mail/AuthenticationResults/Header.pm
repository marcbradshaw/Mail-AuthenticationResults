package Mail::AuthenticationResults::Header;
require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use Mail::AuthenticationResults::Header::AuthServID;

use base 'Mail::AuthenticationResults::Header::Base';

sub HAS_VALUE{ return 1; }
sub HAS_CHILDREN{ return 1; }

sub ALLOWED_CHILDREN {
    my ( $self, $parent ) = @_;
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Entry';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Comment';
    return 0;
}

sub set_value {
    my ( $self, $value ) = @_;
    croak 'Does not have value' if ! $self->HAS_VALUE();
    croak 'Value cannot be undefined' if ! defined $value;
    #if ( ref $value ne 'Mail::AuthentictionResults::Header::AuthServID' ) {
    #    $value = Mail::AuthenticationResults::Header::AuthServID->new()->set_value( $value );
    #}
    croak 'value should be an AuthServID type' if ref $value ne 'Mail::AuthenticationResults::Header::AuthServID';
    $self->{ 'value' } = $value;
    return $self;
}

sub add_parent {
    my ( $self, $parent ) = @_;
    return if ref $parent eq 'Mail::AuthenticationResults::Header::Group';
    croak 'Cannot add top level class as a child';
    return; # uncoverable statement
}

sub add_child {
    my ( $self, $child ) = @_;
    croak 'Cannot add a SubEntry as a child of a Header' if ref $child eq 'Mail::AuthenticationResults::Header::SubEntry';
    return $self->SUPER::add_child( $child );
}

sub as_string {
    my ( $self ) = @_;
    my $string = q{};
    my $value = q{};
    if ( $self->value() ) {
        $value = $self->value()->as_string();
    }
    return $value . ";\n" . join( ";\n", map { $_->as_string() } @{ $self->children() } );
}

1;
