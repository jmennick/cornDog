FROM ruby:2.3
MAINTAINER gsmith@rockform.com

# Default to production
# (because deployment, duh)
ENV RAILS_ENV production

# Default to port 3000
# (because that's the default port)
ENV HTTP_PORT 3000

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

# Configure the main working directory.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install the RubyGems.
# Dependencies will be cached unless changes are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./

# Precompile the assets (asset chain doesn't work in production)
# (note this should only happen when this is running in production)
# RUN [ "$RAILS_ENV" == "production" ] && bundle exec rake assets:precompile

# Expose port 3000 to the Docker host, so we can access it from the outside.
EXPOSE ${HTTP_PORT}

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["rails", "server", "-b", "0.0.0.0", "--port", ${HTTP_PORT}]
