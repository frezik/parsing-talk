package Procedural;
use v5.14;
use Tokenizer;


sub new
{
    my ($class) = @_;
    my $self = {};
    bless $self => $class;
}


sub parse
{
    my ($self, $text) = @_;
    my $marpa = $$self{marpa};

    my $tokenizer = Tokenizer->new;
    my $tokens = $tokenizer->tokenize( $text );

    return [];
}


1;
__END__
