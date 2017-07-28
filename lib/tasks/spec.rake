namespace :spec do
  desc 'Runs specs with coverage and cane checks'
  task cane: ['spec:enable_coverage', 'spec:coverage', 'quality']
end

Rake::Task['spec'].enhance(['vars:load_dot_env', 'spec:enable_coverage']) do
  Rake::Task['quality'].invoke
end
