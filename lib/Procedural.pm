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
    my @tokens = @{ $tokenizer->tokenize( $text ) };

    my $ast = $self->_read( \@tokens );
    return $ast;
}


sub _read
{
    my ($self, $tokens) = @_;
    die "Unexpected EOF while reading\n" unless @$tokens;

    my @ast;
    my $token = shift @$tokens;
    my ($token_name, $token_value) = @$token;
    if( $token_name eq 'OPEN_PAREN' ) {
        my @ast;
        while( $$tokens[0][0] ne 'CLOSE_PAREN' ) {
            push @ast => $self->_read( $tokens );
        }
        return \@ast;
    }
    elsif( $token_name eq 'CLOSE_PAREN' ) {
        die "Unexpected close paren\n";
    }
    else {
        return $token_value;
    }

    return ();
}


1;
__END__
