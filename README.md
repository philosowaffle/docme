docme
=====

A documentation generator

[![Gem Version](https://badge.fury.io/rb/docme.svg)](http://badge.fury.io/rb/docme)


###Usage

Provide a file from the command line (see the `/test` folder for syntax examples).  Currently supports any file type that recognizes `/* */` as a comment block.

Checkout project from github. Run the following commands

    >gem build docme.gemspec
    >gem install docme-0.0.1.gem
    >docme test/testJS.js

This will generate an index.html file in the current directory.  Open it in any browser to see the site documentation.

Alternatively you can install the gem from [RubyGem](https://rubygems.org/gems/docme)

    >gem install docme
    >docme <path/to/file>

###Syntax

Syntax is subject to change, especially in the early iterations of this project.  See the syntax for each supported version [here](https://github.com/philosowaffle/docme/wiki).



