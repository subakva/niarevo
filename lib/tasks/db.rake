namespace :db do
  desc 'Annotates model files'
  task :annotate do
    system("annotate -i -e tests,fixtures --force")
  end
end

desc 'Runs schema migrations then prepares the test db'
task m: ['db:migrate', 'db:test:prepare', 'db:annotate']
