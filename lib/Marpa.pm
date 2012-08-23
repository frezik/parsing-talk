package Marpa;
use v5.14;
use Marpa::R2;
use Tokenizer;


sub new
{
    my ($class) = @_;
    my $self = {};

    my $grammar = Marpa::R2::Grammar->new(
        start          => 'Func',
        actions        => 'Marpa::MyActions',
        default_action => 'firstArg',
        rules => [
            { lhs => 'Func', rhs => [qw/OpenParen Op Args CloseParen/] },
            { lhs => 'OpenParen',  rhs => [ '(' ] },
            { lhs => 'CloseParen', rhs => [ ')' ] },
            { lhs => 'Op',         rhs => [ '+' ] },
            { lhs => 'Op',         rhs => [ '-' ] },
            { lhs => 'Op',         rhs => [ '*' ] },
            { lhs => 'Op',         rhs => [ '/' ] },
            { lhs => 'Args',       rhs => [ 'Intger' ], min => 0 },
            map( { 
                { lhs => 'Integer', rhs => [ $_ ] }
            } 0 .. 9),
        ],
    );
    $grammar->precompile;

    my $self = {
        marpa => $grammar,
    };
    bless $self => $class;
}


sub parse
{
    my ($self, $text) = @_;
    my $marpa = $$self{marpa};

    my $tokenizer = Tokenizer->new;
    my $tokens = $tokenizer->tokenize( $text );

    my $recog = Marpa::R2::Recognizer->new({ grammar => $marpa });
    $recog->read( @$_ ) for @$tokens;

    my $parse_result = $recog->value;
    return $parse_result;
}


sub Marpa::MyActions::funcList
{
    my (undef, undef, $op, $args, undef) = @_;
    return [ $op, @$args ];
}

sub Marpa::MyActions::firstArg
{
    my (undef, $arg) = @_;
    return $arg;
}


1;
__END__
