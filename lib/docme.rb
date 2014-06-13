# encoding: UTF-8
# class Docme

require 'docme/utils'
require 'erb'
require 'fileutils'

class Docme

    def initialize(path)
        @path = path
        @pages = []

        make_home
    end

    def make_home
        # create the directory where the site will be stored
        return true if File.directory?('docme_site')
        puts "+ Setting up docme's living arrangements."
        Dir.mkdir('docme_site')
        puts ' - Woohoo! docme has a home!'
    end

    def scan_docs
        # if a directory was provided
        if File.directory?(@path)

            @pages.concat parse_directory(@path)

        else # if a single file was provided

            @pages.push(parse_file(@path))

        end
    end

    def render_docs
        puts '+ docme generated the following pages: '
        @pages.each do |page_object|
            page_object.render_site(@pages)
            puts ' - ' + page_object.name
        end
    end

    def render_index

        template = File.read(File.join(File.dirname(__FILE__), 'templates/index.erb'))

        renderer = ERB.new(template)

        File.open('index.html', 'w+') do |f|
            f.write(renderer.result(binding))
        end

        # add page to docme dir
        FileUtils.mv('index.html', 'docme_site/index.html')
    end

end
