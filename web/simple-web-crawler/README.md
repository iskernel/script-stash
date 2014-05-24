simple-web-crawler
==================

Usage:
--

perl simple-web-crawler.pl webaddress [depth] [logfile] [customRegex]

webaddress    - The page where the crawler will start
[depth]       - The depth of the crawling
		(optional, by default 2)
[logfile]     - The file where the indexed links will be written
		(optional, by default STDOUT)
[customRegex] - The custom regex used by the crawler for indexing links
		(optional, by default ^http|https|\/\/ )

Example:

perl SimpleWebCrawler.pl http://iskernel.blogspot.com/ 3 links.log ^http|https|//
