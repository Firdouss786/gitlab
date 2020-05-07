#### Version 0.97.1 – Feb 19 2020
*   Logic adjustment - Automatically create work pack when a new 'enroute' flight event is received

#### Version 0.97 – Feb 19 2020
*   Ability to flush all flights incase of corrupt data
*	Add feature flag to globally bypass email system during 2-step auth in case of SMTP outage
*	Add dedicated flight processing queue
*	Auto-refresh deferrals board & add fragment caching

#### Version 0.96 – Feb 18 2020
*   Add deferrals dashboard
*   Improve workload page flight status

#### Version 0.95 – Feb 07 2020
*   Add Logistics state management system
*   Add profile & permissions system

#### Version 0.94 – Jan 28 2020

*   Add profile and permission system
*   Add ability to preview a work pack before opening it
*   Add mechanism to automatically create new work packs based on flight data
*   Set base font size for input fields to 16px
*   Fix issue with station and airline checkboxes on user access page
*   Fix inactive user page
*   Fix jump menu routing

#### Version 0.93 – Jan 15 2020

*   Grant access automatically after user creates an airline
*   Add asterisk to form labels for which the input is required
*   Add dedicated BOM upload page
*   Pre-populate email address when inviting new user
*   Enhance empty state partial to accept custom messages

#### Version 0.92 – Dec 19 2019

*   Add empty state UI component
*   Ability to add icons / buttons to header and footer dynamically
*   Apply styling to flight subscriptions page

#### Version 0.91 – Dec 16 2019

*   Add BOM upload mechanism
*   Bug cleanup and access system refactoring

#### Version 0.90 – Dec 06 2019

*   Style login form and provide better feedback in case of username / password errors
*   Default airline / station select dropdown now dynamically populates from the checkboxes on the user access page

#### Version 0.89 – Dec 04 2019

*   Surface session events to users/:id/events so the support team can troubleshoot login and account problems
*   Hide filter input in action toolbar when not applicable
*   Fix bug with search index
*   Add station management page

#### Version 0.88 – Nov 27 2019

*   Add settings pages for Failure Modes, Defer Reasons, Software Platforms, and Maintenance Actions

#### Version 0.87 – Nov 26 2019

*   Add Airline / Station Jump Menu

#### Version 0.86 – Nov 26 2019

*   Add OEM management
*   Fixes to filter box on Mobile
*   Add Zendesk link to 'Help & Support' button

#### Version 0.85 – Nov 21 2019

*   Integrate filter list functionality to Airports page
*	  Improvements to Redis Search
*	  Complete Airport config pages

#### Version 0.84 – Nov 18 2019

*   Add select-all checkbox to table
*   Add design for action bar
*   Update icons on root page

#### Version 0.83 – Nov 11 2019

*   Adding header to user settings

#### Version 0.82 – Nov 06 2019

*   WIP: New header design - Pushing to staging for testing
*   Logic change for unique work validation

#### Version 0.81 – Oct 16 2019

*   Integration of ActivityPlan into workload page
*   Built station users UI
*   Add filterable select menus in work package
*   User modal redesign

#### Version 0.80 – Oct 03 2019

*   Add Mehdi and Stephane to changelog distribution, Welcome!
*   New design for Station Workload page (WIP)
*   New design for contact card
*   Added campaign tasks to work package
*   UI for empty panel state
*   Datepicker added

#### Version 0.79 – Sep 24 2019

*   Workpack Cycle - Build out deferral system
*   Workpack Cycle - Integrate scheduled tasks into work package
*   Workpack Cycle - Introduce TailwindCSS and build out new work package UI
*   Workpack Cycle - Mobile, Tablet, Desktop responsiveness
*   Workpack Cycle - Faults, Corrective Actions, and Fault Resolutions
*   Workpack Cycle - Part Replacements, Ability to update replacement details and batch quantities – auto balance stock levels
*   Workpack Cycle - Tableau Integration for General Maintenance Manual F-003 generation (WIP)

