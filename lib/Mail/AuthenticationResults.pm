package Mail::AuthenticationResults;

use strict;
use warnings;

use version; our $VERSION = version->declare('v1.0.0');

use Mail::AuthenticationResults::Header::Parser;

sub new {
    my ( $class ) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub parser {
    my ( $self, $auth_headers ) = @_;
    return Mail::AuthenticationResults::Parser->new( $auth_headers );
}

1;
