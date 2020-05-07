# Overview
The FeatureFlag allows you to check if a feature is enabled or not by providing the name of the feature. If the feature name does not exist it returns true. If it exist it returns the status of the feature.

## Usage
A sample usage is shown below:

```
if FeatureFlag.get('feature-name')
  <!-- Your code here -->
end
```
# email_two_step_verification
If our email system is down, by this we have the ability to bypass the email verification system during the login procedure, so that users can still log in. 

# flight_data - Feature flag
 By this `flight_data` feature flag we can prevent the execution of `create` action in `flight_notifications_controller` by setting up this flag. so theat we can enable or disable incoming flight notifications.