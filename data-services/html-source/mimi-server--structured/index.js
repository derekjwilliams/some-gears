import apollo from 'apollo-server'
const { ApolloServer } = apollo
import resolverMap from './resolvers.js';
import typeDefs from './schema.js';

const server = new ApolloServer({ typeDefs, resolvers: resolverMap });

server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});