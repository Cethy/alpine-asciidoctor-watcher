#!/bin/sh

echo "watching $INPUT_DIR ..."
cd $INPUT_DIR
BUNDLE_GEMFILE=/app/Gemfile bundle exec guard -G /app/Guardfile
