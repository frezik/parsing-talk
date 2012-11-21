package Marpa;
use v5.14;
use Marpa::PP;
use Tokenizer;


sub new
{
    my ($class) = @_;
    my $self = {};

    my $grammar = Marpa::PP::Grammar->new({
        start          => 'func',
        actions        => 'Marpa::MyActions',
        default_action => 'firstArg',
        terminals      => [qw{
            OPEN_PAREN CLOSE_PAREN INTEGER
            OP_ADD OP_SUBTRACT OP_MULTIPLY OP_DIVIDE
        }],
        rules => [
            {
                lhs    => 'func',
                rhs    => [qw{ OPEN_PAREN op args CLOSE_PAREN }],
                action => 'funcList',
            },
            {
                lhs    => 'args',
                rhs    => [qw{ arg }],
                min    => 1,
                action => 'listArg',
            },
            { lhs => 'op',   rhs => [qw{ OP_ADD      }] },
            { lhs => 'op',   rhs => [qw{ OP_SUBTRACT }] },
            { lhs => 'op',   rhs => [qw{ OP_MULTIPLY }] },
            { lhs => 'op',   rhs => [qw{ OP_DIVIDE   }] },
            { lhs => 'arg',  rhs => [qw{ INTEGER }] },
            { lhs => 'arg',  rhs => [qw{ func }] },
        ],
    });
    $grammar->precompute;

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

    my $recog = Marpa::PP::Recognizer->new({ grammar => $marpa });
    $recog->read( @$_ ) for @$tokens;

    my $parse_result = ${ $recog->value };
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

sub Marpa::MyActions::listArg
{
    my (undef, @args) = @_;
    return \@args;
}


1;
__END__
