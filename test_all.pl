#!/usr/bin/perl
use v5.14;
use TAP::Harness;

my @MODULES_TO_TEST = (
    'ParseRecDescent',
);

my $harness = TAP::Harness->new({
    lib => [ '.' ],
    test_args => {
        map { $_ => [ $_ ] } @MODULES_TO_TEST
    },
});
$harness->runtests( map {
    [ 'test.pl', $_ ],
} @MODULES_TO_TEST );
