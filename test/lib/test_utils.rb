require 'test_helper'

class UtilsTest < MiniTest::Unit::TestCase
    def test_clean_attribute
        assert_equal "trex", clean_attribute("+[trex]")
    end

    def test_clean_attribute_sub
        assert_equal "triceratops", clean_attribute("-[triceratops]")
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

    def test_clean_filename
        assert_equal "trex", clean_filename("trex.js")
    end

    def test_clean_filename_long
        assert_equal "trex", clean_filename("long/long/file/path/to/trex.js")
    end
end