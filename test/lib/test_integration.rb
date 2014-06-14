require 'test_helper'

class IntegrationTest < MiniTest::Unit::TestCase

    def setup
        if Dir.exist?('docme_site')
            raise 'A docme_site directory already exists, please remove it and continue.'
        end

        Dir.mkdir('docme_site')
    end

    def teardown
        File.delete('docme_site/dirTest.html') unless !File.exists?("docme_site/dirTest.html")
        File.delete('docme_site/sub3Directory.html') unless !File.exists?('docme_site/sub3Directory.html')
        File.delete('docme_site/sub4Directory.html') unless !File.exists?('docme_site/sub4Directory.html')
        File.delete('docme_site/subsubDirectory.html') unless !File.exists?('docme_site/subsubDirectory.html')
        File.delete('docme_site/test.html') unless !File.exists?('docme_site/test.html')
        File.delete('docme_site/testJS.html') unless !File.exists?('docme_site/testJS.html')
        File.delete('docme_site/testTextFile.html') unless !File.exists?('docme_site/testTextFile.html')
        File.delete('docme_site/index.html') unless !File.exists?('docme_site/index.html')
        Dir.rmdir('docme_site') unless !Dir.exist?('docme_site')

        File.delete('index.html') unless !File.exists?('index.html')
        File.delete('test.html') unless !File.exists?('test.html')
    end

    def test_integration_one_small
        docmeer = Docme.new('test/dirTest/subsubDirectoryTest/sub3directory')
        docmeer.scan_docs
        docmeer.render_docs

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        docmeer.render_index

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))


    end

    def test_integration_two_full
        docmeer = Docme.new('test/')
        docmeer.scan_docs
        docmeer.render_docs

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/subsubDirectory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/dirTest.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/test.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testJS.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testTextFile.html'))

        docmeer.render_index

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))

    end

    def test_integration_three_single_file
        docmeer = Docme.new('test/dirTest/testJS.js')
        docmeer.scan_docs
        docmeer.render_docs

        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/subsubDirectory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/dirTest.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/test.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testJS.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testTextFile.html'))

        docmeer.render_index

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))
    end
end