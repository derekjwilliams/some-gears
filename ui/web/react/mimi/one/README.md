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

Run the service in 

```
data-services/postgraphile/express__nested-mutations
```

e.g.

``````
 DATABASE_URL=postgres://postgres:postgres@127.0.0.1/artwork SCHEMA_NAMES=mimi node server.js
```

which has the nested mutations extension installed (https://github.com/mlipscombe/postgraphile-plugin-nested-mutations, https://www.npmjs.com/package/postgraphile-plugin-nested-mutations)