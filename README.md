docme
=====

A documentation generator


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

Syntax is subject to change, especially in the early iterations of this project.  Here is the current expected syntax.

    /*
      +[title]: myFunction
      +[description]: this function does some cool things
      +[example]: {
            -[code]: {
                var response = myfunction(testVar);
            }
      }
      +[attribute]:{
            -[subAttribute]: this is a sub attribute of the parent attribute
            -[anothersubAttribute]: another sub attribute
      }
    */

Currently `title` and `example` are reserved attributes that have a predefined meaning.  Title will be the title of the documented item and `example` represents a code snippet(however this implementation is likely to change).  Other than those two attributes, you are free to supply any attribute you like, paired to any content.  It should be noted that with the exception of the `example` attribute, docme only supports 1-tier of nesting.  That is, a parent attribute, i.e. `+[myAttribute]` can contain `{ -[subAttribute]: ..... }` but a `-[subAttribute]` cannot contain `{-[subsubAttribute]}`.

