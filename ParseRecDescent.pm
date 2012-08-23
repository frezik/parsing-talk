package ParseRecDescent;
use v5.14;
use Parse::RecDescent;


sub new
{
    my ($class) = @_;
    my $self = {};
    bless $self => $class;
}


sub parse
{
    my ($self, $text) = @_;
    return ['+', 1];
}


1;
__END__
