use warnings;
use strict;

use Dancer2;

use FindBin qw/$Bin/;

use lib "$Bin/../lib";

use Not8;

Not8->dance;

1;