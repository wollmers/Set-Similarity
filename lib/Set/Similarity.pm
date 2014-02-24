package Set::Similarity;

use strict;
use warnings;

our $VERSION = 0.001;

sub new {
  my $class = shift;
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}

sub from_any {
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

sub from_strings { shift->from_any(@_) }

sub from_features { shift->from_any(@_) }

sub ngrams {
  my ($self, $word, $width) = @_;

  $width = 1 unless defined $width;

  my @ngrams;
  return @ngrams 
    unless ($width =~ m/^[1-9][0-9]*$/x && $width <= length($word));

  for my $i (0..length($word)-$width) {
    my $ngram = substr $word,$i,$width;
    push @ngrams,$ngram;
  }

  return @ngrams;
}

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
  return $self->from_sets(\%unique1,\%unique2);
}


sub intersection { 
  scalar grep { exists ${$_[1]}{$_} } keys %{$_[2]}; 
}

sub combined_length {
  scalar(keys %{$_[1]}) + scalar(keys %{$_[2]});
}

sub min {
  (scalar(keys %{$_[1]}) < scalar(keys %{$_[2]}))
    ? scalar(keys %{$_[1]}) : scalar(keys %{$_[2]});
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


=head2 Overlap coefficient

( A intersect B ) / min(A,B)

=head2 Jaccard Index

The Jaccard coefficient measures similarity between sample sets, and is defined as the size of the intersection divided by the size of the union of the sample sets

( A intersect B ) / (A union B)

The Tanimoto coefficient is the ratio of the number of features common to both molecules to the total number of features, i.e.

( A intersect B ) / ( A + B - ( A intersect B ) ) # the same as Jaccard 

The range is 0 to 1 inclusive.

=head2 Dice coefficient

The Dice coefficient is the number of features in common to both molecules relative to the average size of the total number of features present, i.e.

( A intersect B ) / 0.5 ( A + B ) # the same as sorensen

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.

=head1 SOURCE REPOSITORY

L<http://github.com/wollmers/Set-Similarity>

=head1 AUTHOR

Helmut Wollmersdorfer, E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

