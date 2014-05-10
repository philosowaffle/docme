# docme

require 'docme/utils'
require 'erb'
require 'fileutils'

class Docme

    def self.jsParse(file)

        #SETUP
        #raise exception if no file provided, file does not exsist, the file is not readable, or the file has no content
        if file== nil || !File.file?(file) || !File.exists?(file)
            raise "Please provide a path to the file you wish to docme."
        end

        #GLOBALS
        sourceFile = File.open(file).read
        file = cleanFilename(file)
        items = Hash.new
        collective = Array.new
        block_content = Hash.new
        block_attr = nil
        block_flag = 0
        multi_line = ""


        #PARSING
        sourceFile.each_line do |line|

            stripLine = line.lstrip


            #if this is the begining of a comment block then start a new function doc
            if stripLine.rindex("/*", 1) == 0
                next
            end

            #if this is the end of a comment block then there is nothing to do
            if stripLine.rindex("*/", 1) == 0
                #end the function section of the erb file
                collective.push(items)
                items = Hash.new
                next
            end

            #if line begins with '+' then we are defining an attribute
            if stripLine.rindex("+",0) == 0
                parts = stripLine.split(":")

                #parts[0] == the attribute name
                attribute = cleanAttribute(parts[0])
                attribute = attribute.upcase

                content = cleanContent(parts[1])

                #if the content begins with '{' then we have a regular block
                if content.rindex("{{",0) == 0
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
            if stripLine.rindex("-",0) == 0
                parts = stripLine.split(":")

                #parts[0] == the attribute name
                attribute = cleanAttribute(parts[0])
                attribute = attribute.upcase

                 content = cleanContent(parts[1])

                #if !var and !code, then process as regular attributes
                #put the attribute name
                #put the content
                block_content.store(attribute, content)
                next
            end

            if block_flag == 1 && stripLine.rindex("}}",0) != 0
                line = cleanCode(line)
                multi_line.concat(line)
                next
            end

            #if the block flag is set and we reach the end of a block, then we reached the end of a regular block, unset flag
            if block_flag == 1 && stripLine.rindex("}}",0) == 0
                block_flag = 0

                if multi_line.length > 0
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
        if collective.length > 0
            page = renderSite(file,collective)
            return page
        end

        return nil

    end
end
