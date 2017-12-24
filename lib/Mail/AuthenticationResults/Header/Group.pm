package Mail::AuthenticationResults::Header::Group;
# VERSION
use strict;
use warnings;

use Carp;

sub HAS_CHILDREN{ return 1; }

use base 'Mail::AuthenticationResults::Header::Base';

sub add_child {
    my ( $self, $child ) = @_;
    croak 'Does not have children' if ! $self->HAS_CHILDREN();
    if ( ref $child eq 'Mail::AuthenticationResults::Header::Group' ) {
        foreach my $subchild ( @{ $child->children() } ) {
            push @{ $self->{ 'children' } }, $subchild;
        }
    }
    else {
        push @{ $self->{ 'children' } }, $child;
    }

    return $child;
}

sub as_string {
    my ( $self ) = @_;
    my $string = q{};
    return join( ";\n", map { $_->as_string() } @{ $self->children() } );
}

1;

