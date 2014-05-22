require 'test/unit'
require 'docme'
require 'docme/utils'
require 'coveralls'

Coveralls.wear!

class UtilsTest < Test::Unit::TestCase
    def test_clean_attribute
        assert_equal "trex", cleanAttribute("+[trex]")
    end

    def test_clean_attribute_sub
        assert_equal "triceratops", cleanAttribute("-[triceratops]")
    end
end