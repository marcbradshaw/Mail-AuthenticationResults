package Mail::AuthenticationResults::Header::AuthServID;
# ABSTRACT: Class modelling the AuthServID part of the Authentication Results Headerr

require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

=head1 DESCRIPTION

The AuthServID is typically the first section of an Authentication Results Header, it records
the server responsible for performing the Authentication Results checks, and can additionally hold
a version number (assumed to be 1 if not present).

Some providers also add additional sub entries to the field, hence this class is capable of
being a parent to version, comment, and sub entry types.

This class is set as the value for a Mail::AuthenticationResults::Header class.

Please see L<Mail::AuthenticationResults::Header::Base>

=cut

sub _HAS_VALUE{ return 1; }

sub _HAS_CHILDREN{ return 1; }

sub _ALLOWED_CHILDREN {
    my ( $self, $child ) = @_;
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Comment';
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::SubEntry';
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Version';
    return 0;
}

sub as_string {
    my ( $self ) = @_;
    my $string = q{};
    return join( ' ', $self->stringify( $self->value() ), map { $_->as_string() } @{ $self->children() } );
}

1;
