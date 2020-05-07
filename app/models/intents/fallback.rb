class Intents::Fallback
  include AlexaIntent

  def self.handle
    "This is the fallback response"
  end

end
