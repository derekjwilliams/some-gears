const { ApolloServer, gql } = require('apollo-server');
import resolverMap from './resolvers';
import typeDefs from './schema';

const server = new ApolloServer({ typeDefs, resolvers: resolverMap });

server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});