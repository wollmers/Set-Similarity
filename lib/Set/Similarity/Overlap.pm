package Set::Similarity::Overlap;

use strict;
use warnings;

use parent 'Set::Similarity';

our $VERSION = 0.007;

sub from_sets {
  my ($self, $set1, $set2) = @_;

  # ( A intersect B ) / min(A,B)  
  return (
    $self->intersection($set1,$set2) / $self->min($set1,$set2)
  );
}

1;

__END__

=head1 NAME

Set::Similarity::Overlap - Overlap coefficent for sets

=head1 SYNOPSIS

 use Set::Similarity::Overlap;
 
 # object method
 my $overlap = Set::Similarity::Overlap->new;
 my $similarity = $overlap->similarity('Photographer','Fotograf');
 
 # class method
 my $overlap = 'Set::Similarity::Overlap';
 my $similarity = $overlap->similarity('Photographer','Fotograf');
 
 # from 2-grams
 my $width = 2;
 my $similarity = $overlap->similarity('Photographer','Fotograf',$width);
 
 # from arrayref of tokens
 my $similarity = $overlap->similarity(['a','b'],['b']);
 
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
 my $similarity = $overlap->similarity($bird,$mammal);
 
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
 my $similarity = $overlap->from_sets($bird,$mammal); 

=head1 DESCRIPTION

=head2 Overlap coefficient

( A intersect B ) / min(A,B)

=head1 METHODS

L<Set::Similarity::Overlap> inherits all methods from L<Set::Similarity> and implements the
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


