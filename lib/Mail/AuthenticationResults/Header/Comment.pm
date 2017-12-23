package Mail::AuthenticationResults::Header::Comment;
use strict;
use warnings;
use version; our $VERSION = version->declare('v1.0.0');
use Scalar::Util qw{ weaken };

use base 'Mail::AuthenticationResults::Header::Base';

sub as_string {
    my ( $self ) = @_;
    my $string = '(' . $self->value() . ')';
    return $string;
}

sub add_child {
    my ( $self ) = @_;
    die 'cannot add a child to a comment';
}

1;
