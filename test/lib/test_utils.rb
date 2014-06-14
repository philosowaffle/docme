require 'test_helper'

class UtilsTest < MiniTest::Unit::TestCase

    def setup
        if Dir.exist?('docme_site')
            raise 'A docme_site directory already exists, please remove it and continue.'
        end

        Dir.mkdir('docme_site')
    end

    def teardown
        clean_directory(Dir.pwd + '/docme_site')
        Dir.rmdir('docme_site') unless !Dir.exist?('docme_site')

        File.delete('index.html') unless !File.exists?('index.html')
        File.delete('test.html') unless !File.exists?('test.html')
    end


    def test_clean_attribute
        assert_equal "TREX", clean_attribute("+[trex]")
    end

    def test_clean_attribute_sub
        assert_equal "TRICERATOPS", clean_attribute("-[triceratops]")
    end

    def test_clean_code
        assert_equal "&lt;trex&gt;", clean_code("<trex>")
    end

    def test_clean_code_two
        assert_equal "&lt;&lt;&gt;&gt;&lt;&gt;&gt;&lt;", clean_code("<<>><>><")
    end

    def test_clean_content
        assert_equal "trex", clean_content("   trex         ")
    end

    def test_clean_content_cleaned
        assert_equal "triceratops", clean_content("triceratops")
    end

    def test_clean_filename
        assert_equal "trex", clean_filename("trex.js")
    end

    def test_clean_filename_long
        assert_equal "trex", clean_filename("extra/long/long/file/path/to/trex.js")
    end

    def test_unsupported_extension_false
        assert_equal false, unsupported_extension('goodExtension.html')
    end

    def test_unsupported_extension_true
        assert_equal true, unsupported_extension('test/dirTest/Archive.zip')
    end

    def test_parse_directory_full_path

        actual = parse_directory("test/")

        refute_empty actual

    end

    def test_parse_directory_single_hidden_file

        actual = parse_directory('test/dirTest')

        refute_empty actual
        assert_equal false, actual.include?('hiddenfile.html')

    end

    def test_parse_file_hidden_file
        actual = parse_file('test/dirTest/.test.txt')

        assert_equal nil, actual
    end

    def test_parse_file
        actual = parse_file("test/dirTest/testJS.js")

        assert_equal false, actual.is_empty

    end

    def test_clean_directory
        docmeer = Docme.new('test/dirTest/subsubDirectoryTest/sub3directory')
        docmeer.scan_docs
        docmeer.render_docs

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        docmeer.render_index

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))

        clean_directory(Dir.pwd + '/docme_site')
    end
end