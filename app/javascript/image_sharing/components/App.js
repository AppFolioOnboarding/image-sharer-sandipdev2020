import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Footer from './Footer';
import FeedbackForm from './FeedbackForm';
import Header from './Header';

class App extends Component {
  static propTypes = {
    store: PropTypes.object.isRequired
  };
  render() {
    return (
      <div>
        <Header title="Tell us what you think" />
        <FeedbackForm store={this.props.store} />
        <Footer />
      </div>
    );
  }
}

export default App;
