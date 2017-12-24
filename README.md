# NAME

Mail::AuthenticationResults - Object Oriented Authentication-Results header class

# DESCRIPTION

Object Oriented Authentication-Results email headers

[![Code on GitHub](https://img.shields.io/badge/github-repo-blue.svg)](https://github.com/marcbradshaw/Mail-AuthenticationResults)

[![Build Status](https://travis-ci.org/marcbradshaw/Mail-AuthenticationResults.svg?branch=master)](https://travis-ci.org/marcbradshaw/Mail-AuthenticationResults)

[![Open Issues](https://img.shields.io/github/issues/marcbradshaw/Mail-AuthenticationResults.svg)](https://github.com/marcbradshaw/Mail-AuthenticationResults/issues)

[![Dist on CPAN](https://img.shields.io/cpan/v/Mail-AuthenticationResults.svg)](https://metacpan.org/release/Mail-AuthenticationResults)

[![CPANTS](https://img.shields.io/badge/cpants-kwalitee-blue.svg)](http://cpants.cpanauthors.org/dist/Mail-AuthenticationResults)

# SYNOPSIS

    use Mail::AuthenticationResults;

# CONSTRUCTOR

- new()

    Return a new Mail::AuthenticationResults object

# PUBLIC METHODS

- parser( $auth\_results )

    Returns a new Mail::AuthenticationResults::Parser object
    for the supplied $auth\_results header

# DEPENDENCIES

    Carp
    Scalar::Util

# BUGS

Please report bugs via the github tracker.

https://github.com/marcbradshaw/Mail-AuthenticationResults/issues

# AUTHORS

Marc Bradshaw, <marc@marcbradshaw.net>

# COPYRIGHT

Copyright (c) 2017, Marc Bradshaw.

# LICENCE

This library is free software; you may redistribute it and/or modify it
under the same terms as Perl itself.
