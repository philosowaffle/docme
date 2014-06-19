# encoding: UTF-8
# class Block

require 'docme/utils'

class Block

    attr_reader :attributes
    attr_reader :is_empty

    def initialize(block)
        @attributes = {}
        @is_empty = true

        parse_block(block)
    end

    def parse_block(block)

        is_docme = 0
        block_flag = 0
        block_attr = ''
        multi_line = ''
        block_content = {}

        # each element in the block represents a line
        block.each do |line|
            strip_line = line.lstrip

            # if line begins with '+' then we are defining an attribute
            if strip_line.rindex('+', 0) == 0

                is_docme = 1
                parts = strip_line.split(':', 2)

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
                @attributes.store(attribute, content)
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
                   @attributes.store(block_attr, multi_line)
                else
                   @attributes.store(block_attr, block_content)
                end

                multi_line = ''
                block_attr = nil
                block_content = {}
                next
            end

        end

        @is_empty = @attributes.empty?
    end

end
