import React from 'react';

export default class FeedbackForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { name: '', comment: '' };
    this.handleChangeName = this.handleChangeName.bind(this);
    this.handleChangeComment = this.handleChangeComment.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChangeName(event) {
    this.setState({ name: event.target.value });
  }

  handleChangeComment(event) {
    this.setState({ comment: event.target.value });
  }

  handleSubmit(event) {
    alert(`A name was submitted: ${this.state.name}`);
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
              <input id="name" type="text" value={this.state.name} onChange={this.handleChangeName} className="form-control" />
            </label>
          </div>
          <div style={{ padding: '10px' }}>
            <label htmlFor="comments">
              Comments:
              <br />
              <textarea
                id="comments"
                type="text"
                value={this.state.comment}
                onChange={this.handleChangeComment}
                className="form-control"
              />
            </label>
          </div>
          <div style={{ padding: '10px' }}><input type="submit" value="Submit" className="btn btn-primary" /></div>
        </form>
      </div>
    );
  }
}
