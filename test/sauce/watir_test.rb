require 'test_helper'

class SpecialSauce::WatirTest < ActiveSupport::TestCase

  def setup
    @browser_caps = {
      SELENIUM_BROWSER:  'internet explorer',
      SELENIUM_VERSION:  '9',
      SELENIUM_PLATFORM:  'Windows 7'
    }
  end

  test "SpecialSauce::Watir.browser is nil when auth ENV variables aren't set" do
    ClimateControl.modify(SAUCE_USER_NAME: nil, SAUCE_API_KEY: nil) do
      assert_nil SpecialSauce::Watir.browser
    end
  end

  test "it runs on sauce labs as expected with Selenium ENV variables" do
    ClimateControl.modify(@browser_caps) do
      @browser = SpecialSauce::Watir.browser(
        plus_caps: { 'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER'] }
      )
      @browser.goto 'http://localhost:3000'
      assert_equal @browser.text, 'Welcome home!'
      @browser.close
    end
  end

end
