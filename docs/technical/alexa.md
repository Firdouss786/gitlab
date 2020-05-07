# Alexa
Firefly has the ability to receive voice command intents from an Alexa skill.

## Intent Handler
A controller handles incoming intents and routes them to the correct models. This is located at `app/controllers/intent_handlers_controller.rb`

## Intents
Intents are in `app/models/intents`. There is also an `AlexaIntent` concern mixed in to all these classes, so common code can be shared.

## Testing
We'll need to fake some incoming intents in order to test the intent handler and intent models. We can use the same method applied in `test/controllers/flight_notifications_controller_test.rb`.
