package Set::Similarity;

use strict;
use warnings;

our $VERSION = 0.001;
$VERSION = eval $VERSION;

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
    unless ($width =~ m/^[1-9][0-9]*$/x && $width <= length($word));

  for my $i (0..length($word)-$width) {
    my $ngram = substr $word,$i,$width;
    push @ngrams,$ngram;
  }

  return @ngrams;
}


1;

__END__

=head1 NAME

Set::Similarity - similarity measures for sets

=head1 SYNOPSIS

 use Set::Similarity::Dice;
 my $dice = Set::Similarity::Dice->new;
 my $similarity = $dice->from_string('Photographer','Fotograf');

=head1 DESCRIPTION


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

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.

​=head1 SOURCE REPOSITORY

L<http://github.com/wollmers/Set-Similarity>

=head1 AUTHOR

Helmut Wollmersdorfer, E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

