# docme

require 'docme/utils'
require 'erb'

class Docme

    def self.jsParse(file)

        #SETUP
        #raise exception if no file provided, file does not exsist, the file is not readable, or the file has no content
        if file== nil || !File.file?(file) || !File.exists?(file)
            raise "Please provide a path to the file you wish to docme."
        end

        puts "\n  ***Begining docme magix***"

        #create the directory where the site will be stored
        if !File::directory?("docme_site")
            puts "+Setting up docme's living arrangements."
            Dir.mkdir("docme_site")
        end

        puts "Woohoo! docme has a home!"


        #GLOBALS
        sourceFile = File.open(file).read
        docmeDir = "docme"
        items = Hash.new
        collective = Array.new
        block_content = Hash.new
        block_attr = nil
        block_flag = 0
        multi_line = ""


        #PARSING
        sourceFile.each_line do |line|
            #strip leading whitespaces
            line = line.lstrip

            #if this is the begining of a comment block then start a new function doc
            if line.rindex("/*", 1) == 0
                next
            end

            #if this is the end of a comment block then there is nothing to do
            if line.rindex("*/", 1) == 0
                #end the function section of the erb file
                collective.push(items)
                items = Hash.new
                next
            end

            #if line begins with '+' then we are defining an attribute
            if line.rindex("+",0) == 0
                parts = line.split(":")

                #parts[0] == the attribute name
                attribute = cleanAttribute(parts[0])

                content = parts[1].lstrip

                #if the content begins with '{' then we have a regular block
                if content.rindex("{",0) == 0
                    #go to the next line and look for '-', set block flag
                    #add the attribute to the doc
                    block_flag = 1
                    block_attr = attribute
                    next
                end

                #add content to the doc
                items.store(attribute, content)
                next
            end

            #if line begins with a '-' then we are in a block, if  we are in a block but there are no sub attributes then do a multi-line
            if line.rindex("-",0) == 0
                parts = line.split(":")

                #parts[0] == the attribute name
                attribute = cleanAttribute(parts[0])

                 content = parts[1].lstrip

                #if !var and !code, then process as regular attributes
                #put the attribute name
                #put the content
                block_content.store(attribute, content)
                next
            end

            if block_flag == 1 && line.rindex("}",0) != 0
                multi_line.concat(line)
                next
            end

            #if the block flag is set and we reach the end of a block, then we reached the end of a regular block, unset flag
            if block_flag == 1 && line.rindex("}",0) == 0
                block_flag = 0

                if multi_line.length > 0
                    puts multi_line
                    items.store(block_attr, multi_line)
                else
                    items.store(block_attr, block_content)
                end

                multi_line = ""
                block_attr = nil
                block_content = Hash.new
                next
            end

        end

        #RENDER SITE
        renderSite(file,collective)

    end
end
