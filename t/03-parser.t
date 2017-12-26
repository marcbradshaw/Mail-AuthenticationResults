#!perl
use 5.006;
use strict;
use warnings FATAL => 'all';
use lib 't';
use Test::More;
use Test::Exception;

use lib 'lib';
use Mail::AuthenticationResults::Parser;

my $Parsed = Mail::AuthenticationResults::Parser->new()->parse( ' test.example.com ; foo=bar;dkim=fail ;one=;dmarc=pass' );
my $Result = $Parsed->as_string();
is( $Result, "test.example.com;\nfoo=bar;\ndkim=fail;\none=;\ndmarc=pass", 'Result ok' );

done_testing();

