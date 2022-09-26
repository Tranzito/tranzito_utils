source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in tranzito_utils.gemspec.
gemspec

group :development, :test do
  gem "standard" # Ruby linter
  gem "rspec-rails" # Test framework
  gem "rspec_junit_formatter" # For circle ci
  gem "rails-controller-testing"
  gem "hamlit" # You need to have haml rendering in your app.
end

group :test do
  gem "pg"
  gem "hamlit"
end
