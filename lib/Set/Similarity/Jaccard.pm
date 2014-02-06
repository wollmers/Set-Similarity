package Set::Similarity::Jaccard;

use strict;
use warnings;

use parent 'Set::Similarity';

sub from_tokens {
  my $self = shift;
  my $tokens1 = shift || [];
  my $tokens2 = shift || [];
  
  $tokens1 = ref $tokens1 ? $tokens1 : [$tokens1];
  $tokens2 = ref $tokens2 ? $tokens2 : [$tokens2];
  
  return 1 if (!scalar @$tokens1 && !scalar @$tokens2);
  return 0 unless (scalar @$tokens1 && scalar @$tokens2 );
  
  my %unique1;
  @unique1{@$tokens1} = ();
  my %unique2;
  @unique2{@$tokens2} = ();
  my $intersection = grep exists $unique1{$_}, keys %unique2;
  my $union = scalar(keys %unique1) + scalar(keys %unique2) - $intersection;
  # ( A intersect B ) / (A union B)
  my $jaccard = ($intersection / $union);
  return $jaccard;
}

1;
