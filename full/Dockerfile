FROM cethy/alpine-asciidoctor-builder:latest

# replace entrypoint script
RUN mv /bin/entrypoint.sh /bin/build.sh
COPY ./entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

# Install ruby Guard app
# copy app
COPY ./app/* /app/

WORKDIR /app
# install dev deps in --virtual, gem install and cleanup
RUN apk --update add --virtual build-dependencies build-base ruby-dev libffi-dev \
    && gem install bundler --no-ri --no-rdoc \
    && bundle install --without development test \
    && apk del build-dependencies
