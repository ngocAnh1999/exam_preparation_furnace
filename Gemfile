source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

# gem "activerecord-import"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap-sass"
gem "carrierwave"
gem "ckeditor", github: "galetahub/ckeditor"
gem "cocoon"
gem "config"
gem "devise"
gem "faker", :git => "https://github.com/faker-ruby/faker.git", :branch => "master"
gem "figaro"
gem "haml-rails"
gem "jbuilder", "~> 2.7"
gem "kaminari"
gem "mini_magick"
gem "mysql2"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3"
gem "rails-i18n"
gem "redis", "~> 4.0"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-rails"
  gem "pry"
  gem "pry-byebug"
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
