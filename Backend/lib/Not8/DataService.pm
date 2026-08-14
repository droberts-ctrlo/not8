package Not8::DataService;

use strict;
use warnings;

use Not8::DataStore;
use Not8::Model::Note;

use Moo;

use Log::Report;

has _datastore => (
    is => 'lazy',
    builder => sub { Not8::DataStore->new() },
);

sub count {
    my $self = shift;
    my $result = $self->_datastore->get_all;
    return $result;
}

sub add_item {
    my ($self, %args) = @_;
    my $id = $args{id} // 0;
    my $title = $args{title};
    my $content = $args{content};

    error "Content is required" unless defined $content;

    my $note = Not8::Model::Note->new(
        id => $id,
        title => $title,
        content => $content,
    );

    $self->_datastore->add($note);
}

sub get_all {
    my $self = shift;
    my @result = $self->_datastore->get_all();
    return @result;
}

sub get_one {
    my ($self, $id) = @_;
    $self->_datastore->get_one($id);
}

sub delete {
    my ($self, $id) = @_;
    my $item = $self->get_one($id);
    return unless $item; # Return if item does not exist
    $self->_datastore->remove($item);
}

sub update {
    my ($self, $id, %args) = @_;
    my $item = $self->get_one($id);
    return unless $item; # Return if item does not exist

    my $new_title = $args{title} // $item->title;
    my $new_content = $args{content} // $item->content;

    my $updated_item = Not8::Model::Note->new(
        id => $id,
        title => $new_title,
        content => $new_content,
    );

    $self->_datastore->update($item, $updated_item);
}

1;