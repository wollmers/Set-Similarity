#!perl
use strict;
use warnings;

use lib qw(../lib/ );

use Test::More;

my $class = 'Set::Similarity';

use_ok($class);

my $object = new_ok($class);
ok($object->new());
ok($object->new(1,2));
ok($object->new({}));
ok($object->new({a => 1}));


is_deeply([$object->ngrams('',0)],[],'zerogram empty string is empty');
is_deeply([$object->ngrams('a',0)],[],'zerogram single character is empty');
is_deeply([$object->ngrams('ab',0)],[],'zerogram two characters is empty');
is_deeply([$object->ngrams('a',1)],['a'],'monogram single character');
is_deeply([$object->ngrams('ab',1)],['a','b'],'monogram two characters');
is_deeply([$object->ngrams('',2)],[],'bigram empty string is empty');
is_deeply([$object->ngrams('a',2)],[],'bigram single character is empty');
is_deeply([$object->ngrams('ab',2)],['ab'],'bigram two characters');
is_deeply([$object->ngrams('abc',2)],['ab','bc'],'bigram three characters');

is_deeply($object->_any('',0),[],'o-gram empty string is empty list');
is_deeply($object->_any('a',0),[],'o-gram string a is empty list');
is_deeply($object->_any('ab',0),[],'o-gram string ab is empty list');
is_deeply($object->_any('a',1),['a'],'1-gram string a');
is_deeply($object->_any('ab',1),['a','b'],'1-gram ab');
is_deeply($object->_any('',2),[],'bigram empty string is empty');
is_deeply($object->_any('a',2),[],'bigram single character is empty');
is_deeply($object->_any('ab',2),['ab'],'bigram two characters');
is_deeply($object->_any('abc',2),['ab','bc'],'bigram three characters');

is_deeply($object->_any(sub {}),[],'coderef is empty list');
is_deeply($object->_any({}),[],'empty hashref is empty list');
is_deeply($object->_any({'a' => 1}),['a'],'hash a => 1');
is_deeply($object->_any({'a'=>1,'b'=>1}),['a','b'],'hash ab');

is($object->from_tokens(),1,'from tokens() is 1');
is($object->from_tokens(undef,['a']),0,'from tokens(undef,[a]) is 0');
is($object->from_tokens(['a'],undef),0,'from tokens(undef,[a]) is 0');



is($object->from_tokens(1,1),1,'from tokens(1,1) is 1');


done_testing;
