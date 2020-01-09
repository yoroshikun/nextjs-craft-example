import React from 'react';
import gql from 'graphql-tag';
import Head from 'next/head';
import { useQuery } from '@apollo/react-hooks';

import Layout from './Layout';

const DefaultPageTemplate = ({ slug }: { slug: string | string[] }) => {
  const { loading, error, data } = useQuery(query, {
    variables: { slug },
  });

  if (error) return <div>Error loading page</div>;
  if (loading) return <div>Loading</div>;

  const {
    entries: [{ title, subtitle }],
  }: { entries: { title: string; subtitle: string }[] } = data;

  return (
    <Layout title={title}>
      <Head>
        <title>{title}</title>
        <link rel='icon' href='/favicon.ico' />
      </Head>
      <div className='hero'>
        <h1 className='title'>{title}</h1>
        <p className='description'>{subtitle}</p>
      </div>
    </Layout>
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

export default DefaultPageTemplate;
