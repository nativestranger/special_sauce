module SpecialSauce
  class Watir < SpecialSauce::Driver

    def self.browser(options = {})
      unless auth?
        Kernel.warn(
          'Sauce Labs auth ENV variables not set ... skipping SpecialSauce::Watir.browser'
        )
        return
      end

      ::Watir::Browser.new(
        :remote,
        url: sauce_endpoint,
        desired_capabilities: desired_capabilities(options)
      )
    end

  end
end
