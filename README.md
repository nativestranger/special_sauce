# SpecialSauce
special_sauce makes it easy to run existing [capybara](https://github.com/teamcapybara/capybara) or [watir](https://github.com/watir/watir) based tests against [SauceLabs](https://saucelabs.com/) browsers.

## Installation

```ruby
gem 'special_sauce', git: 'https://github.com/nativestranger/special_sauce.git'
```

## Watir Example

If the authentication ENV variables are set, `special_sauce` will try to setup a remote browser, otherwise default to chrome.

``` ruby
@browser = SpecialSauce::Watir.browser || Watir::Browser.new(:chrome)
```

## Capybara Example

If the authentication ENV variables are set, `special_sauce` will try to setup a remote browser, otherwise use your capybara default.

``` ruby
@browser = SpecialSauce::Capybara.browser || Capybara.current_session
```

## Environment Variables

In order to create remote sessions with Sauce Labs, some environment variables must be set.

**Authentication Variables - Required**

| Environment Variable   |      Value                               |
|----------              |:----------------------------------------:|
| SAUCE_USER_NAME        | your saucelabs username                  |
| SAUCE_API_KEY          | saucelabs api key for your username      |

**Optional**

*The following 3 are set automatically when Jenkin's [Sauce OnDemand Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Sauce+OnDemand+Plugin) is configured to run against **one browser**.*

| Environment Variable   |      Value                               |
|----------              |:----------------------------------------:|
| SELENIUM_BROWSER       | browser name                             |
| SELENIUM_VERSION       | browser version                          |
| SELENIUM_PLATFORM      | operating system & version               |

OR

*`SAUCE_ONDEMAND_BROWSERS` is set automatically when Jenkin's [Sauce OnDemand Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Sauce+OnDemand+Plugin) is configured to run against **multiple browsers**.*

| Environment Variable    |      Value                                     |
|----------               |:----------------------------------------------:|
| SAUCE_ONDEMAND_BROWSERS | JSON serialized array of browser capabilities  |
| CURRENT_BROWSER_ID | **Set this to choose the browser caps from `SAUCE_ONDEMAND_BROWSERS` that should be used. '0' will be the first in the array, '1' will be the second, etc.** |

## How Browser Capabilities are set.

When calling `SpecialSauce::Watir.browser` or `SpecialSauce::Capybara.browser` without any arguments, `special_sauce` will use the environment variables above to determine browser capabilities.

* When `SAUCE_ONDEMAND_BROWSERS` is absent, `SELENIUM_BROWSER`, `SELENIUM_VERSION`, and `SELENIUM_PLATFORM` is used.

* When `SAUCE_ONDEMAND_BROWSERS` is present, the value is parsed into an array and the caps are set based on `CURRENT_BROWSER_ID`.

## Adding Browser Capabilities
To add additional browser capabilities, use `plus_caps`:

``` ruby
additional_caps = { 'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER'] }
@browser = SpecialSauce::Watir.browser(plus_caps: additional_caps)
```

## Overriding Browser Capabilities
To override default browser capabilities, use `using_caps`:

``` ruby
custom_caps = { 'browserName' => 'internet explorer',
                'version' => '9',
                'platform' => 'Windows 7' }
@browser = SpecialSauce::Watir.browser(using_caps: custom_caps)
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# TODO

* appraise more versions of ruby & versions of capybara & watir.
* allow customization of ENV variables?
* update description
* add contributing version
