#!perl
use 5.006;
use strict;
use warnings FATAL => 'all';
use lib 't';
use Test::More;
use Test::Exception;

use lib 'lib';
use Mail::AuthenticationResults::Parser;

my $Parsed;

my @Strings = (
    'text.example.com = = test;',
    'text.example.com foo = = bar;',
    'text.example.com . bar = test;',
    'text.example.com foo . bar = test;',
    'text.example.com foo / bar = test;',
    'text.example.com foo bar = test;',
    'test.example.com; foo = = bar;',

);

foreach my $String ( @Strings ) {
    dies_ok( sub{ $Parsed = Mail::AuthenticationResults::Parser->new()->parse( $String ) }, $String );
}

done_testing();

