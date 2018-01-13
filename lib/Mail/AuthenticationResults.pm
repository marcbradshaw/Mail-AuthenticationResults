package Mail::AuthenticationResults;
# ABSTRACT: Object Oriented Authentication-Results Headers

require 5.010;
use strict;
use warnings;
# VERSION
use Carp;

use Mail::AuthenticationResults::Parser;

=head1 DESCRIPTION

Object Oriented Authentication-Results email headers.

This parser copes with most styles of Authentication-Results header seen in the wild, but is not yet fully RFC7601 compliant

Differences from RFC7601

key/value pairs are parsed when present in the authserv-id section, this is against RFC but has been seen in headers added by Yahoo!.

Comments added between key/value pairs will be added after them in the data structures and when stringified.


It is a work in progress..

=for markdown [![Code on GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/marcbradshaw/Mail-AuthenticationResults)

=for markdown [![Build Status](https://travis-ci.org/marcbradshaw/Mail-AuthenticationResults.svg?branch=master)](https://travis-ci.org/marcbradshaw/Mail-AuthenticationResults)

=for markdown [![Open Issues](https://img.shields.io/github/issues/marcbradshaw/Mail-AuthenticationResults.svg)](https://github.com/marcbradshaw/Mail-AuthenticationResults/issues)

=for markdown [![Dist on CPAN](https://img.shields.io/cpan/v/Mail-AuthenticationResults.svg)](https://metacpan.org/release/Mail-AuthenticationResults)

=for markdown [![CPANTS](https://img.shields.io/badge/cpants-kwalitee-blue.svg)](http://cpants.cpanauthors.org/dist/Mail-AuthenticationResults)

=head1 BUGS

Please report bugs via the github tracker.

https://github.com/marcbradshaw/Mail-AuthenticationResults/issues

=method new()

Return a new Mail::AuthenticationResults object

=cut

sub new {
    my ( $class ) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

=method parser()

Returns a new Mail::AuthenticationResults::Parser object
for the supplied $auth_results header

=cut

sub parser {
    my ( $self, $auth_headers ) = @_;
    return Mail::AuthenticationResults::Parser->new( $auth_headers );
}

1;

