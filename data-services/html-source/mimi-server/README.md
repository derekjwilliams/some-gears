# Example of an application using Apollo Server to read data from web site with a RESTful set of URLs

Uses simple web scrapping technique with Cherrio using the mimi.pnca.edu web site (for now)

This simple example gets the collections html content from `https://mimi.pnca.edu/f/${kind}`, where  kind is (currently) either "thesis", "historical", "lectures", or "exhibitions"

## Install and start with the following two commands

```
npm install

npm install -g nodemon

nodemon index.js
```

This will start a simple graphQL server on port 4000.  Open the following URL `http://localhost:4000/` which will show the Graphiql UI.

Enter a query, for example

```{
  collections(kind: "historical") {
    title
    href
    backgroundImage
  }
}
```

This will return the historical collections from mimi, e.g.

```{
  "data": {
    "collections": [
      {
        "title": "PNCA Publications",
        "href": "https://mimi.pnca.edu/f/historical/c/PNCA-publications",
        "backgroundImage": ""
      },
      {
        "title": "PNCA Print Portfolio Exchange",
        "href": "https://mimi.pnca.edu/f/historical/c/print_portfolios",
        "backgroundImage": "https://media.pnca.edu/system/assets/174d88e6-3198-4094-b439-ebc9c16f8391/medium/pnca_174d88e6-3198-4094-b439-ebc9c16f8391_medium.jpg"
      },
      {
        "title": "Museum of Contemporary Craft",
        "href": "https://mimi.pnca.edu/f/historical/c/MOCC",
        "backgroundImage": "https://media.pnca.edu/system/assets/22e33667-e488-4949-9957-df6d42349af7/medium/pnca_22e33667-e488-4949-9957-df6d42349af7_medium.jpg"
      },
      {
        "title": "PNCA in the 21st Century",
        "href": "https://mimi.pnca.edu/f/historical/c/21st-century",
        "backgroundImage": "https://media.pnca.edu/system/assets/4898f29b-2392-47bc-b532-10ac13ba0073/medium/pnca_4898f29b-2392-47bc-b532-10ac13ba0073_medium.jpg"
      },
      {
        "title": "PNCA History from the Archives",
        "href": "https://mimi.pnca.edu/f/historical/c/PNCAhistory",
        "backgroundImage": "https://media.pnca.edu/system/assets/c59b6bc3-37ac-46ec-b692-e7b6c21c27d2/medium/pnca_c59b6bc3-37ac-46ec-b692-e7b6c21c27d2_medium.jpg"
      },
      {
        "title": "PCVA Oral History Project",
        "href": "https://mimi.pnca.edu/f/historical/c/pcva",
        "backgroundImage": "https://media.pnca.edu/system/assets/91f4220d-8a5b-41c7-913c-a0a1ecd115ee/medium/pnca_91f4220d-8a5b-41c7-913c-a0a1ecd115ee_medium.jpg"
      }
    ]
  }
}
```


## Dockerfile

Very simple docker file

To build: `docker build --tag mimi-simple`

To run: `docker run -p 4000:4000 --detach mimi-simple`
