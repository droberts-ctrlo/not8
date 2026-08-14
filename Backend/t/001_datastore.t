#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 19;

use FindBin qw/$Bin/;

use lib "$Bin/../lib";

require_ok 'Not8::DataStore';
require_ok 'Not8::Model::Note';

my $store = Not8::DataStore->new;
ok $store, 'DataStore object created';

my $item = Not8::Model::Note->new(
    title => 'Test Note',
    content => 'This is a test note.',
);

is $item->id, 0, 'New note has id 0';

my $added_item = $store->add($item);

is $added_item->id, 1, 'Added note has id 1';

my $list = $store->get_all;
is $list, 1, 'Store has 1 item - scalar context';

my @other_list = $store->get_all;
is scalar(@other_list), 1, 'Store has 1 item - array context';

is $other_list[0]->title, 'Test Note', 'First item has correct title';
is $other_list[0]->content, 'This is a test note.', 'First item has correct content';

my $item_by_id = $store->get_one(1);

is $item_by_id->id, 1, 'get_one returns correct item by id';
is $item_by_id->title, 'Test Note', 'get_one returns correct item title by id';
is $item_by_id->content, 'This is a test note.', 'get_one returns correct item content by id';

my $invalid_item = $store->get_one(999);
is $invalid_item, undef, 'get_one returns undef for non-existent id';

my $new_item = Not8::Model::Note->new(
    id => 1,
    title => 'Updated Note',
    content => 'This note has been updated.',
);
my $updated_item = $store->update($item_by_id, $new_item);
is $updated_item->title, 'Updated Note', 'update returns updated item with new title';
is $updated_item->content, 'This note has been updated.', 'update returns updated item with new content';

my $item_after_update = $store->get_one(1);
is $item_after_update->title, 'Updated Note', 'Item after update has new title';
is $item_after_update->content, 'This note has been updated.', 'Item after update has new content';

$store->remove($item_after_update);
my $list_after_removal = $store->get_all;
is $list_after_removal, 0, 'Store has 0 items after removal';

my @other_list_after_removal = $store->get_all;
is scalar(@other_list_after_removal), 0, 'Store has 0 items after removal - array context';

done_testing;
