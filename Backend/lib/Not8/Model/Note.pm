package Not8::Model::Note;

use strict;
use warnings;

use Moo;

has id => (
    is => 'ro',
    required => 1,
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
