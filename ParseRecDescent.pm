package ParseRecDescent;
use v5.14;
use Parse::RecDescent;

my $GRAMMAR = <<'END_GRAMMAR';
    startrule: func

    func: open_paren op arg(s?) close_paren
        {
            $return = [
                $item[2],
                @{ $item[3] },
            ];
        }

    open_paren: '('
    close_paren: ')'

    op: '+'
    op: '-'
    op: '*'
    op: '/'

    arg: integer
    arg: func

    integer: /\d+/
END_GRAMMAR


sub new
{
    my ($class) = @_;
    my $parser = Parse::RecDescent->new( $GRAMMAR );

    my $self = {
        parser => $parser,
    };
    bless $self => $class;
}


sub parse
{
    my ($self, $text) = @_;
    my $parser = $$self{parser};

    my $ast = $parser->startrule( $text );
    return $ast;
}


1;
__END__
