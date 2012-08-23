#!/usr/bin/perl
use v5.14;
use TAP::Harness;

my @MODULES_TO_TEST = (
    'ParseRecDescent',
);

my $harness = TAP::Harness->new({
    lib => [ './lib' ],
    test_args => {
        Evaluator => [],
        Tokenizer => [],
        map { $_ => [ $_ ] } @MODULES_TO_TEST
    },
});
$harness->runtests( 
    [ 'test_evaluator.pl', 'Evaluator' ],
    [ 'test_tokenizer.pl', 'Tokenizer' ],
    map {
        [ 'test_parser_impl.pl', $_ ],
    } @MODULES_TO_TEST
);
