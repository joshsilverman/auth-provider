# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

USER1 = {"provider"=>"edmodo",
                              "uid"=>1,
                              "info"=>{"name"=>"Test User",
                                      "email"=>"test@studyegg.com",
                                      "first_name"=>"Test",
                                      "last_name"=>"User",
                                      "school"=>"edmodo",
                                      "user_type"=>"TEACHER",
                                      "user_token"=>"330d83cb6her",
                                      "groups"=>[12345]},
                              "credentials"=>{"token"=>"",
                                      "refresh_token"=>"",
                                      "expires_at"=>nil,
                                      "expires"=>false},
                              "extra"=>{
                                "user_hash"=>{"provider"=>"edmodo",
                                                  "uid"=>1,
                                                  "info"=>{"name"=>"Test User",
                                                          "email"=>"test@studyegg.com",
                                                          "first_name"=>"Test",
                                                          "last_name"=>"User",
                                                          "school"=>"edmodo",
                                                          "user_type"=>"TEACHER",
                                                          "user_token"=>"330d83cb6her",
                                                          "groups"=>[12345]}}}}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end
