FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript

RUN mkdir -p /app
RUN mkdir -p /usr/local/nvm
WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

RUN node -v
RUN npm -v 
# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.

COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN gem install bundler
RUN bundle install --verbose --jobs 20 --retry 5


RUN npm install -g yarn
RUN yarn install --check-files
COPY . ./

COPY dockershell.sh script.sh ./
RUN chmod +x dockershell.sh
RUN chmod +x script.sh
RUN gem list
#ENTRYPOINT ["sh"]
#CMD ["dockershell.sh ; index.sh"]
#CMD sh dockershell.sh
#CMD echo "REDIS.flushdb" | rails c
#CMD echo "Search::IndexAll.new.perform" | rails c
#sidekiq -C config/sidekiq.yml.erb
#RUN bundle exec sidekiq -C ./config/sidekiq.yml


#adding arguments
#ARG CI_REGISTRY_IMAGE
#ARG CI_COMMIT_SHA

#RUN echo "registry name: $CI_REGISTRY_IMAGE"
#RUN echo "commit id: $CI_COMMIT_SHA"
#RUN bundle exec rake tmp:create yarn:install assets:precompile
#RUN bundle exec rake assets:precompile

# Copy the main application.
#COPY . ./
#CMD ["bundle", "exec", "sidekiq", "-C", "config/sidekiq.yml", "config/environments/development.rb"]
ARG ENV_NAME=production
ENV ENV_NAME="${ENV_NAME}"
#RUN ng build --configuration=${ENV_NAME}
RUN echo $ENV_NAME


# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000 3001
# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
#CMD bundle exec puma -e $ENV_NAME -C config/puma.rb & ./dockershell.sh
CMD RAILS_ENV=$ENV_NAME bundle exec puma -C config/puma.rb & ./dockershell.sh

