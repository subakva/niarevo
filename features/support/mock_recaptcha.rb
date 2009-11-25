module Recaptcha
  module Verify
    def verify_recaptcha(options = {})
      if RecaptchaHelpers.verification_succeeded?
        return true
      elsif options[:model]
        options[:model].errors.add_to_base("Word verification response is incorrect, please try again.")
      end
      return false
    end
  end
end

module RecaptchaHelpers
  def self.verification_succeeded?
    @should_report_success
  end

  def self.report_failure
    @should_report_success = false
  end

  def self.report_success
    @should_report_success = true
  end
end

Before do
  RecaptchaHelpers.report_success
end

World(RecaptchaHelpers)
