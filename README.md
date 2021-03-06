docme
=====

A documentation parser.

[![Gem Version](https://badge.fury.io/rb/docme.svg)](http://badge.fury.io/rb/docme) [![Build Status](https://travis-ci.org/philosowaffle/docme.svg?branch=master)](https://travis-ci.org/philosowaffle/docme) [![Coverage Status](https://coveralls.io/repos/philosowaffle/docme/badge.png)](https://coveralls.io/r/philosowaffle/docme) 

<a href="https://www.buymeacoffee.com/philosowaffle" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/black_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

###Description

docme serves as a straight forward, quick, and highly customizable documentation parser.  docme syntax is available in any file that recognizes `/* */` as a comment block.  docme utilizes Twitter's Bootstrap to generate html pages that can easily be loaded into a browser for easy reference and sharing.  docme's first goal was to serve as an easy way to generate documentation for javascript files and was inspired by an effort to make documentation easier in the [bluecollar](https://github.com/philosowaffle/bluecollar) project.

```javascript
    /*
            +[title]: printHelloWorld()
            +[description]: Prints 'Hello World!' to the screen in the given element.
            +[inputs]:{{
                -[elementID]: The #id of the element you want to display the output in
            }}
            +[outputs]: 'Hello Wold!'
            +[code]: {{
                    <html>
                        <div id="printHere"></div>

                        <script>
                            bc_printHelloWorld('printHere');
                        </script>
                    </html>
            }}
            +[compatibility]: All known browsers

    */
        function bc_printHelloWorld( elementID ){
        try{
            document.getElementById( elementID ).innerHTML = "Hello World!";
        } catch( error ){
            logAndThrow( error, "It's possible the id you supplied does not exist." );
        }
    }
```

###Usage

NOTE: View the specific README for the release you are using [here](https://github.com/philosowaffle/docme/releases)

Install the gem from [RubyGem](https://rubygems.org/gems/docme)

    > gem install docme
    > docme parse <path/to/file>

    OR

    > docme parse <path/to/directory/>

Currently docme supports any file type that recognizes `/* */` as a comment block.  docme will begin in the directory provided and parse through all nested directories ignoring hidden files.  If you only give docme a single file then it will simply parse that one file.  docme prefers UTF-8 encoded files.

You can also use the current directory by simply saying:

    > docme

Running docme will generate a `docme_site` folder in the current directory.  Inside this folder you will find an `.html` file for each file that docme parsed.  Additionally there will be an `index.html` file that compiles all of the links into one easy landing page.

####Flags and Options

To get a list of available flags/options/commands type:

    > docme help

If you wish to remove the documentation generated by docme then simply run:

    > docme clean

    OR

    > docme clean <path/to/folder/containing/docmeFolder>

You should either run clean from a directory that contains a `docme_site` folder or you should provide a path to a directory containing a `docme_site` folder.

 To recieve verbose output use the `-v` flag.

 You can also provide your own style files.  You may specify your own CSS file, index layout, and page layout.  Simply supply the files with the below flags.  Syntax examples [here](https://github.com/philosowaffle/docme/wiki/Docme-Syntax-v2.0.1).

    > docme --index <path/to/index.erb> --page <path/to/page.erb> --style <path/to/style.erb>

###Syntax

See the syntax for each supported version [here](https://github.com/philosowaffle/docme/wiki).


###Rake Task

Require `docme/rake_task`

To simply execute the default docme command:

```ruby
    DocmeTask::RakeTask.new
```

To set variables:

```ruby
    DocmeTask::RakeTask.new(:docme) do |task|
        task.parse = 'dirTest/'
        task.verbose = true
        task.index = 'templates/indexTest.erb'
        task.page = 'templates/pageTest.erb'
        task.style = 'templates/testStyle.erb'
    end
```

####Compatible with:

* Linux
* Mac
* Windows


###Contributing

Look [here](https://github.com/philosowaffle/docme/wiki/Contributing)
