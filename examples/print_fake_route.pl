#!/usr/bin/env perl

use strict;
use warnings;

use Encode qw(decode_utf8 encode_utf8);
use Map::Tube::Fake;

# Object.
my $obj = Map::Tube::Fake->new;

# Get route.
my $route = $obj->get_shortest_route('Station #2-3', 'Station #3-2');

# Print out type.
print "Route: ".encode_utf8($route)."\n";

# Output:
# Route: Station #2-3 (Line #2, Street), Station #3-2 (Line #3, Street)