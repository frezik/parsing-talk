package Tokenizer;
use v5.14;
use HOP::Lexer 'string_lexer';

use constant TOKENS => [
    [ 'OPEN_PAREN',  qr/\(/  ],
    [ 'CLOSE_PAREN', qr/\)/  ],
    [ 'INTEGER',     qr/\d+/ ],
    [ 'WHITESPACE',  qr/\s+/ ],
    [ 'OP',          qr/[\+\-\*\/]/  ],
];

sub new
{
    my ($class) = @_;
    my $self = {};
    bless $self => $class;
}


sub tokenize
{
    my ($self, $text) = @_;

    my $lexer = string_lexer( $text, @{ $self->TOKENS } );

    my @tokens;
    while( my $token = $lexer->() ) {
        push @tokens => $token;
    }

    return \@tokens;
}


1;
__END__
