#!/usr/bin/perl
=pod
simple-web-crawler
==================

A simple link-indexing script.
Run sudo bash config.sh in order to get the required packages.

Usage:
--
perl simple-web-crawler.pl webaddress [depth] [logfile] [customRegex]
webaddress   - The page where the crawler will start
[depth]       - The indexing depth (optional, by default 2)
[logfile]     - The file where the indexed links will be written (optional, by default STDOUT)
[customRegex] - The custom regex used by the crawler for indexing links (optional, by default ^http|https|\/\/ )

Example:
---
perl simple-web-crawler.pl http://iskernel.blogspot.com/ 3 links.log "^http|https|//"
=cut

use strict;
use warnings;

use LWP::Simple;
use WWW::Mechanize;
use Try::Tiny;
use Scalar::Util qw(looks_like_number);

#Default starting depth
use constant C_STARTING_DEPTH => 0;
#Default maximum depth if not maximum depth is provided
use constant C_DEFAULT_MAX_DEPTH => 2;
#Default regex used for validating a link if no regex is provided
use constant C_DEFAULT_REGEX => "^http|https|\/\/";
#Index for address argument
use constant C_INDEX_ADDRESS => 0;
#Index for depth argument
use constant C_INDEX_DEPTH => 1;
#Index for logfile argument
use constant C_INDEX_LOGFILE => 2;
#Index for custom regex argument
use constant C_INDEX_CUSTOM_REGEX => 3;

#Array containing the indexed links so the crawler will not repeat itself
my @g_indexed_links;
#Maximum link depth to which the crawler will, well, crawl
my $g_max_depth;
#The regex used for validating a link for crawling
my $g_regex;
#The Mechanize object used by the web crawler
my $g_mech;
#The logfile where the links will be written
my $g_log_file;

=pod
Description:
	Verifies if a link was indexed by the crawler
Parameters:
	url - The link's url
Returns:
	1 - The link exists in the indexed links array
	0 - The link doesn't exist in the indexed links array
=cut
sub was_indexed
{
	my $url = $_[0];
	my $result = 0;
	foreach my $item(@g_indexed_links)
	{
		if($item eq $url)
		{
			$result = 1;
			last;
		}
	}
	return $result;
}

=pod
Description:
	Validates a link for crawling
Parameters:
	url - The link's url
Returns:
	1 - The link should be crawled
	0 - The link should not be crawled
=cut
sub should_crawl
{
	my $url = $_[0];
	my $result = 0;
	if($url =~ /$g_regex/ )
	{
		$result = 1;
	}
	return $result;
}

=pod
Description:
	Crawls all valid links from a webpage recursively according to a
	specified depth.
Parameters:
	url - The webpages's url
	depth - The current crawl depth
Returns:
	Nothing
=cut
sub crawl
{
	my $url = $_[0];
	my $depth = $_[1];
	if( was_indexed($url) == 0 )
	{
		try
		{
			$g_mech->get($url);
			if( $g_log_file eq (*STDOUT) )
			{
				print $g_log_file $depth." ".$url."\n";
			}
			else
			{
				print $g_log_file $depth." ".$url."\n";
				print $depth." ".$url." indexed.\n";
			}
			my @links = $g_mech->links();
			push(@g_indexed_links, $url);
			foreach my $link (@links)
			{
				if( ($depth<$g_max_depth) && (should_crawl($link->url)==1) )
				{
					crawl($link->url, ($depth + 1) );
				}
			}
		}
		catch
		{
			warn("$_\n");
		}
	}
}

=pod
The script :-)
=cut
#Verifies if a webpage is provided
if( defined($ARGV[C_INDEX_ADDRESS]) )
{
	#Verifies if the webpage is valid
	if( head($ARGV[C_INDEX_ADDRESS]) )
	{
		my $webpage = $ARGV[C_INDEX_ADDRESS];
		#Verifies if depth is provided (and is a number)
		if( defined($ARGV[C_INDEX_DEPTH]) && (looks_like_number($ARGV[C_INDEX_DEPTH])) )
		{
			$g_max_depth= $ARGV[C_INDEX_DEPTH];
		}
		else
		{
			warn("No maximum depth provided. Assuming maximum depth = 2\n");
			$g_max_depth = C_DEFAULT_MAX_DEPTH;
		}
		#Verifies if a logfile is provided
		if( defined($ARGV[C_INDEX_LOGFILE] ))
		{
			open($g_log_file, ">>".$ARGV[C_INDEX_LOGFILE]) or die("The provided filename is invalid.");
		}
		else
		{
			$g_log_file = *STDOUT;
			warn("No custom file was sent. Assuming STDOUT as logfile\n")
		}
		#Verifies if a custom regex is provided
		if( defined($ARGV[C_INDEX_CUSTOM_REGEX]) )
		{
			$g_regex = $ARGV[C_INDEX_CUSTOM_REGEX];
		}
		else
		{
			$g_regex = C_DEFAULT_REGEX;
			warn("No custom regex for link validation. Assuming regex is ^http|https|\/\/ \n");
		}
		$g_mech = WWW::Mechanize->new();
		crawl($webpage, C_STARTING_DEPTH);
	}
	else
	{
		die("The provided webpage does not exist");
	}
}
else
{
	die("You must at least provide a webpage to crawl.\n".
	    "Ex: perl simple-web-crawler.pl http://iskernel.blogspot.com/ 3 links.log ^http|https|\/\/ \n");
}
print("---------------DONE----------------");
close($g_log_file);
