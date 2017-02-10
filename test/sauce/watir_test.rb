require 'test_helper'

class SpecialSauce::WatirTest < ActiveSupport::TestCase

  def setup
    ENV['SELENIUM_BROWSER'] =  'internet explorer'
    ENV['SELENIUM_VERSION'] =  '9'
    ENV['SELENIUM_PLATFORM'] =  'Windows 7'
    @browser = SpecialSauce::Watir.browser
  end

  def teardown
    @browser.close
  end

  test "it runs on sauce labs as expected" do
    @browser.goto 'http://localhost:3000'
    assert_equal @browser.text, 'Welcome home!'
  end
end
