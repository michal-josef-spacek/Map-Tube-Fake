package Map::Tube::Fake;

use strict;
use warnings;
use 5.006;

use File::Share ':all';
use Moo;
use namespace::clean;

our $VERSION = 0.01;

# Get XML.
has xml => (
	'is' => 'ro',
	'default' => sub {
		return dist_file('Map-Tube-Fake', 'fake-map.xml');
	},
);

with 'Map::Tube';

1;

__END__

=encoding utf8

=head1 NAME

Map::Tube::Fake - Interface to the Fake Metro Map.

=head1 SYNOPSIS

 use Map::Tube::Fake;

 my $obj = Map::Tube::Fake->new;
 my $routes_ar = $obj->get_all_routes($from, $to);
 my $lines_ar = $obj->get_lines;
 my $station = $obj->get_node_by_id($station_id);
 my $station = $obj->get_node_by_name($station_name);
 my $route = $obj->get_shortest_route($from, $to);
 my $stations_ar = $obj->get_stations($line);
 my $metro_name = $obj->name;
 my $xml_file = $obj->xml;

=head1 DESCRIPTION

It currently provides functionality to find the shortest route between the two
given nodes.

For more information about Fake Map, click L<here|https://en.wikipedia.org/wiki/Fake_Metro>.

=head1 METHODS

=head2 C<new>

 my $obj = Map::Tube::Fake->new;

Constructor.

Returns instance of object.

=head2 C<get_all_routes> [EXPERIMENTAL]

 my $routes_ar = $obj->get_all_routes($from, $to);

Get all routes from station to station.

Returns reference to array with L<Map::Tube::Route> objects.

=head2 C<get_lines>

 my $lines_ar = $obj->get_lines;

Get lines in metro map.

Returns reference to array with L<Map::Tube::Line> objects.

=head2 C<get_node_by_id>

 my $station = $obj->get_node_by_id($station_id);

Get station node by id.

Returns L<Map::Tube::Node> object.

=head2 C<get_node_by_name>

 my $station = $obj->get_node_by_name($station_name);

Get station node by name.

Returns L<Map::Tube::Node> object.

=head2 C<get_shortest_route>

 my $route = $obj->get_shortest_route($from, $to);

Get shortest route between C<$from> and C<$to> node names. Node names in C<$from> and C<$to> are case insensitive.

Returns L<Map::Tube::Route> object.

=head2 C<get_stations>

 my $stations_ar = $obj->get_stations($line);

Get list of stations for concrete metro line.

Returns reference to array with L<Map::Tube::Node> objects.

=head2 C<name>

 my $metro_name = $obj->name;

Get metro name.

Returns string with metro name.

=head2 C<xml>

 my $xml_file = $obj->xml;

Get XML specification of Fake metro.

Returns string with XML.

=head1 EXAMPLE1

=for comment filename=print_fake_route.pl

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

=head1 EXAMPLE2

=for comment filename=print_fake_def_xml_file.pl

 use strict;
 use warnings;

 use Map::Tube::Fake;

 # Object.
 my $obj = Map::Tube::Fake->new;

 # Get XML file.
 my $xml_file = $obj->xml;

 # Print out XML file.
 print "XML file: $xml_file\n";

 # Output like:
 # XML file: .*/fake-map.xml

=head1 EXAMPLE3

=for comment filename=print_fake_image.pl

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

=begin html

<a href="https://raw.githubusercontent.com/michal-josef-spacek/Map-Tube-Fake/master/images/Fake.png">
  <img src="https://raw.githubusercontent.com/michal-josef-spacek/Map-Tube-Fake/master/images/Fake.png" alt="Fake metro" width="300px" height="300px" />
</a>

=end html

=head1 EXAMPLE4

=for comment filename=print_fake_lines.pl

 use strict;
 use warnings;

 use Encode qw(encode_utf8);
 use Map::Tube::Fake;

 # Object.
 my $obj = Map::Tube::Fake->new;

 # Get lines.
 my $lines_ar = $obj->get_lines;

 # Print out.
 map { print encode_utf8($_->name)."\n"; } sort @{$lines_ar};

 # Output:
 # GPS line
 # Line #1
 # Line #2
 # Line #3

=head1 EXAMPLE5

=for comment filename=print_fake_line_stations.pl

 use strict;
 use warnings;

 use Encode qw(encode_utf8);
 use Map::Tube::Fake;

 # Arguments.
 if (@ARGV < 1) {
         print STDERR "Usage: $0 line\n";
         exit 1;
 }
 my $line = $ARGV[0];

 # Object.
 my $obj = Map::Tube::Fake->new;

 # Get stations for line.
 my $stations_ar = $obj->get_stations($line);

 # Print out.
 map { print encode_utf8($_->name)."\n"; } @{$stations_ar};

 # Output:
 # Usage: __PROG__ line

 # Output with 'foo' argument.
 # Map::Tube::get_stations(): ERROR: Invalid Line Name [foo]. (status: 105) file __PROG__ on line __LINE__

 # Output with 'Line #1' argument.
 # Station #1-1
 # Station #1-2
 # Station #1-3

=head1 DEPENDENCIES

L<File::Share>,
L<Map::Tube>,
L<Moo>,
L<namespace::clean>.

=head1 SEE ALSO

=over

=item L<Map::Tube>

Core library as Role (Moo) to process map data.

=item L<Task::Map::Tube>

Install the Map::Tube modules.

=item L<Task::Map::Tube::Metro>

Install the Map::Tube concrete metro modules.

=back

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Map-Tube-Fake>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2015-2023 Michal Josef Špaček

Artistic License

BSD 2-Clause License

=head1 VERSION

0.01

=cut
