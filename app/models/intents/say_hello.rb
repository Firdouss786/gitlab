class Intents::SayHello
  include AlexaIntent

  def self.handle
    "Hello from Servo!"
  end

end
