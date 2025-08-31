# frozen_string_literal: true

require_relative "lib/browser_sense/version"

Gem::Specification.new do |spec|
  spec.name = "browser_sense"
  spec.version = BrowserSense::VERSION
  spec.authors = ["Adolfo Villafiorita"]
  spec.email = ["adolfo@shair.tech"]

  spec.summary = "Monitor which browser is accessing your Ruby on Rails app."
  spec.description = <<-EOS
     BrowserSense logs information about the browser accessing your
     RubyOnRails app.  

     Installation is pretty simple:

     1. Add =gem "browser_sense"= to your Gemfile

     2. Add the following line to your =application_controller.rb=:

        browser_sense

     Data is stored in csv format in Rails' production log.  Each URL invocation
     generates a log line.

     Extract browser info data with:

        grep BrowserSense development.log | cut -f2- -d:

     Analyize with

        browser-info log/production.log > output.txt

     or with log_sense (https://rubygems.org/gems/log_sense)

     BrowserSense relies on the browser gem to get informaton about the browsers.
  EOS
  spec.homepage = "https://github.com/shair-tech/browser_sense"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/shair-tech/browser_sense"
  spec.metadata["changelog_uri"] = "https://github.com/shair-tech/browser_sense/blob/main/CHANGELOG.org"

  # Specify which files should be added to the gem when it is released.  The
  # `git ls-files -z` loads the files in the RubyGem that have been added into
  # git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "browser", "~> 6.2.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
