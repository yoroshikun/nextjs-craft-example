import React from "react";
import Head from "next/head";
import { withApollo } from "../lib/apollo";
import gql from "graphql-tag";
import { useQuery } from "@apollo/react-hooks";

const Home = () => {
  const { loading, error, data } = useQuery(query, {
    variables: { slug: "home" }
  });

  if (error) return <div>Error loading page</div>;
  if (loading) return <div>Loading</div>;

  const {
    entries: [{ title, subtitle }]
  } = data;

  return (
    <div>
      <Head>
        <title>{title}</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <div className="hero">
        <h1 className="title">{title}</h1>
        <p className="description">{subtitle}</p>
      </div>

      <style jsx>{`
        .hero {
          width: 100%;
          color: #333;
        }
        .title {
          margin: 0;
          width: 100%;
          padding-top: 80px;
          line-height: 1.15;
          font-size: 48px;
        }
        .title,
        .description {
          text-align: center;
        }
        .row {
          max-width: 880px;
          margin: 80px auto 40px;
          display: flex;
          flex-direction: row;
          justify-content: space-around;
        }
      `}</style>
    </div>
  );
};

export const query = gql`
  query HomePage($slug: [String]) {
    entries(section: "Pages", slug: $slug) {
      ... on pages_pages_Entry {
        title
        subtitle
      }
    }
  }
`;

export default withApollo(Home);
