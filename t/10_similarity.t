#!perl
use 5.010;
use open qw(:locale);
use strict;
use warnings;
use utf8;

use lib qw(../lib/ ./lib/);

use Test::More;

my $class = 'Set::Similarity';

use_ok($class);

my $object = new_ok($class);

is_deeply([$object->ngrams('',0)],[],'zerogram empty string is empty');
is_deeply([$object->ngrams('a',0)],[],'zerogram single character is empty');
is_deeply([$object->ngrams('ab',0)],[],'zerogram two characters is empty');
is_deeply([$object->ngrams('a',1)],['a'],'monogram single character');
is_deeply([$object->ngrams('ab',1)],['a','b'],'monogram two characters');
is_deeply([$object->ngrams('')],[],'bigram empty string is empty');
is_deeply([$object->ngrams('a')],[],'bigram single character is empty');
is_deeply([$object->ngrams('ab')],['ab'],'bigram two characters');
is_deeply([$object->ngrams('abc')],['ab','bc'],'bigram three characters');


done_testing;
