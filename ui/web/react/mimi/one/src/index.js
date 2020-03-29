import React from "react";
import { render } from "react-dom";
import ApolloClient from "apollo-boost";
import { ApolloProvider, useQuery } from "@apollo/react-hooks";
import gql from "graphql-tag";

const client = new ApolloClient({
  uri: 'http://localhost:5000/graphql'
});

const pageTitleStyle = {
  fontFamily: 'Lucida Grande',
  fontSize: '22px'
}

const collectionGroupStyle = {
  display: 'grid',
  backgroundColor: '#ababab',
  gridGap: '0.75rem',
  gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))',
  padding: '0.75rem',
  boxSizing: 'border-box'
}

const collectionStyle = {
  fontFamily: 'Lucida Grande',
  fontSize: '14px',
  backgroundColor: '#f6f3ea',
  boxShadow: '1px 2px 8px rgba(0, 0, 0, 0.4)',
  padding: '0.2rem'
}

const imageContainerStyle = {
  marginTop: '1rem',
  display: 'inline-block',
  clear: 'both'
}

const imageStyle = {
  width: '100%',
  height: '100%',
  objectFit: 'cover'
}

const titleStyle = {
  fontStyle: 'italic',
  fontSize: '1.2rem',
  marginTop: '1.2rem'
}
const footerStyle = {
  fontStyle: 'italic',
  fontSize: '0.8rem',
  marginTop: '0.8rem'
}

function Collections() {
  const { loading, error, data } = useQuery(gql`
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
  `);

  if (loading) return <p>Loading...</p>;
  if (error) {
    console.log(JSON.stringify(error))
    return <p>Error :(</p>
  }
  return <div style={collectionGroupStyle}>{data.allCollections.nodes.map((
    { 
      id,
      title, 
      href,
      thumbnailImageUrl}) => (
        <div key={id} style={collectionStyle}>
          <div style = {titleStyle}>
            <a href={href}>{title}</a>
          </div>
          <div style = {imageContainerStyle}>
            <img style = {imageStyle} src={thumbnailImageUrl} alt={title + ' thumbnal image'}/>
          </div>
          <div style={footerStyle}>
            <p>id: {id}</p>
          </div>
        </div>
  ))}</div>
}

const App = () => (
  <ApolloProvider client={client}>
    <div>
    <h2 style={pageTitleStyle}>Collections</h2>
      <Collections />
    </div>
  </ApolloProvider>
);

render(<App />, document.getElementById('root'));

