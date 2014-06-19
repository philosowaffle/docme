Gem::Specification.new do |s|
    s.name = 'docme'
    s.version = '2.0.2-SNAPSHOT'
    s.executables << 'docme'
    s.date = '2014-06-19'
    s.summary = "A documentation site generator."
    s.description = "A gem to support easy documentation for any file that recognizes `/* */` as a code block.  This gem lets you easily parse multiple files in a directory and generate documentation that can be viewed in the browser.  See the homepage and wiki for syntax and examples."
    s.authors = ["Bailey Belvis"]
    s.email = 'baileyb622@gmail.com'
    s.files = ["lib/docme.rb", "lib/docme/utils.rb", "lib/docme/page.rb", "lib/docme/block.rb", "lib/docme/DocmeCLI.rb", "lib/docme/rake_task.rb", "lib/templates/page.erb", "lib/templates/index.erb", "lib/templates/style.erb"]
    s.homepage = 'https://github.com/philosowaffle/docme'
    s.license = 'Mozilla Public License'
    s.post_install_message = "Woohoo! You now have docme :) "
end