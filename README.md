# Firefly
Firefly is a web application for maintaining aircraft. It is written in Ruby on Rails, backed by a MySQL Database.
It uses standard ERB templates, and [Stimulus](https://stimulusjs.org) to organize vanilla ES6 Javascript.

### Ruby
We recommend using [Rbenv](https://github.com/rbenv/rbenv) to install Ruby, as Mac OS comes with an old version. The `.ruby-version` file in the root directory specifies the Ruby version that Firefly is currently using.

### Database
Firefly uses a standard MySQL installation. To create the local databases, run `rails db:create`, `rails db:schema:load` and then `rails db:fixtures:load` to load in the test data.

### Dependencies
Ruby dependencies, called 'gems', are managed via bundler. From the root of the project, run the `bundle` command. Javascript dependencies are managed by webpacker & yarn. To install this, `brew install yarn` and `yarn install` from the project root.

Firefly also depends upon an installation of Redis to run the Search tests. If on Mac OS, run `brew bundle` to install Redis.

### Start Development Mode
To start the project in development, simply `cd` to the root directory and run `rails server`, or `rails s` for short. This will start a local server, then you can navigate to `localhost:3000` in your browser.

### Static Assets
CSS and Images can be found in `app/assets`. Assets are compiled in production to be served by Nginx – `rails assets:precompile`. You don't need to do this in development as Rails serves up assets via it's built-in server.

### Javascript
We use a minimal framework called [Stimulus](https://stimulusjs.org) for all our Javascript. Stimulus does not render any HTML, and is designed to only augment the HTML which is already rendered by the Rails controllers. The javascript is written in ES6, and can be found in `app/javascript/packs`. You can read more about it on their website, but essentially everything is organized into 'controllers'.

We use Stimulus instead of a heavier framework like Angular, mostly to cut down on the amount of code we need to write (1 MVC framework instead of 2). By relying on the server to render HTML, we also gain a server-based caching strategy called [Russian Doll Caching](https://blog.appsignal.com/2018/04/03/russian-doll-caching-in-rails.html), which provides performance similar to a SPA (Single Page App).

NOTE: There are coffeescript files in /assets/javascripts, but we don't use these.

### Encrypted Secrets
Application credentials are stored within the source code repository but are encrypted using a master key, stored in
`config/master.key`. You must obtain a copy of this key from chris.swann@us.thalesgroup.com. Once you have this key, you may read and write the encrypted credentials using `EDITOR=vim rails credentials:edit`

### Testing
Test coverage should be maintained for the majority of the application. System & controller tests are preferred as they test the application at broad, but unit tests are also used for more complex business logic. To run the test suite, run `rails test`. This instantiates a new test database and populates it with fixtures (test data). Tests can be found in the `tests` directory.

### Documentation
There is documentation for developers in the /docs directory.

### Deployment
Firefly is using [Capistrano](https://capistranorb.com/) to deploy the application to production. Simply run `cap <environment> deploy`.

### API's
Firefly employs RESTful API's using a gem called [jBuilder](https://github.com/rails/jbuilder) which is bundled with the Rails framework, and configured automatically when new resources are created. Generally there is a `.json.jbuilder` file for both the index and show of every resource, which are stored in the `/app/views` directory. Either the HTML view or JSON view are served by the controller based on the extension in the URL, for example requesting `http://localhost:3000/users`  will return the HTML page, whereas requesting `http://localhost:3000/users.json` will return the JSON version.

Documentation for the API's is in `/docs/api`

### Golive
There are some scripts which need to be run on go live day:

#### Migrate consumables, which were previously recorded on to corrective actions, to the Replacements table.
`MigrateBatchConsumptionsToReplacements.perform(days_ago: 1000)` 
