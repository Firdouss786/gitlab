# Activity

### Validations

#### Creation
**Auto assigned values:**
- `created_by` will be set to `Current.user` if the logged in user have access to aircraft and station.
- `state`	is an enum which can be only take one of these values [created, open, complete, error].

**User provided values:**
- `*station` must be one of the approved `created_by` user station.
- `*aircraft` must be under one of the approved airline of `created_by` user.

*Required fields based on condition:*
- `*flight` must have same aircraft as `self.aircraft`.
OR
- `*inbound_airport` if `flight` is missing.
- `*outbound_airport` if `flight` is missing.
- `*inbound_flight_number` if `flight` is missing.
- `*outbound_flight_number` if `flight` is missing.

Besides above mappings, activities model will also make sure to check for the following conditions:
- Cannot open a duplicate activity for same aircraft globally.
- No update is allowed if activity is complete or in error state.
- Cannot change aircraft or station after activity creation.

#### Fields no longer used in Firefly
- `started_at` - will use `created_at` instead.
- `is_open` was called `status` in Servo. We migrated from this boolean field to `state` in Firefly.
- `user` was only used twice in Servo.

#### Filters for fetching the flight details for user's station
- `Now` - will give the list of all the flights for the user of the particular station.
- `Arriving` - will list out all the aircrafts which are inbound to the user's station.
- `Landed` - will list out all the aircrafts which landed/arrived and is/getting ready for outbound from user's station.