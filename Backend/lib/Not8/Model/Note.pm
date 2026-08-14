package Not8::Model::Note;

use strict;
use warnings;

use Moo;

has id => (
    is => 'rw',
    default => sub { 0 },
);

has title => (
    is => 'rw',
    required => 0,
    default => sub { '' },
);

has content => (
    is => 'rw',
    required => 1,
);

1;
