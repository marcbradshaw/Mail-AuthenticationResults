#!perl
use 5.006;
use strict;
use warnings FATAL => 'all';
use lib 't';
use Test::More;
use Test::Exception;

use lib 'lib';
use Mail::AuthenticationResults::Parser;

my $ARHeader = 'Authentication-Results: spf=pass (sender IP is 66.111.4.222)
 smtp.mailfrom=fastmail.com; outlook.com; dkim=pass (signature was verified)
 header.d=fastmail.com;outlook.com; dmarc=pass action=none
 header.from=fastmail.com;';

my $Parsed;
#lives_ok( sub{ $Parsed = Mail::AuthenticationResults::Parser->new()->parse( $ARHeader ) }, 'Parse lives' );
dies_ok( sub{ $Parsed = Mail::AuthenticationResults::Parser->new()->parse( $ARHeader ) }, 'Parse throws' );
#outlook header is not to the expected spec

#is ( $Parsed->value(), 'outlook.com', 'ServID' );
#is ( scalar @{$Parsed->search({ 'key'=>'spf','value'=>'pass' })->children() }, 1, 'SPF Pass' );
#is ( scalar @{$Parsed->search({ 'key'=>'dkim','value'=>'pass' })->search({ 'key'=>'header.d','value'=>'fastmail.com' })->children() }, 1, 'DKIM fastmail.com Pass' );
#is ( scalar @{$Parsed->search({ 'key'=>'dkim','value'=>'pass' })->search({ 'key'=>'header.d','value'=>'messagingengine.com' })->children() }, 1, 'DKIM messagingengine.com Pass' );
#is ( scalar @{$Parsed->search({ 'key'=>'dmarc','value'=>'pass' })->children() }, 1, 'DMARC Pass' );

done_testing();


