#!/usr/bin/env python3

"""
@title: Librarian
@description: Crawl markdown notes in a directory and print URLs.
@author: danisztls
@license: MIT
"""

import os
import re

"""
1st stage: Export the URLs as plain text to pipe to ArchiveBox

2nd stage: Store URLs on a SQLite database for housekeeping
# fields: urls.uid (PK, hash of url + path), urls.url, urls.path, url.datetime

# remove duplicate URLs
# SELECT DISTINCT url from urls

# find orphaned URLs to remove
# SELECT uid FROM urls WHERE datemine < now
"""

# LIB
def traverse_dir(_path):
    """Traverse a directory and its subdirectories to crawl notes"""
    # traverse a path returning a 3-tuple (dirpath, dirnames, filenames)
    for _dir in os.walk(_path):
        _parent = _dir[0]
        # iterate the files
        for _file in _dir[2]:
            # lower() is used to make match case insensitive
            if _file.lower().endswith('.md'):
                crawl_note(_parent + '/' + _file)

def crawl_note(_path):
    """Find URLs in a markdown note"""
    # read file content
    with open(_path, 'r') as file:
        _content = file.read()

    # iterate over lines
    # FIXME: Do I need to iterate line by line? I can use multiline.
    for _line in _content.split('\n'):
        # use regex to look for url
        # match all http(s) urls
        # FIXME: What if there's more than one URL in a line
        sensitive_pattern = re.compile(r"http[s]*://[^\)\s]*")
        _url = str(re.search(sensitive_pattern, _line))
        if _url:
            urls.append(_url)
        # TODO: log error when not valid
        #else
        #    log('ERROR')

# MAIN
PATH="sample/" # just for testing, later should serialize config file
urls=[]
traverse_dir(PATH)
print(urls)
