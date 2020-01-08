import React from "react";
import Head from "next/head";

const Index = () => {
  return (
    <div>
      <Head>
        <title>Index</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <div className="hero">
        <h1 className="title">Welcome to Next.js CraftQL Example!</h1>
        <p className="description">To get started, read the readme.</p>

        <div className="row">
          <a href="https://nextjs.org/docs" className="card">
            <h3>Step 1 &rarr;</h3>
            <p>Setup Craft:</p>
          </a>
        </div>
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
        .card {
          padding: 18px 18px 24px;
          width: 220px;
          text-align: left;
          text-decoration: none;
          color: #434343;
          border: 1px solid #9b9b9b;
        }
        .card:hover {
          border-color: #067df7;
        }
        .card h3 {
          margin: 0;
          color: #067df7;
          font-size: 18px;
        }
        .card p {
          margin: 0;
          padding: 12px 0 0;
          font-size: 13px;
          color: #333;
        }
      `}</style>
    </div>
  );
};

export default Index;
