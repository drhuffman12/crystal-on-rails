FROM crystallang/crystal
MAINTAINER Thomas Nalevajko <thomas.nalevajko@github.com>


# Install Postgres Client Tools
RUN apt-get update && apt-get install \
  -y --no-install-recommends \
  postgresql-client


# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Setup environment
ENV APP_HOME /app
WORKDIR $APP_HOME
