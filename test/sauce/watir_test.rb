require 'test_helper'

class SpecialSauce::WatirTest < ActiveSupport::TestCase

  def setup
    @browser_caps = {
      SELENIUM_BROWSER:  'internet explorer',
      SELENIUM_VERSION:  '9',
      SELENIUM_PLATFORM:  'Windows 7'
    }
  end

  test "it runs on sauce labs as expected" do
    ClimateControl.modify(@browser_caps) do
      @browser = SpecialSauce::Watir.browser
      @browser.goto 'http://localhost:3000'
      assert_equal @browser.text, 'Welcome home!'
      @browser.close
    end
  end

end
