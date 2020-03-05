# simplepgql
Very Simple Postgraphile Apollo Server

This little application runs a simple graphql server running at localhost:5000/graphql.  Modify the database connection in server.js to connect to a postgres database.  Set the USERNAME, PASSWORD, and DB, or just set the environment variable DATABASE_URL as needed:

```connectionString: (process.env.DATABASE_URL || 'postgres://USERNAME:PASSWORD@localhost:5432/DB')```

If not provided the connection string is ```postgres://postgres:postgres@localhost/public```

## Running the server:

### `node server.js`

### Docker

Simplest possible Dockerfile is also provided.

### Command line for explaining queries

npx postgraphile -c postgres://postgres:postgres@127.0.0.1/blog --watch --enhce-graphiql --allow-explain
