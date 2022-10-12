# TranzitoUtils [![CircleCI](https://dl.circleci.com/status-badge/img/gh/Tranzito/tranzito_utils/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/Tranzito/tranzito_utils/tree/main)

`tranzito_utils` is a ruby gem containing these Rails helpers, concerns and services.

| Name | Type | Description |
| ---- | ---- | ----------- |
| `SetPeriod` | Controller Concern | Time period selection and browsing |
| `SortableTable` | Controller Concern | Sort column and direction  |
| `TimeParser` | Service | Parse time strings into activerecord time objects |
| `Normalize` | Service | Normalize truthy and falsey strings |
| `GraphingHelper` | Helper | Graphing helper for [chartkick](https://chartkick.com/) charts |
| `SortableHelper` | Helper | Sort table headers |

# Installation

## tranzito_utils (gem)
Install the gem by adding this line to your application's Gemfile:

```
gem "tranzito_utils"
```

Then run `bundle install`

To include the config file inside your host app run this command.

```
rails g tranzito_utils:install
```

This will add the `tranzito_utils.rb` file in the initializer where you can alter the default behaviour of several variables being used throughout the gem.


# Usage

#### SortableTable

To use the SortableTable module you can include it in your required controllers and then be able to use its methods.

```
include TranzitoUtils::SortableTable
```

You can use the following methods of ` TranzitoUtils::SortableTable` in your controllers. These are also the helper methods.

```
sort_column, sort_direction
```

#### SetPeriod

Include the `SetPeriod` module into your `ApplicationController` by adding this line

```
include TranzitoUtils::SetPeriod
```

You just need to add this line in the controller where you want to use the `SetPeriod` module.

```
  before_action :set_period, only: [:index]
```

Also, the `SetPeriod` has a partial file which you can include in your views using this line.

```
render partial: "/tranzito_utils/period_select"
```

This will include the period_select view for filtering.

### Helpers

For gems helpers, you need to add this into your `application_helper.rb` file.

```
include TranzitoUtils::Helpers
```

### Flash Message

You can include the flash messages into your application by add it's partial in your layouts file.

```
render partial: "/tranzito_utils/flash_messages"
```
### Assets

To include the styles from the gem you need to add this into your application.scss, this will include the compiled CSS into your application.

```
@import url('/tranzito_utils-compiled.css')
```
## tranzito_utils_js (npm)
You also need to add this NPM package in order to use the gem without any issue. You can install it using `yarn` or `npm`.

For yarn
```
yarn add tranzito_utils_js
```
For npm
```
npm install tranzito_utils_js
```

Then import it into your application by adding this line in `application.js` or any `.js` file where you need it.

```
import { PeriodSelector, TimeParser } from "tranzito_utils_js"
```
Here `TimeParser` and `PeriodSelector` are classes we can use in our app.

For `TimeParser` You can use it by initializing like this

```
if (!window.timeParser) { window.timeParser = new TimeParser() }
window.timeParser.localize()
```

As for `PeriodSelector`, you can use it by initializing like this
```
  if (document.getElementById('timeSelectionBtnGroup')) {
    const periodSelector = new PeriodSelector()
    periodSelector.init()
  }
```
`#timeSelectionBtnGroup` is being used in the partial in `tranzito_utils` gem.
## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Development

To compile the updated styles run these command 
```
cd tranzito_utils_js
yarn build:css
```

## Testing

To setup testing, you have to create the database:

```shell
cd spec/dummy
RAILS_ENV=test bundle exec rails db:create db:schema:load db:migrate
```
