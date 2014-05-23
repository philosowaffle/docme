require 'test_helper'

class UtilsTest < MiniTest::Unit::TestCase
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
        assert_equal "trex", clean_filename("long/long/file/path/to/trex.js")
    end

    def test_parse_directory_full_path
        Dir.mkdir('docme_site')

        expected = ["dirTest.html", "sub3Directory.html", "sub4Directory.html", "subsubDirectory.html", "test.html", "testJS.html", "testTextFile.html"]
        actual = parse_directory("test/")

        assert_equal expected, actual

        File.delete('docme_site/dirTest.html')
        File.delete('docme_site/sub3Directory.html')
        File.delete('docme_site/sub4Directory.html')
        File.delete('docme_site/subsubDirectory.html')
        File.delete('docme_site/test.html')
        File.delete('docme_site/testJS.html')
        File.delete('docme_site/testTextFile.html')
        Dir.rmdir('docme_site')
    end

    def test_parse_directory_default_path
        Dir.mkdir('docme_site')

        expected = ["dirTest.html", "sub3Directory.html", "sub4Directory.html", "subsubDirectory.html", "test.html", "testJS.html", "testTextFile.html"]
        actual = parse_directory("./test")

        assert_equal expected, actual

        File.delete('docme_site/dirTest.html')
        File.delete('docme_site/sub3Directory.html')
        File.delete('docme_site/sub4Directory.html')
        File.delete('docme_site/subsubDirectory.html')
        File.delete('docme_site/test.html')
        File.delete('docme_site/testJS.html')
        File.delete('docme_site/testTextFile.html')
        Dir.rmdir('docme_site')
    end

    def test_parse_file
        expected = "testJS.html"
        actual = parse_file("test/testJS.js")

        assert_equal expected, actual

        File.delete('testJS.html')
    end

    def test_render_index
        pages = ['test.html', 'test2.html', 'test3.html']

        expected = 'index.html'
        actual = render_index(pages)

        assert_equal expected, actual

        if File.exist?('index.html')
            File.delete('index.html')
        end
    end

    def test_render_site
        file = 'test'
        collective = {'title' => 'this is a test'}

        expected = 'test.html'
        actual = render_site(file, collective)

        assert_equal expected, actual

        if File.exist?('test.html')
            File.delete('test.html')
        end
    end
end