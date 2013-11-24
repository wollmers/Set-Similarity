#!perl
use 5.010;
use open qw(:locale);
use strict;
use warnings;
use utf8;

use lib qw(../lib/);

use Test::More;

my $class = 'Set::Similarity::Jaccard';

use_ok($class);

my $object = new_ok($class);

is($object->from_tokens([],['a','b']),0,'empty, ab tokens');
is($object->from_tokens(['a','b'],[]),0,'ab, empty tokens');
is($object->from_tokens([],[]),0,'both empty tokens');
is($object->from_tokens(['a','b'],['a','b']),1,'equal  ab tokens');
is($object->from_tokens(['a','b'],['c','d']),0,'ab unequal cd tokens');
is($object->from_tokens(['a','b','a','a'],['b','c','c','c','d']),0.25,'abaa 0.25 bcccd tokens');
is($object->from_tokens(['a','b','a','b'],['b','c','c','c','d']),0.25,'abab 0.25 bccc tokens');

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

done_testing;
