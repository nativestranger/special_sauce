class SpecialSauce::Watir < SpecialSauce::Driver

  def self.browser
    puts "Sauce Labs auth ENV variables not set." && return unless auth?

    ::Watir::Browser.new(
      :remote,
      url: sauce_endpoint,
      desired_capabilities: current_browser_caps
    )
  end

end
