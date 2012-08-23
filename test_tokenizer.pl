use Test::More tests => 4;
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
            [ 'OP',          '+' ],
            [ 'CLOSE_PAREN', ')' ],
        ],
    },
    {
        text   => '(+ 1)',
        expect => [
            [ 'OPEN_PAREN',  '(' ],
            [ 'OP',          '+' ],
            [ 'WHITESPACE',  ' ' ],
            [ 'INTEGER',     1   ],
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
