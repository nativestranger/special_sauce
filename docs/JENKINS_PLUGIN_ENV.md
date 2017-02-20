## Environment Variables continued.

Unless you explicitly pass browser capabilities when creating a remote session with Sauce Labs (recommended), one of the following sets of environment variables must be set.

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
