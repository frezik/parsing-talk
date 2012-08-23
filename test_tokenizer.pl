use Test::More tests => 6;
use v5.14;

use_ok( 'Tokenizer' );
my $tokenizer = Tokenizer->new;

my @TESTS = (
    {
        text   => '()',
        expect => [
            [ 'OPEN_PAREN',  '(' ],
            [ 'CLOSE_PAREN', ')' ],
        ],
    },
    {
        text   => '(+)',
        expect => [
            [ 'OPEN_PAREN',  '(' ],
            [ 'OP_ADD',      '+' ],
            [ 'CLOSE_PAREN', ')' ],
        ],
    },
    {
        text   => '(- 1)',
        expect => [
            [ 'OPEN_PAREN',  '(' ],
            [ 'OP_SUBTRACT', '-' ],
            [ 'INTEGER',     1   ],
            [ 'CLOSE_PAREN', ')' ],
        ],
    },
    {
        text   => '(* 2 2)',
        expect => [
            [ 'OPEN_PAREN',  '(' ],
            [ 'OP_MULTIPLY', '*' ],
            [ 'INTEGER',     2   ],
            [ 'INTEGER',     2   ],
            [ 'CLOSE_PAREN', ')' ],
        ],
    },
    {
        text   => '(/ 6 3)',
        expect => [
            [ 'OPEN_PAREN',  '(' ],
            [ 'OP_DIVIDE',   '/' ],
            [ 'INTEGER',     6   ],
            [ 'INTEGER',     3   ],
            [ 'CLOSE_PAREN', ')' ],
        ],
    },
);
foreach (@TESTS) {
    my $text   = $$_{text};
    my $expect = $$_{expect};
    my $got    = $tokenizer->tokenize( $text );

    is_deeply( $got, $expect );
}
