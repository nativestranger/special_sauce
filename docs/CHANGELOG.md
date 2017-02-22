## `special_sauce` CHANGELOG

### 0.1.0 to 0.2.0

* `SpecialSauce::Capybara.current_session` delegates to the more aptly named `SpecialSauce::Capybara.setup_session`.

* `SpecialSauce::Capybara.setup_session` sets the `Capybara.javascript_driver` to `:special_sauce`.
