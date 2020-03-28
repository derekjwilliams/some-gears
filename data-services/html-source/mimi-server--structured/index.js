const { ApolloServer, gql } = require('apollo-server');
const fetch = require('node-fetch');
const cheerio = require('cheerio');

import { makeExecutableSchema } from 'graphql-tools';

export const schema = makeExecutableSchema({
  typeDefs,
  resolverMap,
});