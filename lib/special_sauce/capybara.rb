class SpecialSauce::Capybara < SpecialSauce::Driver

  def self.browser
    puts "Sauce Labs auth ENV variables not set." && return unless auth?

    ::Capybara.register_driver :special_sauce do |app|
      ::Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: sauce_endpoint,
        desired_capabilities: current_browser_caps
      )
    end

    ::Capybara.current_driver = :special_sauce

    ::Capybara.current_session
  end

end
