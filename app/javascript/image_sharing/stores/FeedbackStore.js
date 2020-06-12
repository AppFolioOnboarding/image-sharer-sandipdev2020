import { action, observable } from 'mobx';

export default class FeedbackStore {
  @observable name;
  @observable comments;
  @observable response;

  constructor() {
    this.name = '';
    this.comments = '';
    this.response = {
      status: null,
      message: null
    };
  }

  @action setComments(comments) {
    this.comments = comments;
  }

  @action setName(name) {
    this.name = name;
  }

  @action setResponse(status, message) {
    this.response.status = status;
    this.response.message = message;
  }

  @action resetForm() {
    this.name = '';
    this.comments = '';
  }
}

