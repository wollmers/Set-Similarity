package Set::Similarity::Jaccard;

use strict;
use warnings;

use parent 'Set::Similarity';

sub from_sets {
  my ($self, $set1, $set2) = @_;

  my $intersection = $self->intersection($set1,$set2);
  my $union = $self->combined_length($set1,$set2) - $intersection;
  # ( A intersect B ) / (A union B)
  return ($intersection / $union);
}


1;
