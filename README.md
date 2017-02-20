# SpecialSauce

[![Build Status](https://travis-ci.org/nativestranger/special_sauce.svg?branch=master)](https://travis-ci.org/nativestranger/special_sauce)


special_sauce makes it easy to run existing [capybara](https://github.com/teamcapybara/capybara) or [watir](https://github.com/watir/watir) based tests against [SauceLabs](https://saucelabs.com/) browsers.

## Installation

```ruby
gem 'special_sauce', '0.1.0'
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

`special_sauce` relies on the following env vars to set up remote sessions with sauce labs.

You can set these explicitly or rely on the [Sauce OnDemand Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Sauce+OnDemand+Plugin) to set them in Jenkins builds.

**Authentication Variables - Required**

| Environment Variable   |      Value                               |
|----------              |:----------------------------------------:|
| SAUCE_USER_NAME        | your saucelabs username                  |
| SAUCE_API_KEY          | saucelabs api key for your username      |

## How Browser Capabilities are set.

When calling `SpecialSauce::Watir.browser` or `SpecialSauce::Capybara.browser` without any arguments, `special_sauce` will use environment to determine browser capabilities.

You may set these explicitly [or rely on the Sauce OnDemand Plugin](docs/JENKINS_PLUGIN_ENV.md) to set them for you.

**It is recommended you explicitly declare your browser capabilities with `using_caps`.**

## Overriding Browser Capabilities
To override default browser capabilities, use `using_caps`:

``` ruby
custom_caps = { 'browserName' => 'internet explorer',
                'version' => '9',
                'platform' => 'Windows 7' }
@browser = SpecialSauce::Watir.browser(using_caps: custom_caps)
```

## Adding Browser Capabilities
To add additional browser capabilities, use `plus_caps`:

``` ruby
additional_caps = { 'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER'] }
@browser = SpecialSauce::Watir.browser(plus_caps: additional_caps)
```

## Sauce Labs Options

See [Sauce Lab's Documentation](https://wiki.saucelabs.com/display/DOCS/Test+Configuration+Options) for more options such as test name, build number, and screen resolution.

``` ruby
additional_caps = { 'name' => 'my test name', 'screenResolution' => '1280x1024' }
@browser = SpecialSauce::Watir.browser(plus_caps: additional_caps)
```

## [Tips for running against multiple browsers](docs/MULTIPLEBROWSERS.md)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# TODO

* appraise more versions of ruby & versions of capybara & watir.
* allow customization of ENV variables?
* update description
* add 'contributing' section
