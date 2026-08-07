use strict;
use warnings;

use Test::Compile qw//;

my $test = Test::Compile->new();
$test->ok($test->all_pm_files_ok('../lib/Not8.pm'));
$test->done_testing();

1;
