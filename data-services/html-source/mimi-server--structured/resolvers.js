import { getCollections } from './collections'
const resolverMap = {
  Query: {
    collections: async(_, args) => {
      return getCollections(args.kind)
    }
  },
}

export default resolverMap;