package Not8;

use JSON qw/encode_json/;

use Not8::DataService;
use Not8::Model::Note;

use Dancer2;
use Dancer2::Plugin::LogReport;

our $VERSION = '0.1';

get '/' => sub {
    content_type 'application/json';
    encode_json({
        error => 0,
        message => 'Hello from Backend!'
    });
};

1;
