require 'test_helper'
require 'docme/utils'
require 'docme/DocmeCLI'

class IntegrationTest < MiniTest::Unit::TestCase

    def setup
        if Dir.exist?('docme_site')
            raise 'A docme_site directory already exists, please remove it and continue.'
        end

        Dir.mkdir('docme_site')
    end

    def teardown

        if Dir.exist?(Dir.pwd + '/docme_site')
            clean_directory(Dir.pwd + '/docme_site')
            Dir.rmdir(Dir.pwd + '/docme_site') unless !Dir.exist?(Dir.pwd + '/docme_site')
        end
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

    def test_integration_CLI_defualt

        input = []

        DocmeCLI.start(input)

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/subsubDirectory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/dirTest.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/test.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testJS.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testTextFile.html'))

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))
    end

    def test_integration_CLI_parse
        path = Dir.pwd
        input = ['parse', path]

        DocmeCLI.start(input)

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/subsubDirectory.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/dirTest.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/test.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testJS.html'))
        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testTextFile.html'))

        assert_equal true, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))
    end

    def test_integration_CLI_clean_default

        docmeer = Docme.new('test/')
        docmeer.scan_docs
        docmeer.render_docs

        assert_equal true, Dir.exist?(Dir.pwd + '/docme_site')

        input = ['clean']

        DocmeCLI.start(input)

        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/subsubDirectory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/dirTest.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/test.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testJS.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testTextFile.html'))

        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))

        assert_equal false, Dir.exists?(File.join(File.dirname(__FILE__), '../../docme_site'))
    end

    def test_integration_CLI_clean_path

        docmeer = Docme.new('test/')
        docmeer.scan_docs
        docmeer.render_docs

        assert_equal true, Dir.exist?(Dir.pwd + '/docme_site')

        path = Dir.pwd
        input = ['clean', path]

        DocmeCLI.start(input)

        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub3Directory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/sub4Directory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/subsubDirectory.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/dirTest.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/test.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testJS.html'))
        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/testTextFile.html'))

        assert_equal false, File.exists?(File.join(File.dirname(__FILE__), '../../docme_site/index.html'))

        assert_equal false, Dir.exists?(File.join(File.dirname(__FILE__), '../../docme_site'))
    end
end