# class docme

require 'docme/utils'
require 'erb'
require 'fileutils'

class Docme

    def self.j_parse(file)

        # GLOBALS
        source_file = File.open(file).read
        file = clean_filename(file)
        items = {}
        collective = []
        block_content = {}
        block_attr = nil
        block_flag = 0
        multi_line = ''
        is_docme = 0

        # PARSING
        source_file.each_line do |line|

            strip_line = line.lstrip

            # if this is the begining of a comment block then start a new function doc
            if strip_line.rindex('/*', 1) == 0
                next
            end

            # if this is the end of a comment block then there is nothing to do
            if strip_line.rindex('*/', 1) == 0  && is_docme == 1
                # end the function section of the erb file
                collective.push(items)
                is_docme = 0
                items = Hash.new
                next
            end

            # if line begins with '+' then we are defining an attribute
            if strip_line.rindex('+', 0) == 0

                is_docme = 1
                parts = strip_line.split(':')

                # parts[0] == the attribute name
                attribute = clean_attribute(parts[0])

                content = clean_content(parts[1])

                # if the content begins with '{' then we have a regular block
                if content.rindex('{{', 0) == 0
                    # go to the next line and look for '-', set block flag
                    # add the attribute to the doc
                    block_flag = 1
                    block_attr = attribute
                    next
                end

                # add content to the doc
                items.store(attribute, content)
                next
            end

            # if line begins with a '-' then we are in a block, if  we are in a block but there are no sub attributes then do a multi-line
            if strip_line.rindex('-', 0) == 0 && is_docme == 1
                parts = strip_line.split(':')

                # parts[0] == the attribute name
                attribute = clean_attribute(parts[0])

                content = clean_content(parts[1])

                # if !var and !code, then process as regular attributes
                # put the attribute name
                # put the content
                block_content.store(attribute, content)
                next
            end

            if block_flag == 1 && strip_line.rindex('}}', 0) != 0 && is_docme == 1
                line = clean_code(line)
                multi_line.concat(line)
                next
            end

            # if the block flag is set and we reach the end of a block, then we reached the end of a regular block, unset flag
            if block_flag == 1 && strip_line.rindex('}}', 0) == 0 && is_docme == 1
                block_flag = 0

                if multi_line.length > 0
                    items.store(block_attr, multi_line)
                else
                    items.store(block_attr, block_content)
                end

                multi_line = ''
                block_attr = nil
                block_content = {}
                next
            end

        end

        # RENDER SITE
        # TODO: pull this out a level so we can have an index on each page aswell
        if collective.length > 0
            page = render_site(file, collective)
            return page
        end

        nil

    end
end
