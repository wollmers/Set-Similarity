package Set::Similarity::Cosine;

use strict;
use warnings;

use parent 'Set::Similarity';

sub from_sets {
  my ($self, $set1, $set2) = @_;

  # it is so simple because the vectors contain only 0 and 1
  return (
    $self->intersection($set1,$set2) / (sqrt(scalar keys %$set1) * sqrt(scalar keys %$set2))
  );
}

1;
