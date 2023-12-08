use strict;
use warnings;

use Map::Tube::Fake;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Map::Tube::Fake::VERSION, 0.01, 'Version.');
