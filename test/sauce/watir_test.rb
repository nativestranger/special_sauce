require 'test_helper'

class SpecialSauce::WatirTest < ActiveSupport::TestCase

  def setup
    @ie9_caps = {
      'browserName' =>  'internet explorer',
      'version' =>  '9',
      'platform' => 'Windows 7'
    }

    @ie10_caps = {
      'browserName' =>  'internet explorer',
      'version' =>  '10',
      'platform' => 'Windows 7'
    }

    @ie9_env = {
      SELENIUM_BROWSER:  @ie9_caps['browserName'],
      SELENIUM_VERSION: @ie9_caps['version'],
      SELENIUM_PLATFORM:  @ie9_caps['platform']
    }

    @ie10_env = {
      SELENIUM_BROWSER:  @ie10_caps['browserName'],
      SELENIUM_VERSION:  @ie10_caps['version'],
      SELENIUM_PLATFORM:  @ie10_caps['platform']
    }

    @sauce_ondemand_browsers = [@ie9_caps, @ie10_caps]
  end

  test "SpecialSauce::Watir.browser is nil when auth ENV variables aren't set" do
    ClimateControl.modify(SAUCE_USER_NAME: nil, SAUCE_API_KEY: nil) do
      assert_nil SpecialSauce::Watir.browser
    end
  end

  SETUP_BROWSER = Proc.new {
    additional_caps = {
      'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER'],
      'name' => "special-sauce-watir-#{ENV['TRAVIS_JOB_NUMBER']}"
    }
    browser = SpecialSauce::Watir.browser(
      plus_caps: additional_caps
    )
    browser.goto 'http://localhost:3000'
    browser
  }

  test "it runs on sauce labs as expected when Selenium ENV variables" do
    ClimateControl.modify(@ie9_env) do
      browser = SETUP_BROWSER.call
      assert_equal browser.text, 'Welcome home!'
      browser.close
    end
  end

  test "it runs on sauce labs using the expected browser when SAUCE_ONDEMAND_BROWSERS & CURRENT_BROWSER_ID" do
    ClimateControl.modify(SAUCE_ONDEMAND_BROWSERS: @sauce_ondemand_browsers.to_json, CURRENT_BROWSER_ID: '1') do
      assert_equal SpecialSauce::Watir.desired_capabilities, @ie10_caps
      browser = SETUP_BROWSER.call
      assert_equal browser.text, 'Welcome home!'
      browser.close
    end
  end

end
