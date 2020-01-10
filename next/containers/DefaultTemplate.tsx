import React from 'react';
import gql from 'graphql-tag';
import Head from 'next/head';
import { useQuery } from '@apollo/react-hooks';

import Layout from './Layout';

interface testMatrixItem {
  testField1: string;
  testField2: string;
}
interface Entry {
  title: string;
  subtitle: string;
  testMatrix: testMatrixItem[];
}

interface DefaultPageTemplateQuery {
  entries: Entry[];
}

const DefaultPageTemplate = ({ slug }: { slug: string | string[] }) => {
  const { loading, error, data } = useQuery<DefaultPageTemplateQuery>(query, {
    variables: { slug },
  });

  if (error) return <div>Error loading page</div>;
  if (loading) return <div>Loading</div>;

  const { entries } = data;

  if (entries.length === 0) return <div>No Entries</div>;

  const [{ title, subtitle, testMatrix }] = entries; // This kind of deconstruction only works when there is 1 item in an array be careful with it

  return (
    <Layout title={title}>
      <Head>
        <title>{title}</title>
        <link rel='icon' href='/favicon.ico' />
      </Head>
      <div className='hero'>
        <h1 className='title'>{title}</h1>
        <p className='description'>{subtitle}</p>
        {testMatrix.map((testMatrixItem: testMatrixItem, index) => (
          <p key={`testMatrixItem.testField1-${index}`} className='description'>
            {testMatrixItem.testField1} | {testMatrixItem.testField2}
          </p>
        ))}
      </div>
    </Layout>
  );
};

export const query = gql`
  query DefualtTemplate($slug: [String]) {
    entries(section: "Pages", slug: $slug) {
      ... on pages_pages_Entry {
        title
        subtitle
        testMatrix {
          ... on testMatrix_test1_BlockType {
            testField1
            testField2
          }
          ... on testMatrix_test2_BlockType {
            testField1
            testField2
          }
        }
      }
    }
  }
`;

export default DefaultPageTemplate;
