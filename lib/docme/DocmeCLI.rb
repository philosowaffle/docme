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

    end

    desc 'parse', '`docme parse <path>` -- Either provide a path to a file or a path to a directory and docme will parse all valid files found.'
    def parse(path)
        puts path

        puts '\n  ***Begining docme magix***'

        docmeer = Docme.new(path, :v)
        docmeer.scan_docs
        docmeer.render_docs
        docmeer.render_index

    end

    default_task :default

end
