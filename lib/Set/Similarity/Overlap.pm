package Set::Similarity::Overlap;

use strict;
use warnings;

use parent 'Set::Similarity';

sub from_sets {
  my ($self, $set1, $set2) = @_;

  # ( A intersect B ) / min(A,B)  
  return (
    $self->intersection($set1,$set2) / $self->min($set1,$set2)
  );
}


1;
