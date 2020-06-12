import { post } from '../utils/helper';

export default class PostFeedbackService {
  constructor(store) {
    this.store = store;
  }

  postFeedback = () => post('/api/feedbacks', { name: this.store.name, comment: this.store.comments })
    .then((data) => {
      this.setFlashMessage('success', data.message);
      this.resetForm();
    })
    .catch(() => {
      this.setFlashMessage('danger', 'try again');
    });

  setFlashMessage(status, message) {
    this.store.setResponse(status, message);
  }

  resetForm() {
    this.store.resetForm();
  }
}
