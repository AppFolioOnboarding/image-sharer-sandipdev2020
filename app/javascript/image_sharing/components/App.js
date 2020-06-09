import React, { Component } from 'react';
import Footer from './Footer';
import FeedbackForm from './FeedbackForm';
import Header from './Header';

class App extends Component {
  /* Add Prop Types check*/
  render() {
    return (
      <div>
        <Header title="Tell us what you think" />
        <FeedbackForm />
        <Footer />
      </div>
    );
  }
}

export default App;
