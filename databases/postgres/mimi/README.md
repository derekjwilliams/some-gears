# Set of sql to create mimi example database and insert values

## Note on Postgrapile

If running postgraphile (from the data-services directory, e.g. data-services/postgraphile/express) then set DATABASE_URL and SCHEMA in the command line, for example:

```
 DATABASE_URL=postgres://postgres:postgres@127.0.0.1/artwork SCHEMA_NAMES=mimi node server.js
```

