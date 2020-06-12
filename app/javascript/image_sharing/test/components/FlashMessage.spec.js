import 'jsdom-global/register';
import React from 'react';
import { shallow, configure } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import { Alert } from 'reactstrap';
import Adapter from 'enzyme-adapter-react-16';
import FlashMessage from '../../components/FlashMessage';

configure({ adapter: new Adapter() });

describe('<FlashMessage />', () => {
  it('should not render alert if has no flash messages', () => {
    const dummyStore = {
      response: {
        status: null,
        message: null
      }
    };
    const wrapper = shallow(<FlashMessage store={dummyStore} />);
    const alert = wrapper.find(Alert);

    expect(alert).to.have.length(0);
  });

  it('should render alert if has a flash message', () => {
    const dummyStore = {
      response: {
        status: 'success',
        message: 'This was successful'
      }
    };
    const wrapper = shallow(<FlashMessage store={dummyStore} />);
    const alert = wrapper.find(Alert);

    expect(alert).to.have.length(1);
    expect(alert.children().text()).to.equal('This was successful');
  });
});
