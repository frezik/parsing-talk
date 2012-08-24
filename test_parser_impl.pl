#!/usr/bin/perl
use v5.14;
use Test::More tests => 15;
use Evaluator ();
use Data::Dumper 'Dumper';

my $MOD = shift or BAIL_OUT "Need a module to test\n";
use_ok( $MOD );

my $eval = Evaluator->new;

my $parser = $MOD->new;
ok( $parser, "Parser returned" );
isa_ok( $parser => $MOD );

my @TESTS = (
    {
        expression => '(+ 1)',
        expect     => [ '+', 1 ],
        eval       => 1,
    },
    {
        expression => '(+ 2 2)',
        expect     => [ '+', 2, 2 ],
        eval       => 4,
    },
    {
        expression => '(- 4 3)',
        expect     => [ '-', 4, 3 ],
        eval       => 1,
    },
    {
        expression => '(* 5 2)',
        expect     => [ '*', 5, 2 ],
        eval       => 10,
    },
    {
        expression => '(/ 10 2)',
        expect     => [ '/', 10, 2 ],
        eval       => 5,
    },
    {
        expression => '(+ 1 (- 5 2))',
        expect     => [ '+', 1, [ '-', 5, 2 ] ],
        eval       => 4,
    },
);
foreach my $test (@TESTS) {
    my $expression = $$test{expression};
    my $expect     = $$test{expect};
    my $eval_to    = $$test{eval};
    my $dump       = $$test{dump};

    my $got_ast = $parser->parse( $expression );
    my $got_eval = $eval->eval( $got_ast );

    is_deeply( $got_ast, $expect, "Abstract syntax tree generated" );
    cmp_ok( $got_eval, '==', $eval_to, "Evaluated correctly" );

    diag Dumper( $got_ast ) if $dump;
}
