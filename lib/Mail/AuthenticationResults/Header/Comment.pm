package Mail::AuthenticationResults::Header::Comment;
use strict;
use warnings;
# VERSION
use Scalar::Util qw{ weaken };

sub HAS_VALUE{ return 1; }

use base 'Mail::AuthenticationResults::Header::Base';

sub as_string {
    my ( $self ) = @_;
    my $string = '(' . $self->value() . ')';
    return $string;
}

1;
