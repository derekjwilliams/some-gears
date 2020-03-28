const { ApolloServer, gql } = require('apollo-server');
const fetch = require('node-fetch');
const cheerio = require('cheerio');

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
`;

const getCollections = async(kind) => {
return fetch(`https://mimi.pnca.edu/f/${kind}`, {"credentials":"exclude","headers":{"accept":"text/html,application/xhtml+xml","accept-language":"en-US","cache-control":"no-cache","pragma":"no-cache"},"method":"GET"})
  .then((response) => {
    return response.text()
  }).then((html) => {
    const collections = []
    const $ = cheerio.load(html)
    $('a[data-no-turbolink="false"] h3').each(function (i, e) {
      const collectionsTitle = $(this).text();
      if (collectionsTitle !== 'Collections') {
        const item = {}

        //TODO a bit of a hack parsing the html, which is prone to failure, add some checks on elements
        const style = $(this).parent().attr('style')
        const backgroundImage = style.indexOf("''") === -1 ?  
          (style.split('background-image:url(\'')[1]).split('?')[0]: ''
        item['href'] = $(this).parent().parent().attr('href')
        item['backgroundImage'] = backgroundImage
        item['title'] = collectionsTitle.trim()
        collections.push(item);
      }
    });
    return collections
  })
}

const resolverMap = {
  Query: {
    collections: async(_, args) => {
      return getCollections(args.kind)
    }
  },
};

const server = new ApolloServer({ typeDefs, resolvers: resolverMap });

server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
});