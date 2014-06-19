# encoding: utf-8

require 'rake'
require 'rake/tasklib'
require 'docme/DocmeCLI'

module DocmeTask
    #  Provides a custom rake task.
    #
    # require 'docme/rake-task'
    # Docme::RakeTask.new
    class RakeTask < ::Rake::TaskLib

        attr_accessor :name
        attr_accessor :parse
        attr_accessor :index
        attr_accessor :page
        attr_accessor :style
        attr_accessor :verbose

        def initialize(*args, &task_block)
            @name = args.shift || :docme
            @parse = nil
            @index = nil
            @page = nil
            @style = nil
            @verbose = nil

            define(args, &task_block)

        end

        def engage_docme

            input = build_input

            DocmeCLI.start(input)

        end

        def build_input
            temp = []

            temp.push('parse', @parse) unless @parse.nil?
            temp.push('--index', @index) unless @index.nil?
            temp.push('--page', @page) unless @page.nil?
            temp.push('--style', @style) unless @style.nil?
            temp.push('-v') unless @verbose.nil?

            temp
        end

        def define(args, &task_block)
            desc 'Run docme' unless ::Rake.application.last_comment

            task name, *args do |_, task_args|
                RakeFileUtils.__send__(:verbose, verbose) do
                    task_block.call(*[self, task_args].slice(0, task_block.arity)) if task_block
                    engage_docme
                end
            end
        end

    end

end
