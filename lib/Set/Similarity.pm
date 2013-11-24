package Set::Similarity;

use strict;
use warnings;
use utf8;

sub new {
  my $class = shift;
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}


sub from_strings {
  my $self = shift;
  my $string1 = shift;
  my $string2 = shift;
  my $width = shift;
  $width = 1 unless defined $width;
  return $self->from_tokens(
    [split(//,$string1)],
    [split(//,$string2)],
  ) unless ($width > 1);
  return $self->from_tokens(
    [$self->ngrams($string1,$width)],
    [$self->ngrams($string2,$width)],
  );
}

sub ngrams {
  my $self = shift;
  my $word = shift;
  my $width = shift;

  $width = 2 unless defined $width;

  my @ngrams;
  return @ngrams 
    unless ($width =~ m/^[1-9][0-9]*$/ && $width <= length($word));

  for my $i (0..length($word)-$width) {
    my $ngram = substr $word,$i,$width;
    push @ngrams,$ngram;
  }
 
  return @ngrams;
}

1;

=comment

Overlap coefficient

( A intersect B ) / min(A,B)

Jaccard Index

The Jaccard coefficient measures similarity between sample sets, and is defined as the size of the intersection divided by the size of the union of the sample sets

( A intersect B ) / (A union B)

The Tanimoto coefficient is the ratio of the number of features common to both molecules to the total number of features, i.e.

( A intersect B ) / ( A + B - ( A intersect B ) ) # the same as Jaccard 

The range is 0 to 1 inclusive. 

The Dice coefficient is the number of features in common to both molecules relative to the average size of the total number of features present, i.e.

( A intersect B ) / 0.5 ( A + B ) # the same as sorensen

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.​

