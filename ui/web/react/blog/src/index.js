import React from "react";
import { render } from "react-dom";
import ApolloClient from "apollo-boost";
import { ApolloProvider, useQuery } from "@apollo/react-hooks";
import gql from "graphql-tag";

const client = new ApolloClient({
  uri: "http://localhost:5000/graphql"
});

const pageTitleStyle = {
  fontFamily: 'Lucida Grande',
  fontSize: '22px'
}

const postStyle = {
  display: "grid",
  fontFamily: 'Lucida Grande',
  fontSize: '14px',
  backgroundColor: '#f6f3ea',
  boxShadow: '1px 2px 8px rgba(0, 0, 0, 0.4)',
  padding: '8px',
  margin: '8px',
}

const imageStyle = postStyle

const postBodyStyle = {
  margin: '10px',
  padding: '10px',
  color: '#eeeeee',
  backgroundColor: '#333333',
}
const commentsListStyle = {
  display: "grid",
  gridTemplateColumns: "repeat(auto-fit, minmax(380px, 1fr))"
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
const imageContainer = {
  display: 'inline-block',
  float: 'left',
  clear: 'both'
}
const containedImage = {
  width: '50%'
}

function Images() {
  const { loading, error, data } = useQuery(gql`
    {
      allImages {
        nodes {
          id
          url
        }
      }
    }
  `);

  if (loading) return <p>Loading...</p>;
  if (error) {
    console.log(JSON.stringify(error))
    return <p>Error :(</p>;
  }

  return data.allImages.nodes.map((
    { 
      id, 
      url
      }) => (
        <div key={id} style={imageStyle}>
            <p>
              {id}
            </p>
            <div style = {imageContainer}>
              <img style={containedImage} src={url} alt={id}></img>
            </div>
        </div>
  ));
}

function Authors() {
  const { loading, error, data } = useQuery(gql`
    {
      allAuthors {
        nodes {
          id
          name
        }
      }
    }
  `);

  if (loading) return <p>Loading...</p>;
  if (error) {
    console.log(JSON.stringify(error))
    return <p>Error :(</p>;
  }

  return data.allAuthors.nodes.map((
    { 
      id, 
      name
      }) => (
        <div key={id} style={imageStyle}>
            <p>
              {name}
            </p>
        </div>
  ));
}

function Comments() {
  const { loading, error, data } = useQuery(gql`
    {
      allComments {
        nodes {
          id
          submissionTime
          text
        }
      }
    }
  `);

  if (loading) return <p>Loading...</p>;
  if (error) {
    console.log(JSON.stringify(error))
    return <p>Error :(</p>;
  }

  return data.allComments.nodes.map((
    { 
      id,
      submissionTime,
      text
      }) => (
        <div key={id} style={imageStyle}>
            <p>
              {text}
            </p>
            <span>{new Date(submissionTime.split('.')[0]).toLocaleString()}</span>
        </div>
  ));
}



function Posts() {
  const { loading, error, data } = useQuery(gql`
    {
      allPosts {
        nodes {
          id
          submissionDate
          title
          markdown
        }
      }
    }
  `);

  if (loading) return <p>Loading...</p>;
  if (error) {
    console.log(JSON.stringify(error))
    return <p>Error :(</p>
  }
  return data.allPosts.nodes.map((
    { 
      id, 
      submissionDate,
      title,
      markdown}) => (
        <div key={id} style={postStyle}>
          <div style = {titleStyle}>
            {title} 
          </div>
          <div>
            published:
              <span>{new Date(submissionDate.split('.')[0]).toLocaleString()}</span>
          </div>
          <div style={footerStyle}>
            <p>
              {id}
            </p>
            <p>
              {markdown}
            </p>
          </div>
        </div>
  ));
}

const App = () => (
  <ApolloProvider client={client}>
    <div>
    <h2 style={pageTitleStyle}>Comments</h2>
      <Comments />
      <h2 style={pageTitleStyle}>Blog Posts</h2>
      <Posts />
      <h2 style={pageTitleStyle}>Images</h2>
      <Images />
      <h2 style={pageTitleStyle}>Authors</h2>
      <Authors />
      <h2 style={pageTitleStyle}>Authors</h2>
      <Authors />
    </div>
  </ApolloProvider>
);

render(<App />, document.getElementById("root"));

