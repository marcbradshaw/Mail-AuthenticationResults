package Mail::AuthenticationResults::Header::Base;
use strict;
use warnings;
use version; our $VERSION = version->declare('v1.0.0');
use Scalar::Util qw{ weaken };

sub new {
    my ( $class, $self ) = @_;
    $self = {} if ! $self;
    bless $self, $class;
    return $self;
}

sub key {
    my ( $self ) = @_;
    return $self->{ 'key' } // q{};
}

sub value {
    my ( $self ) = @_;
    return $self->{ 'value' } // q{};
}

sub children {
    my ( $self ) = @_;
    return $self->{ 'children' } // [];
}

sub add_child {
    my ( $self, $child ) = @_;
    $child->{ 'parent' } = $self;
    weaken $child->{ 'parent' };
    push @{ $self->{ 'children' } }, $child;
    return;
}

sub as_string {
    my ( $self ) = @_;
    my $string = $self->key() . '=' . $self->value();
    foreach my $child ( @{$self->children()} ) {
        $string .= ' ' . $child->as_string();
    }
    return $string;
}

1;
