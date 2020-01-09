import { withApollo } from '../lib/apollo';
import { useRouter } from 'next/router';
import DefaultPageTemplate from '../containers/DefaultTemplate';

const Root = props => {
  const router = useRouter();
  return <DefaultPageTemplate slug={router.query.root} />;
};

export default withApollo(Root);
