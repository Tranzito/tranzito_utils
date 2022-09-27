require_relative "lib/tranzito_utils/version"

Gem::Specification.new do |spec|
  spec.name = "tranzito_utils"
  spec.version = TranzitoUtils::VERSION
  spec.authors = ["willbarrettdev", "sethherr", "hafiz-ahmed"]
  spec.email = ["info@tranzito.org"]
  spec.homepage = "https://github.com/Tranzito/tranzito_utils"
  spec.summary = "Ruby gem contain several modules mainly containing the helpers, concerns and services for personal use by Tranzito"
  spec.description = "Ruby gem contain several modules mainly containing the helpers, concerns and services for personal use by Tranzito"
  spec.license = "MIT"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Tranzito/tranzito_utils"

  spec.files = [*Dir.glob("{app,config,lib}/**/*").reject { |f| File.directory?(f) }, "Rakefile", "README.md", "MIT-LICENSE"]

  spec.add_dependency "rails", ">= 6.0"
end
