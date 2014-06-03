docme
=====

A documentation generator.

[![Gem Version](https://badge.fury.io/rb/docme.svg)](http://badge.fury.io/rb/docme) [![Build Status](https://travis-ci.org/philosowaffle/docme.svg?branch=master)](https://travis-ci.org/philosowaffle/docme) [![Coverage Status](https://coveralls.io/repos/philosowaffle/docme/badge.png)](https://coveralls.io/r/philosowaffle/docme) [![Dependency Status](https://gemnasium.com/philosowaffle/docme.svg)](https://gemnasium.com/philosowaffle/docme)

###Description

docme serves as a straight forward, quick, and highly customizable documentation generator.  docme syntax is available in any file that recognizes `/* */` as a comment block.  docme utilizes Twitter's Bootstrap to generate html pages that can easily be loaded into a browser for easy reference and sharing.  docme's first goal was to serve as an easy way to generate documentation for javascript files and was inspired by an effort to make documentation easier in the [blucollar](https://github.com/philosowaffle/bluecollar) project .


###Usage

NOTE: View the specific README for the release you are using [here](https://github.com/philosowaffle/docme/releases)

Provide a file from the command line (see the `/test` folder for syntax examples).  Currently supports any file type that recognizes `/* */` as a comment block.

Install the gem from [RubyGem](https://rubygems.org/gems/docme)

    > gem install docme
    > docme <path/to/file>

    OR

    > docme <path/to/directory/>

Currently docme will begin in the directory provided and parse through all nested directories ignoring hidden files.  If you only give docme a single file then it will simply parse that one file.  docme prefers UTF-8 encoded files.

You can also use the current directory by simply saying:

    > docme

This will generate a `docme_site` folder in the current directory.  Inside this folder you will find an `.html` file for each file that docme parsed.  Additionally there will be an `index.html` file that compiles all of the links into one easy landing page.

####Compatible with:

* Linux
* Mac
* Windows

###Syntax

Syntax is subject to change, especially in the early iterations of this project.  See the syntax for each supported version [here](https://github.com/philosowaffle/docme/wiki).

All docme looks for is `/*` as the first element on a line in order for it to begin processing and `*/` as the only element on a line for it to finish processing a module.


###Contributing

Look [here](https://github.com/philosowaffle/docme/wiki/Contributing)
