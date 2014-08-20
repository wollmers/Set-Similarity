package Set::Similarity;

use strict;
use warnings;

our $VERSION = '0.019';

use Carp 'croak';

sub new {
  my $class = shift;
  # uncoverable condition false
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}

sub similarity {
  my ($self, $any1, $any2, $width) = @_;

  return $self->from_tokens(
    $self->_any($any1,$width),
    $self->_any($any2,$width)
  );
}

sub _any {
  my ($self, $any, $width) = @_;
	
  if (ref($any) eq 'ARRAY') {
    return $any;
  }
  elsif (ref($any) eq 'HASH') {
	return [grep { $any->{$_} } keys %$any];
  }
  elsif (ref($any)) {
   return [];
  }
  else {
    return [$self->ngrams($any,$width)];
  }
}

sub ngrams {
  my ($self, $word, $width) = @_;

  $width = 1 unless ($width && $width =~ m/^[1-9][0-9]*$/x);
  $word ||= '';

  my @ngrams;
  #return @ngrams unless ($width <= length($word));
  
  if ($width > length($word)) {
    for (1..$width-length($word)) {
      $word .= ' ';
    }
  }

  for my $i (0..length($word)-$width) {
    my $ngram = substr $word,$i,$width;
    push @ngrams,$ngram;
  }

  return @ngrams;
}

sub from_tokens {
  my ($self, $tokens1, $tokens2) = @_;

  # uncoverable condition false
  return 1 if (!scalar @$tokens1 && !scalar @$tokens2);
  return 0 unless (scalar @$tokens1 && scalar @$tokens2 );
    
  return $self->from_sets(
    [$self->uniq($tokens1)],
    [$self->uniq($tokens2)],
  );
}

sub from_sets { croak 'Method "from_sets" not implemented in subclass' }

sub intersection { 
  my %uniq;
  @uniq{@{$_[1]}} = ();
  scalar grep { exists $uniq{$_} } @{$_[2]};
}

sub uniq {
  my %uniq; 
  @uniq{@{$_[1]}} = ();
  return keys %uniq; 
}

sub combined_length {
  scalar(@{$_[1]}) + scalar(@{$_[2]});
}

sub min {
  (scalar(@{$_[1]}) < scalar(@{$_[2]}))
    ? scalar(@{$_[1]}) : scalar(@{$_[2]});
}

1;

__END__

=head1 NAME

Set::Similarity - similarity measures for sets

=for html
<a href="https://travis-ci.org/wollmers/Set-Similarity"><img src="https://travis-ci.org/wollmers/Set-Similarity.png" alt="Set-Similarity"></a>
<a href='https://coveralls.io/r/wollmers/Set-Similarity?branch=master'><img src='https://coveralls.io/repos/wollmers/Set-Similarity/badge.png?branch=master' alt='Coverage Status' /></a>

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
 
 # from arrayref sets
 my $bird = [qw(
   wings
   eyes
   feathers
   legs
 )];
 my $mammal = [qw(
   eyes
   hairs
   legs
   arms
 )];
 my $similarity = $dice->from_sets($bird,$mammal);

=head1 DESCRIPTION


=head2 Overlap coefficient

( A intersect B ) / min(A,B)

=head2 Jaccard Index

The Jaccard coefficient measures similarity between sample sets, and is defined as the size of the intersection divided by the size of the union of the sample sets

( A intersect B ) / (A union B)

The Tanimoto coefficient is the ratio of the number of features common to both sets to the total number of features, i.e.

( A intersect B ) / ( A + B - ( A intersect B ) ) # the same as Jaccard 

The range is 0 to 1 inclusive.

=head2 Dice coefficient

The Dice coefficient is the number of features in common to both sets relative to the average size of the total number of features present, i.e.

( A intersect B ) / 0.5 ( A + B ) # the same as sorensen

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.

=head1 METHODS

All methods can be used as class or object methods.

=head2 new

  $object = Set::Similarity->new();

=head2 similarity

  my $similarity = $object->similarity($any1,$any1,$width);
  
C<$any> can be an arrayref, a hashref or a string. Strings are tokenized into n-grams of width C<$width>.

C<$width> must be integer, default is 1.
  
=head2 from_tokens

  my $similarity = $object->from_tokens(['a','b'],['b']);

=head2 from_sets

  my $similarity = $object->from_sets(['a'],['b']);

=head2 intersection

  my $intersection_size = $object->intersection(['a'],['b']);
  
=head2 combined_length

  my $set_size_sum = $object->combined_length(['a'],['b']);

=head2 min

  my $min_set_size = $object->min(['a'],['b']);
  
=head2 ngrams

  my @monograms = $object->ngrams('abc');
  my @bigrams = $object->ngrams('abc',2);

=head2 _any

  my $arrayref = $object->_any($any,$width);

=head1 SOURCE REPOSITORY

L<http://github.com/wollmers/Set-Similarity>

=head1 AUTHOR

Helmut Wollmersdorfer, E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013-2014 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

