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

__END__

=head1 NAME

Set::Similarity::Dice - Dice coefficent for sets

=head1 SYNOPSIS

 use Set::Similarity::Dice;
 
 # object method
 my $dice = Set::Similarity::Dice->new;
 my $similarity = $dice->similarity('Photographer','Fotograf');
 
 # class method
 my $dice = 'Set::Similarity::Dice';
 my $similarity = $dice->similarity('Photographer','Fotograf');
 
 # from 2-grams
 my $width = 2;
 my $similarity = $dice->similarity('Photographer','Fotograf',$width);
 
 # from arrayref of tokens
 my $similarity = $dice->similarity(['a','b'],['b']);
 
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
 my $similarity = $dice->similarity($bird,$mammal);
 
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
 my $similarity = $dice->from_sets($bird,$mammal); 

=head1 DESCRIPTION

=head2 Dice coefficient

The Dice coefficient is the number of elements in common to both sets relative to the 
average size of the total number of elements present, i.e.

( A intersect B ) / 0.5 ( A + B ) # the same as sorensen

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.

=head1 METHODS

L<Set::Similarity::Dice> inherits all methods from L<Set::Similarity> and implements the
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


