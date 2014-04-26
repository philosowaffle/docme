# docme

require_relative "resources/utils"


file = ARGV[0]


#raise exception if no file provided, file does not exsist, the file is not readable, or the file has no content
if file== nil || !File.file?(file) || !File.exists?(file)
    raise "Please provide a path to the file you wish to docme."
end

puts "\n  ***Begining docme magix***"

#create the directory where the site will be stored
if !File::directory?("docme")
    puts "+Setting up docme's living arrangements."
    Dir.mkdir("docme")
end

#GLOBALS
sourceFile = File.open(file).read
docmeDir = "docme"
block_flag = 0
code_flag = 0

sourceFile.each_line do |line|
    #strip leading whitespaces
    line = line.lstrip

    #if this is the begining of a comment block then start a new function doc
    if line.rindex("/*", 1) == 0
        #logic to add a new function section to the erb file
        next
    end

    #if this is the end of a comment block then there is nothing to do
    if line.rindex("*/", 1) == 0
        #end the function section of the erb file
        next
    end

    #if line begins with '+' then we are defining an attribute
    if line.rindex("+",0) == 0
        parts = line.split(":")

        #parts[0] == the attribute name
        attribute = cleanAttribute(parts[0])
        #add the attribute to the doc

        content = parts[1].lstrip

        #if the content begins with '{' then we have a block
        if content.rindex("{",0) == 0
            #go to the next line and look for '-', set block flag
            #add the attribute to the doc
            puts attribute
            block_flag = 1
            next
        end

        #add content to the doc
        puts attribute
        puts content
    end

    #if line begins with a '-' then we are in a block
    if line.rindex("-",0) == 0
        parts = line.split(":")

        #parts[0] == the attribute name
        attribute = cleanAttribute(parts[0])
        #add the attribute to the doc

         content = parts[1].lstrip

        if attribute == "var"
            # look for arrow
            content_parts = content.split("->")
            var_name = content_parts[0]
            var_description = content_parts[1].lstrip

            #put the var_name in the doc
            #put the var_description in the doc
            puts var_name
            puts var_description
            next
        end

        if attribute == "code"
            code_flag = 1
            #go ahead and skip to next line and process code
            next
        end

        #if !var and !code, then process as regular attributes
        #put the attribute name
        #put the content
        puts attribute
        puts content
        next
    end

    #if code flag is set and we reached the end of a block, then we reached the end of a code block, unset the flag
    if code_flag == 1 && line.rindex("}",0) == 0
        code_flag = 0
        next
    end

    #if the block flag is set and we reach the end of a block, then we reached the end of a regular block, unset flag
    if block_flag == 1 && line.rindex("}",0) == 0
        block_flag = 0
    end

    #if we are in a code block, then return lines as is
    if code_flag == 1
        puts line
        next
    end


end

def render()
    ERB.new(@template).result(binding)
end

def save(site)
    FIle.open(site, "w+") do |f|
        f.write(render)
    end
end
