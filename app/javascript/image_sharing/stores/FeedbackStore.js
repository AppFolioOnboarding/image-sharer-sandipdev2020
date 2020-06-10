import { action, observable } from 'mobx';

export class FeedbackStore {
  @observable name = '';
  @observable comments = '';

  @action setComments(comments) {
    this.comments = comments;
  }

  @action setName(name) {
    this.name = name;
  }
}
