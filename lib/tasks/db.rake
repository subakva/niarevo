# frozen_string_literal: true

namespace :db do
  desc 'Annotates model files'
  task :annotate do # rubocop:disable Rails/RakeEnvironment
    system("annotate -i -k -e tests,fixtures")
  end
end

desc 'Runs schema migrations then prepares the test db'
task m: ['db:migrate', 'db:test:prepare', 'db:annotate']
