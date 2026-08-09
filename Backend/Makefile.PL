#Basic makefile for Not8 Backend

use ExtUtils::MakeMaker;

our %PREREQ_PM = (
    Dancer2                      => 0,
    'Dancer2::Plugin::LogReport' => 0,
    JSON => 0,
    Moo => 0,
    
);

our %TEST_REQUIRES = (
    'Test::More'    => 0,
    'Test::Compile' => 0,
);

WriteMakefile(
    NAME => 'Not8::Backend',
    VERSION_FROM => 'lib/Not8.pm', # finds $VERSION
    PREREQ_PM => \%PREREQ_PM,
    TEST_REQUIRES => \%TEST_REQUIRES,
);
