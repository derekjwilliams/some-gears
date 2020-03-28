import { getCollections } from './collections.js'
const resolverMap = {
  Query: {
    collections: async(_, args) => {
      return getCollections(args.kind)
    }
  },
}

export default resolverMap;