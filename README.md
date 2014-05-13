docme
=====

A documentation generator.

[![Gem Version](https://badge.fury.io/rb/docme.svg)](http://badge.fury.io/rb/docme)

###Description

docme serves as a straight forward, quick, and highly customizable documentation generator.  docme syntax is available in any file that recognizes `/* */` as a comment block.  docme utilizes Twitter's Bootstrap to generate html pages that can easily be loaded into a browser for easy reference and sharing.  docme's first goal was to serve as an easy way to generate documentation for javascript files and was inspired by an effort to make documentation easier in the [blucollar](https://github.com/philosowaffle/bluecollar) project .


###Usage

Provide a file from the command line (see the `/test` folder for syntax examples).  Currently supports any file type that recognizes `/* */` as a comment block.

Checkout project from github. Run the following commands

    >gem build docme.gemspec
    >gem install docme-0.0.1.gem
    >docme test/testJS.js

OR you can provide an entire directory to docme.  Currently docme can process up to 2 levels of directories i.e

       -home
       |-- test
           |
           |-file.txt
           |-file.java
           |-- subTest
                |
                |-file.js
                |-otherfile.txt
                |-- subsubFolder
                    |
                    |-anotherFile.txt

If you ran the following command from your home directory:

    >docme test

Then docme me would parse the `test/` directory and all of the FILES in the `subTest/` directory, ignoring the `subsubFolder/` directory.

You can also use the current directory

    >docme ./

This will generate a `docme_site` folder in the current directory.  Inside this folder you will find an `.html` file for each file that docme parsed.  Additionally there will be an `index.html` file that compiles all of the links into one easy landing page.

Alternatively you can install the gem from [RubyGem](https://rubygems.org/gems/docme)

    >gem install docme
    >docme <path/to/file>

    OR

    >docme <path/to/directory/>

###Syntax

Syntax is subject to change, especially in the early iterations of this project.  See the syntax for each supported version [here](https://github.com/philosowaffle/docme/wiki).

All docme looks for is `/*` as the first element on a line in order for it to begin processing and `*/` as the only element on a line for it to finish processing a module.



