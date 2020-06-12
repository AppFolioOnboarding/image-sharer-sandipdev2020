import React, {Component} from 'react';
import PropTypes from 'prop-types';
import {Row, Col} from 'reactstrap';

export default class Header extends Component {
  static propTypes = {
    title: PropTypes.string.isRequired
  };

  render() {
    const title = this.props.title;
    return (
      <header>
        <div>
          <Row>
            <Col lg={{ size: 4, offset: 4 }}>
              <h3 className='text-center'>
                {title}
              </h3>
            </Col>
          </Row>
        </div>
      </header>
    );
  }
}
