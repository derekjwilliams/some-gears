# Very Simple React Application to Display Collections

See the README in databases/postgres/mimi/README.md to start the postgraphile server

e.g. 

```
 DATABASE_URL=postgres://postgres:postgres@127.0.0.1/artwork SCHEMA_NAMES=mimi node server.js
```

## Query the Collections

```
{
  allCollections {
    nodes {
      id
      title
      href
      thumbnailImageUrl
    }
  }
}
```

## Mutation and Variables to Add A Collection

### Mutation

```
mutation CreateCollection($newCollection: CreateCollectionInput!) {
  createCollection(input: $newCollection) {
    collection {
      title
    }
  }
}
```

 ### Variables
```
{
  "newCollection": {
    "collection": {
    	"title": "Test Collection"
  	}
  }
}
```

### Nested Mutations

Run the service found in 

```
data-services/postgraphile/express__nested-mutations
```

This express service has the postgraphile `postgraphile-plugin-nested-mutations` extension installed (see the extension's [github](https://github.com/mlipscombe/postgraphile-plugin-nested-mutations) and [npm](https://www.npmjs.com/package/postgraphile-plugin-nested-mutations) for documentation)

---
So to run:

Go to the directory where the service is located and run the service

```
cd data-services/postgraphile/express__nested-mutations
```
Install using yarn (if needed)
```
yarn
```

Run the postgraphile server
```
DATABASE_URL=postgres://postgres:postgres@127.0.0.1/artwork SCHEMA_NAMES=mimi node server.js
```
## Add an Album and A Parent Collection at the Same Time

```
mutation {
  createAlbum(
    input: {
      album: {
        title: "test album"
        collectionAlbumsUsingId: {
          create: {
            collectionToCollectionId: {
              create: { title: "parent test collection" }
            }
          }
        }
      }
    }
  ) {
    album {
      title
      collectionAlbumsByAlbumId {
        nodes {
          collectionByCollectionId {
            title
          }
        }
      }
    }
  }
}
```

### Or Starting at the Collection

```
mutation {
  createCollection(
    input: {
      collection: {
        title: "test2 collection"
        collectionAlbumsUsingId: {
          create: { albumToAlbumId: { create: { title: "test2 album" } } }
        }
      }
    }
  ) {
    collection {
      title
      albumsByCollectionAlbumCollectionIdAndAlbumId {
        nodes {
          title
        }
      }
    }
  }
}
```

### Adding An Album Into Two New Collections

```
mutation {
  createAlbum(
    input: {
      album: {
        title: "test album"
        collectionAlbumsUsingId: {
          create: [
            {
              collectionToCollectionId: {
                create: { title: "parent test7 collection" }
              }
            }
            {
              collectionToCollectionId: {
                create: { title: "parent test5 collection" }
              }
            }
          ]
        }
      }
    }
  ) {
    album {
      title
      collectionAlbumsByAlbumId {
        nodes {
          collectionByCollectionId {
            title
          }
        }
      }
    }
  }
}
```