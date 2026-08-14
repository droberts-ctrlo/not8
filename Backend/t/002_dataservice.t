#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 25;

use FindBin qw($Bin);
use lib "$Bin/../lib";

require_ok 'Not8::DataService';

my $service = Not8::DataService->new();

eval { $service->add_item(title=>'This is a test note') };
ok($@, "Error thrown when content is missing");

my $added_note = $service->add_item(content=>'This is the content of the test note');
ok $added_note, "Note added successfully";
is $added_note->id, 1, "Note ID is 1";

my $added_note_2 = $service->add_item(title => 'Second Test Note', content=>'This is the content of the second test note');
ok $added_note_2, "Second note added successfully";
is $added_note_2->id, 2, "Second note ID is 2";

is $service->count, 2, "Total note count is 2";

my @all_notes = $service->get_all();
is scalar (@all_notes), $service->count, "Retrieved all notes successfully";
is $all_notes[0]->title, undef, "First note title is undefined";
is $all_notes[1]->title, 'Second Test Note', "Second note title is correct";
is $all_notes[0]->content, 'This is the content of the test note', "First note content is correct";
is $all_notes[1]->content, 'This is the content of the second test note', "Second note content is correct";

my $first_note = $service->get_one(1);
ok $first_note, "Retrieved first note successfully";
is $first_note->content, 'This is the content of the test note', "First note content is correct";

my $second_note = $service->get_one(2);
ok $second_note, "Retrieved second note successfully";
is $second_note->title, "Second Test Note", "Second note title is correct";
is $second_note->content, "This is the content of the second test note", "Second note content is correct";

my $nonexistent_note = $service->get_one(999);
ok !defined $nonexistent_note, "Non-existent note retrieval returns undef";

my $updated_note = $service->update(1, title => 'Updated Test Note', content => 'Updated content of the test note');
ok $updated_note, "Note updated successfully";
is $updated_note->title, 'Updated Test Note', "Updated note title is correct";
is $updated_note->content, 'Updated content of the test note', "Updated note content is correct";

my $updated_fetch = $service->get_one(1);
is $updated_fetch->title, 'Updated Test Note', "Fetched updated note title is correct";
is $updated_fetch->content, 'Updated content of the test note', "Fetched updated note content is correct";

$service->delete(1);
my $deleted_note = $service->get_one(1);
ok !defined $deleted_note, "Deleted note retrieval returns undef";

is $service->count, 1, "Total note count is 1 after deletion";

done_testing();
