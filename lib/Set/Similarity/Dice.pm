package Set::Similarity::Dice;

use strict;
use warnings;
use utf8;

use parent 'Set::Similarity';

sub from_tokens {
  my $self = shift;
  my $tokens1 = shift;
  my $tokens2 = shift;
  
  return 0 unless (scalar @$tokens1 && scalar @$tokens2 );
  
  my %unique1;
  @unique1{@$tokens1} = ();
  my %unique2;
  @unique2{@$tokens2} = ();
  my $intersection = grep exists $unique1{$_}, keys %unique2;
  my $combined_length = scalar(keys %unique1) + scalar(keys %unique2);
  my $dice = ($intersection * 2 / $combined_length);
  return $dice;
}

1;

=comment
# http://www.perlmonks.org/?node_id=724918
sub get_int_uni2 {
  my ($in, $jn) = @_;
  my %i;
  @i{@$in} = ();
  my $int = grep exists $i{$_}, @$jn;
  return ($int, @$in + @$jn - $int);
}

# http://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Dice's_coefficient
sub dice_coefficient {
     my ($str1, $str2) = @_;
 
     return 0 if (! length $str1 || ! length $str2 );
 
     #### bigrams using REGEX.
     ##my @bigrams_str1 = $str1 =~ m/ (?= (..) ) /xmsg;
     ##my @bigrams_str2 = $str2 =~ m/ (?= (..) ) /xmsg;
 
     my $len1 = ( length($str1) -  1 );
     for (my $i=0; $i<$len1; $i++){
         push @bigrams_str1, substr($str1, $i, 2);
     }
 
     my $len2 = ( length($str2) -  1 );
     for (my $i=0; $i<$len2; $i++){
         push @bigrams_str2, substr($str2, $i, 2);
     }
 
     my $intersect = 0;
     for my $bigram (@bigrams_str1){
          if ( grep {if (/^$bigram$/) {$_=""; 1} else {0}} @bigrams_str2){
               $intersect++;
          }
     }
 
     my $combinedLength = ($#bigrams_str1+1 + $#bigrams_str2+1);
     my $dice = ($intersect * 2 / $combinedLength);
 
     return $dice;
}

=cut
