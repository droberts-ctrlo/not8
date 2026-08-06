package Not8::DataStore;

use strict;
use warnings;

use Moo;

has store => (
    is => 'ro',
    default => sub { [] },
);

sub add {
    my ($self, $item) = @_;
    push @{$self->store}, $item;
}

sub remove {
    my ($self, $item) = @_;
    @{$self->store} = grep { $_ ne $item } @{$self->store};
}

sub get_all {
    my ($self) = @_;
    return @{$self->store};
}

sub update {
    my ($self, $old_item, $new_item) = @_;
    for my $i (0 .. $#{$self->store}) {
        if ($self->store->[$i] eq $old_item) {
            $self->store->[$i] = $new_item;
            last;
        }
    }
}

1;
