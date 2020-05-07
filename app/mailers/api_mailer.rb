class ApiMailer < ApplicationMailer
    default from: 'firefly@thalesinflight.com'
    
    def api_creation(user,reason)   
      @user = user
      @reason = reason
      mail(to: Firefly::SUPPORT_EMAIL, subject: "A user has generated an API token")
    end
end