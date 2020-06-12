/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import App from '../../components/App';

describe('<App />', () => {
  it('should render correctly', () => {
    const stores = {
      feedbackStore: {
        name: 'test',
        comments: 'test',
        response: {
          status: 'test',
          message: 'test'
        }
      }
    };
    const wrapper = mount(<App stores={stores} />);
    assert(wrapper.contains('Tell us what you think'));
  });
});
