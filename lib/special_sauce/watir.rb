module SpecialSauce
  class Watir < SpecialSauce::Driver

    def self.browser(options = {})
      puts "Sauce Labs auth ENV variables not set." && return unless auth?

      ::Watir::Browser.new(
        :remote,
        url: sauce_endpoint,
        desired_capabilities: desired_capabilities(options)
      )
    end

  end
end
