#!perl
use 5.006;
use strict;
use warnings FATAL => 'all';
use lib 't';
use Test::More;

use lib 'lib';
use Mail::AuthenticationResults::Parser;

plan tests => 1;

chdir 't';

my $Input = [
  'iprev=fail policy.iprev=123.123.123.123 (NOT FOUND)',
  'x-ptr=fail x-ptr-helo=bad.name.google.com x-ptr-lookup=',
  'spf=fail smtp.mailfrom=test@goestheweasel.com smtp.helo=bad.name.google.com',
  'dkim=none (no signatures found)',
  'x-google-dkim=none (no signatures found)',
  'dmarc=fail (p=none,d=none) header.from=marcbradshaw.net',
  'dmarc=fail (p=reject,d=reject) header.from=goestheweasel.com',
  'dmarc=none (p=none,d=none) header.from=example.com'
];

my $Parser = Mail::AuthenticationResults::Parser->new( $Input );

is( $Parser->as_string(), join( ";\n", @$Input ) . ';', 'As String' );

use Data::Dumper;
#print Dumper $Parser;

#print "\n\n";
#print $Parser->as_string();
#print "\n\n";

