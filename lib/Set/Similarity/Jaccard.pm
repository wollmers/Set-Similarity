package Set::Similarity::Jaccard;

use strict;
use warnings;

use parent 'Set::Similarity';

our $VERSION = 0.006;

sub from_sets {
  my ($self, $set1, $set2) = @_;

  my $intersection = $self->intersection($set1,$set2);
  my $union = $self->combined_length($set1,$set2) - $intersection;
  # ( A intersect B ) / (A union B)
  return ($intersection / $union);
}

1;

__END__

=head1 NAME

Set::Similarity::Jaccard - Jaccard coefficent for sets

=head1 SYNOPSIS

 use Set::Similarity::Jaccard;
 
 # object method
 my $jaccard = Set::Similarity::Jaccard->new;
 my $similarity = $jaccard->similarity('Photographer','Fotograf');
 
 # class method
 my $jaccard = 'Set::Similarity::Dice';
 my $similarity = $jaccard->similarity('Photographer','Fotograf');
 
 # from 2-grams
 my $width = 2;
 my $similarity = $jaccard->similarity('Photographer','Fotograf',$width);
 
 # from arrayref of tokens
 my $similarity = $jaccard->similarity(['a','b'],['b']);
 
 # from hashref of features
 my $bird = {
   wings    => true,
   eyes     => true,
   feathers => true,
   hairs    => false,
   legs     => true,
   arms     => false,
 };
 my $mammal = {
   wings    => false,
   eyes     => true,
   feathers => false,
   hairs    => true,
   legs     => true,
   arms     => true, 
 };
 my $similarity = $jaccard->similarity($bird,$mammal);
 
 # from hashref sets
 my $bird = {
   wings    => undef,
   eyes     => undef,
   feathers => undef,
   legs     => undef,
 };
 my $mammal = {
   eyes     => undef,
   hairs    => undef,
   legs     => undef,
   arms     => undef, 
 };
 my $similarity = $jaccard->from_sets($bird,$mammal); 

=head1 DESCRIPTION

=head2 Jaccard Index

The Jaccard coefficient measures similarity between sample sets, and is defined as the 
size of the intersection divided by the size of the union of the sample sets

( A intersect B ) / (A union B)

The Tanimoto coefficient is the ratio of the number of elements common to both sets to 
the total number of elements, i.e.

( A intersect B ) / ( A + B - ( A intersect B ) ) # the same as Jaccard 

The range is 0 to 1 inclusive.

=head1 METHODS

L<Set::Similarity::Jaccard> inherits all methods from L<Set::Similarity> and implements the
following new ones.

=head2 from_sets

  my $similarity = $object->from_sets({'a' => undef},{'b' => undef});

=head1 SOURCE REPOSITORY

L<http://github.com/wollmers/Set-Similarity>

=head1 AUTHOR

Helmut Wollmersdorfer, E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

