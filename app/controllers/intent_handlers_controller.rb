# :nocov:
class IntentHandlersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    intent_name = request["request"]["intent"]["name"]
    slots = request["request"]["intent"]["slots"]

    case intent_name
    when 'AMAZON.FallbackIntent'
      response = "Intents::Fallback".constantize.handle
    when 'AMAZON.CancelIntent'
      response = "Intents::Cancel".constantize.handle
    when 'AMAZON.StopIntent'
      response = "Intents::Stop".constantize.handle
    when 'AMAZON.HelpIntent'
      response = "Intents::Help".constantize.handle
    else
      response = "Intents::#{intent_name}".constantize.handle(slots)
    end

    render json: {
      version: "1.0",
      response: {
        outputSpeech: {
          type: "PlainText",
          text: response
        }
      }
    }
  end
end
# :nocov:
