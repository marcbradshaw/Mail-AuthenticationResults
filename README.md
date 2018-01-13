# NAME

Mail::AuthenticationResults - Object Oriented Authentication-Results Headers

# VERSION

version 1.20180113

# DESCRIPTION

Object Oriented Authentication-Results email headers.

This parser copes with most styles of Authentication-Results header seen in the wild, but is not yet fully RFC7601 compliant

Differences from RFC7601

key/value pairs are parsed when present in the authserv-id section, this is against RFC but has been seen in headers added by Yahoo!.

Comments added between key/value pairs will be added after them in the data structures and when stringified.

It is a work in progress..

# METHODS

## new()

Return a new Mail::AuthenticationResults object

## parser()

Returns a new Mail::AuthenticationResults::Parser object
for the supplied $auth\_results header

[![Code on GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/marcbradshaw/Mail-AuthenticationResults)

[![Build Status](https://travis-ci.org/marcbradshaw/Mail-AuthenticationResults.svg?branch=master)](https://travis-ci.org/marcbradshaw/Mail-AuthenticationResults)

[![Open Issues](https://img.shields.io/github/issues/marcbradshaw/Mail-AuthenticationResults.svg)](https://github.com/marcbradshaw/Mail-AuthenticationResults/issues)

[![Dist on CPAN](https://img.shields.io/cpan/v/Mail-AuthenticationResults.svg)](https://metacpan.org/release/Mail-AuthenticationResults)

[![CPANTS](https://img.shields.io/badge/cpants-kwalitee-blue.svg)](http://cpants.cpanauthors.org/dist/Mail-AuthenticationResults)

# BUGS

Please report bugs via the github tracker.

https://github.com/marcbradshaw/Mail-AuthenticationResults/issues

# AUTHOR

Marc Bradshaw <marc@marcbradshaw.net>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Marc Bradshaw.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
