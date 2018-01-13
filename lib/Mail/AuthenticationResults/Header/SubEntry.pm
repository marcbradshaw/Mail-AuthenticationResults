package Mail::AuthenticationResults::Header::SubEntry;
# ABSTRACT: Class modelling Sub Entry parts of the Authentication Results Header

require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

=head1 DESCRIPTION

A sub entry is a result which relates to a main entry class, for example if the
main entry is "dkim=pass" then the sub entry may be "domain.d=example.com"

There may be comments associated with the subentry as children.

Please see L<Mail::AuthenticationResults::Header::Base>

=cut

sub _HAS_KEY{ return 1; }
sub _HAS_VALUE{ return 1; }
sub _HAS_CHILDREN{ return 1; }

sub _ALLOWED_CHILDREN {
    my ( $self, $child ) = @_;
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Comment';
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Version';
    return 0;
}

1;
