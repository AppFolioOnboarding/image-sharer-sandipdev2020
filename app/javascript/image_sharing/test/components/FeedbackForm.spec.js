/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const store = {
      name: 'test',
      comments: 'test'
    };
    const wrapper = mount(<FeedbackForm store={store} />);
    const form = wrapper.find('form');
    const inputs = form.find('input');
    const inputName = inputs.find('.form-control');
    const submitButton = inputs.find('.btn');
    const inputComment = wrapper.find('textarea');

    assert.equal(inputName.length, 1);
    assert.equal(submitButton.length, 1);
    assert.equal(inputComment.length, 1);
  });
});
