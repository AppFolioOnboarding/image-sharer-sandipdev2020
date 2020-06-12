import React, { Component } from 'react';
import { Row, Col } from 'reactstrap';

export default class Footer extends Component {
  render() {
    return (
      <footer>
        <div>
          <Row>
            <Col lg={{ size: 4, offset: 4 }}>
              <h3 className='text-center' style={{ fontSize: '10px' }}>
                Copyright: AppFolio Inc. Onboarding
              </h3>
            </Col>
          </Row>
        </div>
      </footer>
    );
  }
}
