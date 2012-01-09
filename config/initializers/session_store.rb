# Be sure to restart your server when you modify this file.

studyegg_config_file = File.join(Rails.root,'config','studyegg.yml')
raise "#{studyegg_config_file} is missing!" unless File.exists? studyegg_config_file
studyegg_config = YAML.load_file(studyegg_config_file)[Rails.env].symbolize_keys
puts studyegg_config[:domain]
puts "#{studyegg_config[:domain]}"
StudyeggUserManager::Application.config.session_store :cookie_store, :key => '_studyegg', :domain => :all

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# OauthClientDemo::Application.config.session_store :active_record_store
