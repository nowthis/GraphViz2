#!/usr/bin/env perl
#
# Note: t/test.t searches for the next line.
# Annotation: Demonstrates a graph with a 'plaintext' shape.

use strict;
use warnings;

use File::Spec;

use GraphViz2;

use Log::Handler;

# ---------------

my($logger) = Log::Handler -> new;

$logger -> add
	(
	 screen =>
	 {
		 maxlevel		=> 'debug',
		 message_layout	=> '%m',
		 minlevel		=> 'error',
	 }
	);

my($id)		= 4;
my($graph)	= GraphViz2 -> new
				(
					edge   => {color => 'grey'},
					global =>
					{
						directed	=> 1,
						name		=> 'mainmap',
					},
					graph	=> {rankdir => 'TB'},
					logger	=> $logger,
					meta	=>
					{
						URL => 'http://savage.net.au/maps/demo.4.1.html',	# Note: URL must be in caps.
					},
					node	=> {shape => 'oval'},
				);

$graph -> add_node(name => 'source',	URL => 'http://savage.net.au/maps/demo.4.2.html');
$graph -> add_node(name => 'destination');
$graph -> add_edge(from => 'source',	to => 'destination',	URL => '/maps/demo.4.3.html');


my($format)			= shift || 'svg';
my($output_file)	= shift || "demo.$id.$format";
my($im_format)		= shift || 'cmapx';
my($im_output_file)	= shift || "demo.$id.map";

$graph -> run(format => $format, output_file => $output_file, im_format => $im_format, im_output_file => $im_output_file);
