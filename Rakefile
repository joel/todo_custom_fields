# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

task default: %i[test]

begin
  require "rubocop/rake_task"

  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ["-A"] # auto_correct
  end

  task default: %i[test rubocop]
rescue LoadError
  puts "RuboCop not available."
end

# task default: %i[test]
