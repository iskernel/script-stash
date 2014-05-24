simple-web-crawler
==================

A simple link-indexing script.

Run 

```bash
sudo bash config.sh
``` 

in order to get the required packages.

Usage:
--

*perl simple-web-crawler.pl webaddress [depth] [logfile] [customRegex]*

**webaddress**    - The page where the crawler will start

**[depth]**       - The indexing depth (optional, by default 2)

**[logfile]**     - The file where the indexed links will be written (optional, by default STDOUT)

**[customRegex]** - The custom regex used by the crawler for indexing links (optional, by default ^http|https|\/\/ )

Example:
---

```
perl simple-web-crawler.pl http://iskernel.com/ 3 links.log "^http|https|//"
```