#### Version 0.78 – Jul 26 2019

*   Design work for search page, including new colors, grid, layout and icons

#### Version 0.77 – Jul 19 2019

*   Enhance search mechanism to allow multi-word searches ie "Dual USB"
*   Index products

#### Version 0.76 – Jul 19 2019

*   Enhancements to the way we index search terms. Now we can search for substrings also, ie "Chri" will return "Chris Swann"
*   Add additional indexes scoped to the resource, so we can either search globally or by resource (Address, User etc). Needs UI to implement this

#### Version 0.75 – Jul 17 2019

*   Add experimental global search feature. Currently only Users and Addresses are indexed

#### Version 0.74 – Jul 11 2019

*   Implement corrective action part replacement
*   Prepare workpack layout and fixtures for project

#### Version 0.73 – Jun 27 2019

*   Add pagination to Faults API

#### Version 0.72 – Jun 19 2019

*   Execute script to migrate permissions (home station and default airline) to new access model

#### Version 0.71 – Jun 14 2019

*   Add tooltip mechanism. If there are any form labels which might benefit from further explanation, let us know so we can add a tooltip. Tooltip example active on the 'Failure Confirmed' label when creating a new fault.
*   Add Airline permissions to user settings page. Needs some UI work to make it readable and searchable. https://firefly.staging.topcareife.com/users/332/accesses
*   Add in notifications page. Currently this is just home to the Airline / Station access requests

#### Version 0.70 – Jun 12 2019

*   Redesign part replacement mechanism. New structure allows auto-rollback of erroneous batch quantities
*   New stock item events track changes and errors
*   Ability to decrement and increment batches outside of a work pack, with proper tracking
*   Add API documentation to a dedicated section within the application – https://firefly.staging.topcareife.com/apidocs
*   Enable jump-menu for Airlines
*   Add in CanCan authorization library
*   Implement New Work Pack page - remove need for manual input by allowing user to select from list of inbound flights
*   Redesign user edit pages with new sidebar grid and form grid. Group functionality into logical sections, and spin-off to new pages

#### Version 0.69 – May 15 2019

*   Add validations and conditions around the Fault form Inflight / Ground concept

#### Version 0.68 – May 03 2019

*   Add Faults and Comments API, including documentation

#### Version 0.67 – May 02 2019

*   Add ability to clone a fault. This will open a new Fault form pre-filled with all the information from the cloned fault, which can be changed or saved as-is. Asana Task: https://app.asana.com/0/889937524149830/1120225205155829
*   Add in basic corrective action structure

#### Version 0.66 – Apr 26 2019

*   Add ability for anyone to comment on a fault

#### Version 0.65 – Apr 16 2019

*   Visual changes to the mobile and desktop nav

#### Version 0.64 – Apr 15 2019

*   Laying groundwork and UX for Faults, which will eventually be part of the work package. See https://app.asana.com/0/29577659417002/1118339380693286 for thought process
*   Faults temporarily located under Airlines, limited to 10 faults, for demonstration purposes - https://firefly.staging.topcareife.com/airlines/170/faults

#### Version 0.63 – Apr 11 2019

*   Implement responsive navigation bar for mobile
*   Roll back inclusion of speed indicator. Doesn't seem to be accurate / useful.

#### Version 0.62 – Apr 10 2019

*   Finish deployment of background processing infrastructure
*   Add page speed indicator to top left of every page

#### Version 0.61 – Apr 9 2019

*   Setup background job processing infrastructure, deployment scripts and keep-alive system
*   Mount job monitoring at https://firefly.staging.topcareife.com/sidekiq

#### Version 0.60 – Apr 5 2019

*   Add page for managing Flight Aware subscriptions at an aircraft level. This will be home for other flight connection statistics and troubleshooting tools. https://firefly.staging.topcareife.com/airlines/170/flight_subscriptions

