# encoding: UTF-8
# docme utils

require 'docme/page'

def clean_attribute(attr)
    attr = attr.delete('+[')
    attr = attr.delete(']')
    attr = attr.delete('-')
    attr = attr.upcase
    attr
end

def clean_code(line)
    line.gsub!('<', '&lt;')
    line.gsub!('>', '&gt;')

    line
end

def clean_content(line)
    line = line.lstrip
    line = line.rstrip

    line
end

def clean_filename(file)
    file = File.basename(file)
    file = file.split('.')
    file = file[0]

    file
end

def unsupported_extension(file)
    parse = true

    unsupported_extensions = ['.gem', '.jar', '.gemspec', '.zip', '.tar', '.gz', '.tar.gz', '.jpeg', '.jpg', '.png', '.exe', '.md', '.lock']

    parse = false unless unsupported_extensions.include?(File.extname(file)) || (File.executable?(file) && !Dir.exist?(file)) || (File.executable_real?(file) && !Dir.exist?(file))

    parse
end

def unsupported_encoding(file)
    parse = true

    parse = false unless file.encoding.name != 'UTF-8'

    parse
end

def parse_directory(path, is_verbose = nil)

    files_array = []

    # for each file in the sub directory
    Dir.foreach(path) do |f|

        next if f == '.' || f == '..' || f.rindex('.', 0) || unsupported_encoding(f) ||  unsupported_extension(f)

        # if another directory then go inside
        if File.directory?(path + '/' + f)

            puts ' - docme parsing path: ' + f if is_verbose

            files_array.concat parse_directory(path + '/' + f)

        else # else parse normally

            temp_page = parse_file(path + '/' + f, is_verbose)
            files_array.push(temp_page) unless temp_page.nil? || temp_page.is_empty == true

        end
    end

    files_array

end

def parse_file(file, is_verbose = nil)

    if File.file?(file) && File.exist?(file) && !file.rindex('.', 0) && !unsupported_encoding(file) && !unsupported_extension(file)

        puts ' - docme parsing page: ' + file if is_verbose

        page = Page.new(file)
        page.parse_blocks

        page

    else
        nil
    end

end

def clean_directory(path, is_verbose = nil)
    # for each file in the directory
    Dir.foreach(path) do |f|

        next if f == '.' || f == '..'

        # if another directory then go inside
        if File.directory?(path + '/' + f)

            clean_directory(path + '/' + f)

        else # else delete file

            puts ' - docme removing file: ' + f if is_verbose

            File.delete(path + '/' + f)

        end
    end
end
