# encoding: UTF-8
# class Docme

require 'docme/utils'
require 'erb'
require 'fileutils'
require 'rainbow/ext/string'

class Docme

    def initialize(path, is_verbose = nil, style = nil, index = nil, page_erb = nil)
        @path = path
        @pages = []
        @is_verbose = is_verbose
        @style = style
        @index = index
        @page_erb = page_erb

        puts '+ docme will parse: '.color(:cyan) + @path if @is_verbose

        make_home
    end

    def engage
        make_home
        scan_docs
        render_docs
        render_index
        render_css
    end

    def make_home
        # create the directory where the site will be stored
        if Dir.exist?('docme_site')
            clean_directory('docme_site', @is_verbose)
        else
            puts "+ Setting up docme's living arrangements.".color(:cyan) if @is_verbose
            Dir.mkdir('docme_site')
            puts ' - Woohoo! docme has a home!' if @is_verbose
        end
    end

    def scan_docs

        puts '+ docme scanning: '.color(:cyan) + @path if @is_verbose

        # if a directory was provided
        if File.directory?(@path)

            @pages.concat parse_directory(@path, @is_verbose)

        else # if a single file was provided

            @pages.push(parse_file(@path, @is_verbose))

        end
    end

    def render_docs
        puts '+ docme generated the following pages: '.color(:cyan) if @is_verbose
        @pages.each do |page_object|
            page_object.render_site(@pages, @page_erb)
            puts ' - ' + page_object.name if @is_verbose
        end
    end

    def render_index

        puts '+ docme is creating the index'.color(:cyan) if @is_verbose

        if @index.nil?
            template = File.read(File.join(File.dirname(__FILE__), 'templates/index.erb'))
        else
            template = File.read(File.join(Dir.pwd, @index))
        end

        renderer = ERB.new(template)

        File.open('site_index.html', 'w+') do |f|
            f.write(renderer.result(binding))
        end

        # add page to docme dir
        FileUtils.mv('site_index.html', 'docme_site/site_index.html')

        puts '+ index created'.color(:cyan) if @is_verbose
    end

    def render_css
        puts '+ docme is styling'.color(:cyan) if @is_verbose

        if @style.nil?
            template = File.read(File.join(File.dirname(__FILE__), 'templates/style.erb'))
        else
            template = File.read(File.join(Dir.pwd, @style))
        end

        renderer = ERB.new(template)

        File.open('style.css', 'w+') do |f|
            f.write(renderer.result(binding))
        end

        # add page to docme dir
        FileUtils.mv('style.css', 'docme_site/style.css')

        puts '+ styling completed'.color(:cyan) if @is_verbose

    end

end
