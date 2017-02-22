module SpecialSauce
  class Capybara < SpecialSauce::Driver

    def self.current_session(options = {})
      Kernel.warn(
        "SpecialSauce::Capybara#current_session is deprecated and will be removed in v1.0.0. Use 'setup_session' instead."
      )
      setup_session(options)
    end

    def self.setup_session(options = {})
      puts "Sauce Labs auth ENV variables not set." && return unless auth?

      ::Capybara.register_driver :special_sauce do |app|
        ::Capybara::Selenium::Driver.new(
          app,
          browser: :remote,
          url: sauce_endpoint,
          desired_capabilities: desired_capabilities(options)
        )
      end

      ::Capybara.current_driver = :special_sauce
      ::Capybara.javascript_driver = :special_sauce

      ::Capybara.current_session
    end

  end
end
