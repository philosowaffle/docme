require 'minitest/autorun'
require 'docme'
require 'docme/utils'

class UtilsTest < MiniTest::Unit::TestCase
    def test_clean_attribute
        assert_equal "trex", cleanAttribute("+[trex]")
    end

    def test_clean_attribute_sub
        assert_equal "triceratops", cleanAttribute("-[triceratops]")
    end
end