package Mail::AuthenticationResults::Header::Entry;
# ABSTRACT: Class modelling Main Entry parts of the Authentication Results Header

require 5.010;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ refaddr };
use Carp;

use base 'Mail::AuthenticationResults::Header::Base';

sub HAS_KEY{ return 1; }
sub HAS_VALUE{ return 1; }
sub HAS_CHILDREN{ return 1; }

sub ALLOWED_CHILDREN {
    my ( $self, $child ) = @_;
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Comment';
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::SubEntry';
    return 1 if ref $child eq 'Mail::AuthenticationResults::Header::Version';
    return 0;
}

1;
