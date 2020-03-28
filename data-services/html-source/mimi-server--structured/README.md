# This simple example is the same as ../mimi-server but structured

This is a fairly standard structure, with the schema and resolvers in to their own files.

## Other changes from ../mimi-server

Uses import and export instead of require

See https://github.com/apollographql/apollo-server/issues/3786 for workaround to address issue in apollo-server import

## Dockerfile

very simple docker file

To build: `docker build --tag mimi-structured`

To run: `docker run -p 4000:4000 --detach mimi-structured`