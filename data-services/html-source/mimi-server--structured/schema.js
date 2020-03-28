import apollo from 'apollo-server'
const { gql } = apollo
//import { gql } from 'apollo-server'

const typeDefs = gql`
  "Collection defines the queryable fields for every collection in mimi"
  type Collection {
    "The collection title"
    title: String
    href: String
    backgroundImage: String
  }

  type Query {
  "The collections query returns an array of zero or more Collections"
    collections("What kind of collection, e.g. thesis" kind: String!): [Collection]
  }
`

export default typeDefs;