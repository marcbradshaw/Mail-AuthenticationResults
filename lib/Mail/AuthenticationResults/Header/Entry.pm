package Mail::AuthenticationResults::Header::Entry;
# ABSTRACT: Class modelling Main Entry parts of the Authentication Results Header

require 5.010;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ refaddr };
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

=head1 DESCRIPTION

Entries are the main result of an Authentication Resutls check, an example of this
would be "dkim=pass" or "dmarc=fail", there may be additional comments of sub entries
associated with this entry, these are represented as children of this class.

Please see L<Mail::AuthenticationResults::Header::Base>

=cut

sub _HAS_KEY{ return 1; }
sub _HAS_VALUE{ return 1; }
sub _HAS_CHILDREN{ return 1; }

sub _ALLOWED_CHILDREN {
    my ( $self, $child ) = @_;
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Comment';
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::SubEntry';
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Version';
    return 0;
}

1;
