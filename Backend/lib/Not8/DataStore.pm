package Not8::DataStore;

use strict;
use warnings;

use Moo;

has _store => (
    is => 'ro',
    default => sub { [] },
);

sub _get_id {
    my $self = shift;
    my $max = 0;
    for my $item (@{$self->_store}) {
        $max = $item->id if $item->id > $max;
    }
    return $max + 1;
}

sub add {
    my ($self, $item) = @_;
    $item->id($self->_get_id)
        if $item->id == 0 || !defined $item->id;
    push @{$self->_store}, $item;
    return $item;
}

sub remove {
    my ($self, $item) = @_;
    @{$self->_store} = grep { $_ ne $item } @{$self->_store};
}

sub get_all {
    my ($self) = @_;
    return wantarray ? @{$self->_store} : scalar(@{$self->_store});
}

sub get_one {
    my ($self, $id) = @_;
    for my $item (@{$self->_store}) {
        return $item if $item->id == $id;
    }
    return undef;
}

sub update {
    my ($self, $old_item, $new_item) = @_;
    die "Cannot update item with different id"
        if $old_item->id != $new_item->id;
    for my $i (0 .. $#{$self->_store}) {
        if ($self->_store->[$i] eq $old_item) {
            $self->_store->[$i] = $new_item;
            last;
        }
    }
    return $new_item;
}

1;
