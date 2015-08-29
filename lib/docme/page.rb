# encoding: UTF-8
# class Page

require 'docme/utils'
require 'erb'
require 'fileutils'

require_relative 'block.rb'

class Page

    attr_reader :name
    attr_reader :blocks
    attr_reader :is_empty

    @source_file = ''

    def initialize(file)
        @name = clean_filename(file)
        @source_file = File.open(file).read
        @page_erb = '../templates/page.erb'
        @blocks = []
        @is_empty = true
    end

    def parse_blocks
        block = []

        @source_file.each_line do |line|
            strip_line = line.lstrip

            # if this is the begining of a comment block then start a new function doc
            next if strip_line.rindex('/*', 1) == 0

            # if this is the end of a comment block then there is nothing to do
            if strip_line.rindex('*/', 1) == 0
                # pass the block off to be processed, the returned object will be stored in the blocks array
                temp_block = Block.new(block)
                @blocks.push(temp_block) unless temp_block.is_empty == true
                block = []
                next
            end

            block.push(line)
        end

        @is_empty = @blocks.empty?
    end

    def render_site(index, page_erb = nil)
        @index = []

        index.each do |page|
            @index.push(page.name)
        end

        if page_erb.nil?
            renderer = ERB.new(File.read(File.join(File.dirname(__FILE__), @page_erb)))
        else
            renderer = ERB.new(File.read(File.join(Dir.pwd, page_erb)))
        end

        page = @name + '.html'

        File.open(page, 'w+') do |f|
            f.write(renderer.result(binding))
        end

        FileUtils.mv(page, 'docme_site/' + page)
    end
end
