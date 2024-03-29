#!/usr/bin/env perl

use strict;
use warnings;

use Map::Tube::GraphViz;
use Map::Tube::GraphViz::Utils qw(node_color_without_label);
use Map::Tube::Fake;

# Object.
my $obj = Map::Tube::Fake->new;

# GraphViz object.
my $g = Map::Tube::GraphViz->new(
        'callback_node' => \&node_color_without_label,
        'driver' => 'neato',
        'tube' => $obj,
);

# Get graph to file.
$g->graph('Fake.png');

# Print file.
system "ls -l Fake.png";

# Output like:
# -rw-r--r-- 1 skim skim 27046 Dec 25 18:23 Fake.png