#### Version 0.59 – Apr 4 2019

*   Structural changes to Airline nav to include Deferrals, Tasks, Flights, TSR's and Fleet

#### Version 0.58 – Apr 3 2019

*   Switched main nav Airline link to the default user airline
*   Added subnav items and jump menu for Airlines
*   Password reset styling
*   Separated managers from other users on station users page
*   Implemented of active& inactive users

#### Version 0.57 – Apr 2 2019

*   Move API button to user settings page
*   Email support team when API access key is generated
*   Tie API access lock to user lock

#### Version 0.56 – Mar 22 2019

*   Add token-based API authentication. Users can request a token from the app (link temporarily located in the contact card)
*   API documentation explains how to use Bearer Token. Docs will eventually be published somewhere. Currently they are in the source code repository

#### Version 0.55 – Mar 20 2019

*   User can now set their country code and phone number from their user settings. On mobile, the 'Phone' button in the contact card will be visible. Clicking the button will place their number into your phone' dial pad.

#### Version 0.54 – Mar 18 2019

*   When adding a new user to the station, there is now a guided process to either add an existing user to the team, or create a new user. You can only add a user if you are the station manager. https://firefly.staging.topcareife.com/stations/12/users

#### Version 0.53 – Mar 18 2019

*   Firefly will now redirect external hyperlinks to their proper location after login
*   Drag/Select functionality disabled on mobile as it interferes with scrolling gestures. Will re-evaluate for Phase 2

#### Version 0.52 – Mar 15 2019

*   Hitting Escape key will dismiss modals
*   Fix issue with LOPA where selecting seats too quickly would not register selections

#### Version 0.51 – Mar 14 2019

*   Fix modals on mobile - clicking or tapping outside the modal dismisses it.

#### Version 0.50 – Mar 14 2019

*   Implement jump menu and station switching. From 'My Station', clicking the root node of the breadcrumb will allow you to travel to any stations you have write access to. Clicking 'more' will allow you read-only access to any station.

*   You may request write access to any station by clicking 'Request Full Access'. An email will be sent to the station manager allowing them to authorize the request. This allows technicians to travel or relocate to other stations, or belong to multiple stations.

*WARNING*: The email system is LIVE, requesting access to a station will send an email to that station manager.

See user story for more history on this feature: https://app.asana.com/0/773531675365658/991474697708929

#### Version 0.49 – Mar 11 2019

*   Add seat selection logic to LOPA's. This includes click/drag seat selection. Can be seen at https://firefly.staging.topcareife.com/aircraft_configs/11/seats

#### Version 0.48 – Mar 11 2019

*   Implement contact card modal. When a user avatar (initials in a circle) is clicked on, a card is shown. This is where the users contact information and links to work history will go

#### Version 0.47 – Feb 27 2019

*   Add fix for fetching scheduled flights. Hopefully the ground times will now start populating

#### Version 0.46 – Feb 26 2019

*   Add documentation for API's – Airlines, Aircrafts, AircraftConfigs, Seats

#### Version 0.45 – Feb 25 2019

*   Implement aircraft configuration GET API.
*   Add aircraft configuration to API documentation library
*   Example: `[{"name":"29J","col":"J","row":29,"deck":1,"travel_class":"4"}, ... ]`

#### Version 0.44 – Feb 25 2019

*   Add LOPA links to each configuration - https://firefly.staging.topcareife.com/airlines/7/aircraft_configs
*   Implement dynamic LOPA columns
*   Display message for LOPA's which have not been loaded.
*   Implement optional rendering of second deck

#### Version 0.43 – Feb 22 2019

*   Working on double deck LOPA
*   Revert use of Postmark emailing service since the trial has now expired. The UI is clean and informative, but I'm not sure it's worth the money at the moment. Sticking with AWS SES.

#### Version 0.42 – Feb 14 2019

