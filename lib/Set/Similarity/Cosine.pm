package Set::Similarity::Cosine;

use strict;
use warnings;

use parent 'Set::Similarity';

our $VERSION = 0.007;

sub from_sets {
  my ($self, $set1, $set2) = @_;

  # it is so simple because the vectors contain only 0 and 1
  return (
    $self->intersection($set1,$set2) / (sqrt(scalar @$set1) * sqrt(scalar @$set2))
  );
}

1;

__END__

=head1 NAME

Set::Similarity::Cosine - Cosine similarity for sets

=head1 SYNOPSIS

 use Set::Similarity::Cosine;
 
 # object method
 my $cosine = Set::Similarity::Cosine->new;
 my $similarity = $cosine->similarity('Photographer','Fotograf');
 
 # class method
 my $cosine = 'Set::Similarity::Cosine';
 my $similarity = $cosine->similarity('Photographer','Fotograf');
 
 # from 2-grams
 my $width = 2;
 my $similarity = $cosine->similarity('Photographer','Fotograf',$width);
 
 # from arrayref of tokens
 my $similarity = $cosine->similarity(['a','b'],['b']);
 
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
 my $similarity = $cosine->similarity($bird,$mammal);
 
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
 my $similarity = $cosine->from_sets($bird,$mammal); 

=head1 DESCRIPTION

=head2 Cosine similarity

A intersection B / (sqrt(A) * sqrt(B))


=head1 METHODS

L<Set::Similarity::Cosine> inherits all methods from L<Set::Similarity> and implements the
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

