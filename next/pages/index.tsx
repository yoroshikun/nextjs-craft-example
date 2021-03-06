import { withApollo } from '../lib/apollo';
import DefaultPageTemplate from '../containers/DefaultTemplate';

const Root = props => {
  return <DefaultPageTemplate slug='home' />;
};

export default withApollo(Root);
