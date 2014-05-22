require 'minitest/autorun'
require 'docme'
require 'docme/utils'

class UtilsTest < MiniTest::Unit::TestCase
    def test_clean_attribute
        assert_equal "trex", clean_attribute("+[trex]")
    end

    def test_clean_attribute_sub
        assert_equal "triceratops", clean_attribute("-[triceratops]")
    end
end