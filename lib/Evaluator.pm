package Evaluator;
use v5.14;


sub new
{
    my ($class) = @_;
    my $self = {};
    bless $self => $class;
}


{
    my %OPS = (
        '+' => sub {
            my $total = shift;
            $total += shift while @_;
            return $total;
        },
        '-' => sub {
            my $total = shift;
            $total -= shift while @_;
            return $total;
        },
        '*' => sub {
            my $total = shift;
            $total *= shift while @_;
            return $total;
        },
        '/' => sub {
            my $total = shift;
            $total /= shift while @_;
            return $total;
        },
    );
    sub eval
    {
        my ($self, $ast) = @_;
        my ($op, @args) = @$ast;
        die "No such function '$op'\n" unless exists $OPS{$op};

        my $op_sub = $OPS{$op};
        my @true_args = map {
            ref $_ ? $self->eval( $_ ) : $_;
        } @args;
        return $op_sub->( @true_args );
    }
}


1;
__END__
