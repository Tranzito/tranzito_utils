# TranzitoUtils [![CircleCI](https://dl.circleci.com/status-badge/img/gh/Tranzito/tranzito_utils/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/Tranzito/tranzito_utils/tree/main)

`tranzito_utils` is a ruby gem containing these Rails helpers, concerns and services:

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

```ruby
gem "tranzito_utils"
```

Then run `bundle install`

To include the config file inside your host app run this command.

```shell
rails g tranzito_utils:install
```

This will add the `tranzito_utils.rb` file in the initializer where you can alter the default behaviour of several variables being used throughout the gem.

# Usage

#### SortableTable

To use the SortableTable module, include it in your required controllers:

```rb
include TranzitoUtils::SortableTable
```

You can use the following methods of `TranzitoUtils::SortableTable` in your controllers. These are also the helper methods.

```rb
sort_column, sort_direction
```

#### SetPeriod

Include the `SetPeriod` module in your `ApplicationController` by adding this line:

```rb
include TranzitoUtils::SetPeriod
```

Add this line in the controller where you want to use the `SetPeriod` module:

```rb
before_action :set_period, only: [:index]
```

`SetPeriod` depends on a partial file to show the period_select view for filtering. Include in your views with this:

```erb
<%= render partial: "/tranzito_utils/period_select" %>
```

### Helpers

For gems helpers, you need to add this into your `application_helper.rb` file.

```rb
include TranzitoUtils::Helpers
```

### Flash Message

You can include the flash messages into your application by add it's partial in your layouts file.

```erb
<%= render partial: "/tranzito_utils/flash_messages" %>
```

### Assets

To include the styles from the gem you need to add this into your application.scss, this will include the compiled CSS into your application.

```js
@import url('/tranzito_utils-compiled.css')
```

## tranzito_utils_js (npm)
You also need to add this NPM package in order to use the gem without any issue. You can install it using `yarn` or `npm`.

For yarn:

```shell
yarn add tranzito_utils_js

```
For npm

```shell
npm install tranzito_utils_js
```

Then import it into your application by adding this line in `application.js` or any `.js` file where you need it:

```js
import { PeriodSelector, TimeParser } from "tranzito_utils_js"
```

Initialize them like this:

```js

document.addEventListener('DOMContentLoaded', function () {
  if (!window.timeParser) { window.timeParser = new TimeParser() }
  window.timeParser.localize()

  if (document.getElementById('timeSelectionBtnGroup')) {
    const periodSelector = new PeriodSelector()
    periodSelector.init()
  }
}
```

(if using [turbo](https://github.com/hotwired/turbo-rails), switch `'DOMContentLoaded'` to `'turbo:load'`)

## License

The gem is available as open source under the terms of the [MIT License](MIT-LICENSE).

## Development

Compile the updated styles:

```shell
cd tranzito_utils_js
yarn build:css
```

## Testing

To setup testing, you have to create the database:

```shell
cd spec/dummy
RAILS_ENV=test bundle exec rails db:create db:schema:load db:migrate
```
