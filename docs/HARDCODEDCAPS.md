## Running each scenario against hardcoded browser caps

``` ruby
# spec/support/sauce_browsers.rb
class SauceBrowsers
  All = [
    { 'browserName' => 'chrome', 'version' => 'latest', 'platform' => 'OS X 10.12' },
    { 'browserName' => 'firefox', 'version' => 'latest', 'platform' => 'OS X 10.12' }
  ]

  def self.each
    All.each do |caps|
      yield(caps)
    end
  end
end
```

``` ruby
# spec/support/browsers.rb
class Browsers
  def self.each(&block)
    if SpecialSauce::Driver.auth?
      SauceBrowsers.each &block
    else
      yield({ 'browserName' => 'chrome', 'version' => 'local-version' }) # assume local chrome unless Sauce auth
    end
  end
end
```

``` ruby
# spec/support/sauce_config.rb
RSpec.configure do |config|
  config.before(:example, type: :sauce) do |example|
    other_caps = {
      'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER'] || ENV['TUNNEL_IDENTIFIER'],
      'name' => "#{build}-#{example.description.gsub(' ', '-')}"
    }

    caps = example.metadata[:browser_caps].merge(other_caps)

    @browser = SpecialSauce::Watir.browser(using_caps: caps) || Watir::Browser.new(:chrome)
  end

  config.after(:example, type: :sauce) do
    @browser.close
  end
end
```

``` ruby
# spec/features/some_spec.rb
feature 'Some Feature', type: :sauce do

  Browsers.each do |browser_caps|
    browser_details = "#{browser_caps['browserName']} #{browser_caps['version']}"
    scenario "my scenario description #{ browser_details }", browser_caps: browser_caps do
      # write your spec using @browser here
    end
  end

end
```
