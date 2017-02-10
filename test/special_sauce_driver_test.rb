require 'test_helper'

class SpecialSauce::DriverTest < ActiveSupport::TestCase

  def setup
    @dummy_browser_caps = {
      'browserName' => 'b',
      'version' => 'v',
      'platform' => 'p'
    }

    @dummy_ondemand_browsers = [@dummy_browser_caps, @dummy_browser_caps.merge('key' => 'val')]
  end

  test "SpecialSauce::Driver exists" do
    assert_kind_of Class, SpecialSauce::Driver
  end

  test "SpecialSauce::Driver.auth? returns false when auth ENV variables aren't set" do
    ClimateControl.modify(SAUCE_USER_NAME: nil, SAUCE_API_KEY: nil) do
      assert_equal false, SpecialSauce::Driver.auth?
    end
  end

  test "SpecialSauce::Driver.auth? returns true when auth ENV variables are set" do
    ClimateControl.modify(SAUCE_USER_NAME: 'u', SAUCE_API_KEY: 'k') do
      assert_equal true, SpecialSauce::Driver.auth?
    end
  end

  test "SpecialSauce::Driver.authentication is set as expected based on auth ENV variables" do
    ClimateControl.modify(SAUCE_USER_NAME: 'usr', SAUCE_API_KEY: 'key') do
      assert_equal 'usr:key', SpecialSauce::Driver.authentication
    end
  end

  test "SpecialSauce::Driver.sauce_endpoint is set as expected based on auth ENV variables" do
    ClimateControl.modify(SAUCE_USER_NAME: 'usr', SAUCE_API_KEY: 'key') do
      assert_equal "http://usr:key@ondemand.saucelabs.com:80/wd/hub", SpecialSauce::Driver.sauce_endpoint
    end
  end

  test "SpecialSauce::Driver.browsers is set as expected when Selenium ENV variables" do
    ClimateControl.modify(SELENIUM_BROWSER: 'b', SELENIUM_VERSION: 'v', SELENIUM_PLATFORM: 'p') do
      assert_equal(
        [@dummy_browser_caps],
        SpecialSauce::Driver.browsers
      )
    end
  end

  test "SpecialSauce::Driver.browsers is set as expected when SAUCE_ONDEMAND_BROWSERS" do
    ClimateControl.modify(SAUCE_ONDEMAND_BROWSERS: @dummy_ondemand_browsers.to_json) do
      assert_equal(
        @dummy_ondemand_browsers,
        SpecialSauce::Driver.browsers
      )
    end
  end

  test "SpecialSauce::Driver.current_browser_caps is set as expected when Selenium ENV variables" do
    ClimateControl.modify(SELENIUM_BROWSER: 'b', SELENIUM_VERSION: 'v', SELENIUM_PLATFORM: 'p') do
      assert_equal(
        @dummy_browser_caps,
        SpecialSauce::Driver.current_browser_caps
      )
    end
  end

  test "SpecialSauce::Driver.current_browser_caps is set as expected when SAUCE_ONDEMAND_BROWSERS & CURRENT_BROWSER_ID" do
    ClimateControl.modify(SAUCE_ONDEMAND_BROWSERS: @dummy_ondemand_browsers.to_json, CURRENT_BROWSER_ID: '1') do
      assert_equal(
        @dummy_ondemand_browsers.last,
        SpecialSauce::Driver.current_browser_caps
      )
    end
  end

  test "SpecialSauce::Driver.desired_capabilities delegates to current_browser_caps when no options" do
    ClimateControl.modify(SELENIUM_BROWSER: 'b', SELENIUM_VERSION: 'v', SELENIUM_PLATFORM: 'p') do
      assert_equal(
        @dummy_browser_caps,
        SpecialSauce::Driver.desired_capabilities
      )
    end
  end

  test "SpecialSauce::Driver.desired_capabilities returns using_caps option when passed" do
    ClimateControl.modify(SELENIUM_BROWSER: 'b', SELENIUM_VERSION: 'v', SELENIUM_PLATFORM: 'p') do
      assert_equal(
        { 'someCap' => 'someVal' },
        SpecialSauce::Driver.desired_capabilities(using_caps: { 'someCap' => 'someVal' })
      )
    end
  end

  test "SpecialSauce::Driver.desired_capabilities merges current_browser_caps with plus_caps option when passed" do
    ClimateControl.modify(SELENIUM_BROWSER: 'b', SELENIUM_VERSION: 'v', SELENIUM_PLATFORM: 'p') do
      assert_equal(
        @dummy_browser_caps.merge({ 'someCap' => 'someVal' }),
        SpecialSauce::Driver.desired_capabilities(plus_caps: { 'someCap' => 'someVal' })
      )
    end
  end

end
