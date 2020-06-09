import React, { Component } from 'react';
import PropTypes from 'prop-types';

export default class FeedbackForm extends Component {
  static propTypes = {
    store: PropTypes.object.isRequired
  };

  handleChangeName(event) {
    this.props.store.setName(event.target.value);
  }

  handleChangeComment(event) {
    this.props.store.setComments(event.target.value);
  }

  handleSubmit(event) {
    alert(`A name was submitted: ${this.props.store.name}`);
    event.preventDefault();
  }

  render() {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%', margin: '30px' }}>
        <form onSubmit={this.handleSubmit}>
          <div style={{ padding: '10px' }}>
            <label htmlFor="name">
              Your name:
              <br />
              <input
                id="name"
                type="text"
                value={this.props.store.name}
                onChange={this.handleChangeName}
                className="form-control"
              />
            </label>
          </div>
          <div style={{ padding: '10px' }}>
            <label htmlFor="comments">
              Comments:
              <br />
              <textarea
                id="comments"
                type="text"
                value={this.props.store.comments}
                onChange={this.handleChangeComment}
                className="form-control"
              />
            </label>
          </div>
          <div style={{ padding: '10px' }}>
            <input
              type="submit"
              value="Submit"
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    );
  }
}
