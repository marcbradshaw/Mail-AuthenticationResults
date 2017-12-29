package Mail::AuthenticationResults::Header::AuthServID;
require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

sub HAS_VALUE{ return 1; }

sub HAS_CHILDREN{ return 1; }

sub ALLOWED_CHILDREN {
    my ( $self, $parent ) = @_;
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::SubEntry';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Version';
    return 1 if ref $parent eq 'Mail::AuthenticationResults::Header::Comment';
    return 0;
}

sub as_string {
    my ( $self ) = @_;
    my $string = q{};
    return join( ' ', $self->value(), map { $_->as_string() } @{ $self->children() } );
}

1;
