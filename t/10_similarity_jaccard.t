#!perl
use strict;
use warnings;

use lib qw(../lib/);

use Test::More;

my $class = 'Set::Similarity::Jaccard';

use_ok($class);

#my $object = new_ok($class);

my $object = $class;

is($object->from_tokens(),1,'empty params');
is($object->from_tokens('a',),0,'a string');
is($object->from_tokens('a','b'),0,'a,b strings');

is($object->from_tokens([],['a','b']),0,'empty, ab tokens');
is($object->from_tokens(['a','b'],[]),0,'ab, empty tokens');
is($object->from_tokens([],[]),1,'both empty tokens');
is($object->from_tokens(['a','b'],['a','b']),1,'equal  ab tokens');
is($object->from_tokens(['a','b'],['c','d']),0,'ab unequal cd tokens');
is($object->from_tokens(['a','b','a','a'],['b','c','c','c','d']),0.25,'abaa 0.25 bcccd tokens');
is($object->from_tokens(['a','b','a','b'],['b','c','c','c','d']),0.25,'abab 0.25 bccc tokens');

is($object->from_features({},{'a' => 1,'b' => 1}),0,'empty, ab features');
is($object->from_features({'a' => 1,'b' => 1},{}),0,'ab, empty features');
is($object->from_features({},{}),1,'both empty features');
is($object->from_features({'a' => 1,'b' => 1},{'a' => 1,'b' => 1}),1,'equal  ab features');
is($object->from_features({'a' => 1,'b' => 1},{'c' => 1,'d' => 1}),0,'ab unequal cd features');

#is($object->from_features(['a','b','a','a'],['b','c','c','c','d']),0.25,'abaa 0.25 bcccd tokens');
#is($object->from_features(['a','b','a','b'],['b','c','c','c','d']),0.25,'abab 0.25 bccc tokens');


is($object->from_strings('ab','ab'),1,'equal  ab strings');
is($object->from_strings('ab','cd'),0,'ab unequal cd strings');
is($object->from_strings('abaa','bcccd'),0.25,'abaa 0.25 bccc strings');
is($object->from_strings('abab','bcccd'),0.25,'abab 0.25 bccc strings');
is($object->from_strings('ab','abcd'),0.5,'ab 0.5 abcd strings');

is($object->from_strings('ab','ab',2),1,'equal  ab bigrams');
is($object->from_strings('ab','cd',2),0,'ab unequal cd bigrams');
is($object->from_strings('abaa','bccc',2),0,'abaa 0 bccc bigrams');
is($object->from_strings('abcabc','bccc',2),0.25,'abcabcf 0.25 bcccah bigrams');
is($object->from_strings('abc','abcdef',2),0.4,'abc 0.4 abcdef bigrams');

{
use utf8;
is($object->from_strings('äb','äb',2),1,'equal  ab bigrams');
is($object->from_strings('äb','cd',2),0,'ab unequal cd bigrams');
is($object->from_strings('äbää','bccc',2),0,'abaa 0 bccc bigrams');
is($object->from_strings('äbcäbc','bccc',2),0.25,'abcabcf 0.25 bcccah bigrams');
is($object->from_strings('äbc','äbcdef',2),0.4,'abc 0.4 abcdef bigrams');
}

ok($object->from_strings('Photographer','Fotograf') > 0.45,'Photographer 0.4545 Fotograf strings');
ok($object->from_strings('Photographer','Fotograf') < 0.455,'Photographer 0.4545 Fotograf strings');

ok($object->from_strings('Photographer','Fotograf',2) > 0.38,'Photographer 0.384 Fotograf bigrams');
ok($object->from_strings('Photographer','Fotograf',2) < 0.385,'Photographer 0.384 Fotograf bigrams');

ok($object->from_strings('Photographer','Fotograf',3) > 0.33,'Photographer 0.333 Fotograf trigrams');
ok($object->from_strings('Photographer','Fotograf',3) < 0.334,'Photographer 0.333 Fotograf trigrams');


done_testing;
