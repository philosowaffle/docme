# encoding: UTF-8
# Class DocmeCLI

require 'docme'
require 'docme/utils'
require 'fileutils'
require 'thor'

class DocmeCLI < Thor
    class_option :v, :type => :boolean, :aliase => :verbose

    desc 'default', 'When no commands are provided docme will begin the current directory and parse through all eligible folders and files.'
    def default
        path = Dir.pwd
        puts path

        puts '\n  ***Begining docme magix***'

        docmeer = Docme.new(path, :v)
        docmeer.scan_docs
        docmeer.render_docs
        docmeer.render_index

        puts "\n  ***Finished docme magic!***"
        puts "\n  You can find your docs inside the `docme_site` folder. \n   Hint: look for index.html\n\n"

    end

    desc 'clean', '`docme clean <path>` Attemtps to empty and remove the docme_site directory.  Path is optional and should point to a directory containing a `docme_site` folder. If an error is returned then you will have to delete the folder manually.'
    def clean(path = nil)
        path = Dir.pwd if path.nil?

        fail 'Please provide a valid path to a directory that contains a `docme_site` folder.' unless Dir.exist?(path + '/docme_site')

        clean_directory(path + '/docme_site')
        Dir.rmdir(path + '/docme_site') if Dir.exist?(path + '/docme_site')

    end

    desc 'parse', '`docme parse <path>` -- Either provide a path to a file or a path to a directory and docme will parse all valid files found.'
    def parse(path)
        puts path

        puts '\n  ***Begining docme magix***'

        docmeer = Docme.new(path, :v)
        docmeer.scan_docs
        docmeer.render_docs
        docmeer.render_index

        puts "\n  ***Finished docme magic!***"
        puts "\n  You can find your docs inside the `docme_site` folder. \n   Hint: look for index.html\n\n"

    end

    default_task :default

end
