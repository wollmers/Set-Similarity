use strict;
use warnings;

use 5.8.0;
use Module::Build;

my $builder = Module::Build->new(
  module_name => 'Set::Similarity',
  dist_author => 'Helmut Wollmersdorfer',
  license => 'perl',
  
  requires => {
    'perl' => '5.8.0',
    'Test::More' => 0,
    'Unicode::Normalize' => 0,
  },
  configure_requires => {
    'Module::Build' => 0.38,
  },

  meta_merge => {
    resources  => {
      repository => "http://github.com/wollmers/Set-Similarity",
      bugtracker => "http://github.com/wollmers/Set-Similarity/issues",
    },
    no_index => {
      file      => [ 'README.pod' ],
    },
  }
);

$builder->create_build_script;

