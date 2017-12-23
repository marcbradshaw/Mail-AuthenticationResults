package Mail::AuthenticationResults::Parser;
use strict;
use warnings;
use version; our $VERSION = version->declare('v1.0.0');

use Mail::AuthenticationResults::Header;
use Mail::AuthenticationResults::Header::Entry;
use Mail::AuthenticationResults::Header::SubEntry;
use Mail::AuthenticationResults::Header::Comment;

sub new {
    my ( $class, $auth_headers ) = @_;
    my $self = {};
    bless $self, $class;

    $self->{ 'header' } = Mail::AuthenticationResults::Header->new();
    foreach my $auth_header ( @$auth_headers ) {
        my $acting_on = Mail::AuthenticationResults::Header::Entry->new();
        $self->_parse_auth_header( \$acting_on, $auth_header );
        $self->{ 'header' }->add_child( $acting_on );
    }

    return $self;
}

sub as_data {
    my ( $self ) = @_;
    return $self->{ 'header' };
}

sub _parse_auth_header {
    my ($self,$acting_on,$header) = @_;

    # class entry/comment
    # key
    # value

    my $key;
    my $value;

    ( $key, $value, $header ) = $self->_parse_auth_header_entry( $header );
    ${$acting_on}->{ 'key' }   = $key;
    ${$acting_on}->{ 'value' } = $value;

    $header = q{} if ! $header;

    my $comment_on = $acting_on;

    while ( length($header) > 0 ) {
        $header =~ s/^\s+//;
        if ( $header =~ /^\(/ ) {
            # We have a comment
            my $comment;
            ( $comment, $header ) = $self->_parse_auth_header_comment( $header );
            my $entry = Mail::AuthenticationResults::Header::Comment->new({
                'value' => $comment,
            });
            ${$comment_on}->add_child( $entry );
        }
        else {
            # We have another entry
            ( $key, $value, $header ) = $self->_parse_auth_header_entry( $header );
            my $entry = Mail::AuthenticationResults::Header::SubEntry->new({
                'key'      => $key,
                'value'    => $value,
            });
            $comment_on = \$entry;
            ${$acting_on}->add_child( $entry );
        }
        $header = q{} if ! $header;
    }

    return;
}

sub _parse_auth_header_comment {
    my ($self,$remain) = @_;
    my $value = q{};
    my $depth = 0;

    while ( length $remain > 0 ) {
        my $first = substr( $remain,0,1 );
        $remain   = substr( $remain,1 );
        $value .= $first;
        if ( $first eq '(' ) {
            $depth++;
        }
        elsif ( $first eq ')' ) {
            $depth--;
            last if $depth == 0;
        }
    }

    $value =~ s/^\(//;
    $value =~ s/\)$//;

    return($value,$remain);
}

sub _parse_auth_header_entry {
    my ($self,$remain) = @_;
    my $key;
    my $value;
    ( $key, $remain )   = split( '=', $remain, 2 );
    $remain = q{} if ! defined $remain;
    ( $value, $remain ) = split( ' ', $remain, 2 );

    return ($key,$value,$remain);
}

1;
