package Mail::AuthenticationResults::Header;
# VERSION
use strict;
use warnings;

use Carp;

sub HAS_VALUE{ return 1; }
sub HAS_CHILDREN{ return 1; }

use base 'Mail::AuthenticationResults::Header::Base';

sub as_string {
    my ( $self ) = @_;
    my $string = q{};
    return join( ";\n", map { $_->as_string() } @{ $self->children() } );
}

1;
