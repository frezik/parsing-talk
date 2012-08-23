#!/usr/bin/perl
use v5.14;
use Test::More tests => 9;

use_ok( 'Evaluator' );
my $eval = Evaluator->new;
isa_ok( $eval => 'Evaluator' );

cmp_ok( $eval->eval( [ '+', 1 ] ),     '==', 1,  "Can run simple expression" );
cmp_ok( $eval->eval( [ '+', 2, 2 ] ),  '==', 4,  "Addition" );
cmp_ok( $eval->eval( [ '-', 4, 3 ] ),  '==', 1,  "Subtraction" );
cmp_ok( $eval->eval( [ '*', 5, 2 ] ),  '==', 10, "Multiplcation" );
cmp_ok( $eval->eval( [ '/', 10, 2 ] ), '==', 5,  "Division" );
cmp_ok( $eval->eval( [ '+', 1, [ '-', 5, 2 ] ] ), '==', 4,
    "Deep tree" );

eval {
    $eval->eval( [ 'no-such-func', 1 ] );
};
ok( $@, "No such function error" );


