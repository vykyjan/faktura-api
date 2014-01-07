# Load the Rails application.
require File.expand_path('../application', __FILE__)


ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['app18597214@heroku.com'],
    :password       => ENV['1implfjs'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
}

# Initialize the Rails application.
FakturaApi::Application.initialize!
