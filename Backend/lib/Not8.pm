package Not8;

use JSON qw/encode_json/;

use Dancer2;

use Not8::DataStore;
use Not8::Model::Note;

our $VERSION = '0.1';

my $datastore = [];

get '/' => sub {
    content_type 'application/json';
    encode_json({
        error => 0,
        message => 'Hello from Backend!'
    });
};

1;
