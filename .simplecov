# frozen_string_literal: true

SimpleCov.start do
  load_profile 'rails'
  coverage_dir 'tmp/coverage'
  command_name "rails_app_#{$PROCESS_ID}" # $$ is the processid
  merge_timeout 600 # 10.minutes.seconds.to_i
end
