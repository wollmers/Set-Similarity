package Set::Similarity::Dice;

use strict;
use warnings;

use parent 'Set::Similarity';

sub from_sets {
  my ($self, $set1, $set2) = @_;

  # $dice = ($intersection * 2 / $combined_length);
  return (
    $self->intersection($set1,$set2) * 2 / $self->combined_length($set1,$set2)
  );
}

1;

