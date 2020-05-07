# API Tokens
The `app/controllers/users/tokens_controller.rb` is responsible for generating tokens. These are stores in the `token` column on the `User` table.

The `authenticate_by_token` method of the `authentication` concern will ensure that the token is valid, and handle the 'unauthorized' header response if it's not.

The token is a standard Bearer token. Further details on how to access the API are located in the API documentation readme file.
