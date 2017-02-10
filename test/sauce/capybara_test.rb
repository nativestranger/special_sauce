require 'test_helper'

class SpecialSauce::CapybaraTest < ActiveSupport::TestCase

  def setup
    ENV['SELENIUM_BROWSER'] =  'internet explorer'
    ENV['SELENIUM_VERSION'] =  '9'
    ENV['SELENIUM_PLATFORM'] =  'Windows 7'
    @browser = SpecialSauce::Capybara.browser
  end

  test "it runs on sauce labs as expected" do
    @browser.visit 'http://localhost:3000'
    assert_equal @browser.text, 'Welcome home!'
  end
end
