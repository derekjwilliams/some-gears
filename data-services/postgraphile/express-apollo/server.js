const pg = require('pg');
const { ApolloServer } = require('apollo-server');
const { makeSchemaAndPlugin } = require('postgraphile-apollo-server');
const ConnectionFilterPlugin = require('postgraphile-plugin-connection-filter');
const PgManyToManyPlugin = require('@graphile-contrib/pg-many-to-many');


const dbSchema = process.env.SCHEMA_NAMES
  ? process.env.SCHEMA_NAMES.split(',')
  : ['lilac'];

const pgPool = new pg.Pool({
  connectionString: (process.env.DATABASE_URL || 'postgres://postgres:postgres@127.0.0.1/blog'),
});

const postGraphileOptions = {
  appendPlugins: [ConnectionFilterPlugin, PgManyToManyPlugin],
  graphileBuildOptions: {
    connectionFilterRelations: true,
  },
  exportGqlSchemaPath: 'schema.graphql',
  subscriptions: true,
  graphiql: true,
  dynamicJson: true,
  watchPg: true,
  enhanceGraphiql: true,
  allowExplain(req) {
    return true;
  },
};

async function main() {
  const { schema, plugin } = await makeSchemaAndPlugin(
    pgPool,
    dbSchema,
    postGraphileOptions
  );

  const server = new ApolloServer({
    schema,
    plugins: [plugin],
  });

  const { url } = await server.listen(5000);
  console.log(`🚀 Server ready at ${url}`);
}

main().catch(e => {
  console.error(e);
  process.exit(1);
});
