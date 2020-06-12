/* eslint-env mocha */

import { expect } from 'chai';
import FeedbackStore from '../../stores/FeedbackStore';

describe('FeedbackStore', () => {
  it('defaults to an empty name', () => {
    const feedbackStore = new FeedbackStore();
    expect(feedbackStore.name).to.equal('');
  });

  it('defaults to empty comments', () => {
    const feedbackStore = new FeedbackStore();
    expect(feedbackStore.comments).to.equal('');
  });

  describe('setComments', () => {
    it('should update comments', () => {
      const feedbackStore = new FeedbackStore();
      feedbackStore.setComments('foo');
      expect(feedbackStore.comments).to.equal('foo');
    });
  });

  describe('setName', () => {
    it('should update name', () => {
      const feedbackStore = new FeedbackStore();
      feedbackStore.setName('foo');
      expect(feedbackStore.name).to.equal('foo');
    });
  });
});
