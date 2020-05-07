require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'
require 'aasm/minitest'

class ActiveSupport::TestCase
  # parallelize(workers: 2)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  WebMock.disable_net_connect!(allow: "chromedriver.storage.googleapis.com", allow_localhost: true)

  def sign_in_as(user)
    post login_path, params: { session: { email: user.email, password: "foobar" } }
  end

  def browser_sign_in_as(user)
    visit login_url
    fill_in("session[email]", with: user.email)
    fill_in("session[password]", with: "foobar")
    click_on "Log in"
  end
end
