# encoding: UTF-8
# Class DocmeCLI

require 'docme'
require 'docme/utils'
require 'fileutils'
require 'thor'

class DocmeCLI < Thor
    class_option :v, type: :boolean

    desc 'default', '`docme` When no commands are provided docme will begin the current directory and parse through all eligible folders and files.'
    option :style, type: :string
    option :index, type: :string
    option :page, type: :string
    def default
        path = Dir.pwd
        puts "\n  ***Begining docme magix***"

        docmeer = Docme.new(path, options[:v], options[:style], options[:index], options[:page])
        docmeer.engage

        puts "\n  ***Finished docme magic!***"
        puts "\n  You can find your docs inside the `docme_site` folder. \n   Hint: look for site_index.html\n\n"

    end

    desc 'clean', '`docme clean <path>` Attemtps to empty and remove the docme_site directory.  Path is optional and should point to a directory containing a `docme_site` folder. If an error is returned then you will have to delete the folder manually.'
    def clean(path = nil)
        path = Dir.pwd if path.nil?

        fail 'Please provide a valid path to a directory that contains a `docme_site` folder.' unless Dir.exist?(path + '/docme_site')

        puts '+ docme will clean ' + path if options[:v]
        puts '+ docme cleaning' if options[:v]

        clean_directory(path + '/docme_site', options[:v])
        Dir.rmdir(path + '/docme_site') if Dir.exist?(path + '/docme_site')

        puts '+ docme_site removed' if options[:v]
        puts '+ docme is now homeless' if options[:v]

    end

    desc 'parse', '`docme parse <path>` -- Either provide a path to a file or a path to a directory and docme will parse all valid files found.'
    long_desc <<-LONGDESC
    `docme parse <path/to/file>` will parse a single file specified

    `docme parse <path/to/folder>` will parse all eligible files in the specified directory

    `docme parse <path/to/folder> --style <path/to/css.erb>` will use your own custom styling options.  This file must contain valid css and be saved as `.erb` file.

    `docme parse <path/to/folder> --index <path/to/index.erb>` will use your own custom html to build the index page of the site.

    `docme parse <path/to/folder> --page <path/to/yourPage.erb>` will use your own custom html to build the pages of the site.

    Use the `-v` flag on any command to recieve verbose output.
    LONGDESC
    option :style, type: :string
    option :index, type: :string
    option :page, type: :string
    def parse(path)

        puts "\n  ***Begining docme magix***"

        docmeer = Docme.new(path, options[:v], options[:style], options[:index], options[:page])
        docmeer.engage

        puts "\n  ***Finished docme magic!***"
        puts "\n  You can find your docs inside the `docme_site` folder. \n   Hint: look for index.html\n\n"

    end

    default_task :default

end
