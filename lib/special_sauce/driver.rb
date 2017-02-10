class SpecialSauce::Driver

  class << self

    def auth?
      authentication != ':'
    end

    def authentication
      "#{ ENV['SAUCE_USER_NAME'] }:#{ ENV['SAUCE_API_KEY'] }"
    end

    def sauce_endpoint
      "http://#{ authentication }@ondemand.saucelabs.com:80/wd/hub"
    end

    # ENV vars for when running against a single saucelabs browser. (As set by jenkins plugin.)
    #
    # Example running locally against saucelabs:
    # { 'browserName' => 'internet explorer',
    #   'version' => '9',
    #   'platform' => 'Windows 7' }
    #
    # https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities
    def single_browser_caps
      { 'browserName' => ENV['SELENIUM_BROWSER'],
        'version' => ENV['SELENIUM_VERSION'],
        'platform' => ENV['SELENIUM_PLATFORM'] }
    end

    # Set SAUCE_ONDEMAND_BROWSERS when running against multiple saucelabs browers.
    # The value should be a JSON serialized array of browser capabilities.
    # (Set by jenkins plugin.)
    def browsers
      all_browser_caps = ENV['SAUCE_ONDEMAND_BROWSERS'] && JSON.parse(ENV['SAUCE_ONDEMAND_BROWSERS'])
      if all_browser_caps && all_browser_caps.size > 0
        all_browser_caps
      else
        [single_browser_caps]
      end
    end

    # Jenkins plugin doesn't set browserName sometimes.
    def sanitized_browser_options(current_browser_id)
      options = browsers[current_browser_id]
      options['browserName'] ||= options['browser']
      options
    end

    def current_browser_caps
      if ENV['CURRENT_BROWSER_ID']
        sanitized_browser_options(ENV['CURRENT_BROWSER_ID'].to_i)
      else
        single_browser_caps
      end
    end

    def desired_capabilities(options = {})
      options[:plus_caps] ||= {}
      options[:with_caps] || current_browser_caps.merge(options[:plus_caps])
    end

  end

end