*   Add LOPA parsing mechanism for Thales and LTV systems
*   Render basic LOPA in a temporary location for now (https://firefly.staging.topcareife.com/aircraft_configs/9/seats)

#### Version 0.41 – Feb 07 2019

*   User can now change their default station by clicking on their user icon
*   User can navigate to any station but also add themselves to other stations, which will define their write access. You can see this feature by clicking the station name in the breadcrumb (https://firefly.staging.topcareife.com/stations)

 ~ Maaz ~

#### Version 0.40 – Feb 06 2019

*   Clean up task template creation UI - ie https://firefly.staging.topcareife.com/airlines/7/task_templates/new

#### Version 0.39 – Feb 05 2019

*   Add users to teams
*   Main nav now defaults to 'My Team' rather than all teams

#### Version 0.38 – Feb 05 2019

*   Import user station associations from Servo 1, user's now have a default station
*   Redirect user to their home station by default on login.

#### Version 0.37 – Feb 04 2019

*   Import Thales Brand Colors
*   Working on library of CSS colors / typography / layout

#### Version 0.36 – Feb 01 2019

*   Restyle the login and password reset screens
*   Bump Rails to 6.0.0.beta1
*   Introduce CSS Grid layout and Block-Element-Modifier CSS pattern

#### Version 0.35 – Jan 29 2019

*   Put the new 'Teams' structure in place. Each station now has a dedicated team page where we can start to build out contact cards and staff lists. The user-to-station associations have not been ported from Servo 1 yet, so only Heathrow is populated with people.

#### Version 0.34 – Jan 23 2019

*   Link up users index page to navigation

#### Version 0.33 – Jan 23 2019

*   Implement application version tracking and notification system. This way we can inform everyone on the development team of the changes being applied to staging.

#### Version 0.32 – Jan 22 2019

*   Link up airlines and tasks management

#### Version 0.31 – Jan 17 2019

*   Improve user mail styling

#### Version 0.30 – Jan 10 2019

*   Add focus to the email field when logging in, and numerous refactoring of the authentication code.

#### Version 0.29 – Jan 09 2019

*   Add ability to create new users, including email sign up and first-login password change requirement

#### Version 0.28 – Jan 04 2019

*   Fetch scheduled flights from Flight Aware

#### Version 0.27 – Jan 02 2019

*   Introduce 2-step authentication

#### Version 0.26 – Dec 16 2018

*   Enhancements to authentication system

#### Version 0.25

*   New flight notification mechanism

#### Version 0.24

*   Troubleshooting ActionController::InvalidAuthenticityToken

#### Version 0.23

*   Add in new typography typescale, card backdrops and pills

#### Version 0.22

*   Add auto activation of tasks (backend logic)

#### Version 0.21

*   Add basic in-air / on-ground filtering to flights UI

#### Version 0.20

*   Model and controller functionality to filter flights by in_air and on_ground. Need to implement UI for this.

#### Version 0.19

*   Changes to redirection of issues from airlines and station

#### Version 0.18

*   Queries to the flight service API are now logged to the analytics service

#### Version 0.17

*   Implement caching for stations, tasks and flights.

#### Version 0.16

*   Clean up Tasks and TSR's for mobile

#### Version 0.15

*   Add TSR's to station maintenance screen. Work in progress.

#### Version 0.14

*   Make campaigns page dual use for airlines and stations

#### Version 0.13

*   Clean up timeline so it looks better on mobile and tablet

#### Version 0.12

*   Menu dropdown content (currently just user avatar) reveals on click, and hides when clicking anywhere else on the page.

#### Version 0.11

*   Start implementation of responsive navbar. Needs JS controller to show / hide popovers.

#### Version 0.10

*   Stations now have multiple associated programs. When visiting `/stations/:id/tasks` there is a list of the associated programs (UI to be improved).


#### Version 0.9

*   Add changelog!
