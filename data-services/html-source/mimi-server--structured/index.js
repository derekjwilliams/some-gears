const { ApolloServer, gql } = require('apollo-server');
const fetch = require('node-fetch');
const cheerio = require('cheerio');
const { resolverMap } = require('./resolvers');
// const schema = require('schema');
