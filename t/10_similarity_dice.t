#!perl
#use 5.010;
#use open qw(:locale);
use strict;
use warnings;
#use utf8;

use lib qw(../lib/);

use Test::More;

my $class = 'Set::Similarity::Dice';

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
is($object->from_tokens(['a','b','a','a'],['b','c','c','c']),0.5,'abaa 0.5 bccc tokens');
is($object->from_tokens(['a','b','a','b'],['b','c','c','c']),0.5,'abab 0.5 bccc tokens');

is($object->from_strings('ab','ab'),1,'equal  ab strings');
is($object->from_strings('ab','cd'),0,'ab unequal cd strings');
is($object->from_strings('abaa','bccc'),0.5,'abaa 0.5 bccc strings');
is($object->from_strings('abab','bccc'),0.5,'abab 0.5 bccc strings');

is($object->from_strings('ab','ab',2),1,'equal  ab bigrams');
is($object->from_strings('ab','cd',2),0,'ab unequal cd bigrams');
is($object->from_strings('abaa','bccc',2),0,'abaa 0 bccc bigrams');
is($object->from_strings('abcabcf','bcccah',2),0.5,'abcabcf 0.5 bcccah bigrams');

done_testing;
