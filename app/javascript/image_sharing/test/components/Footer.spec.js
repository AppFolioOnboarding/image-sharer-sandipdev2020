import React from 'react';
import { expect } from 'chai';
import { mount } from 'enzyme';

import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should display footer', () => {
    const footerWrapper = mount(<Footer />);
    const footer = footerWrapper.find('footer');
    expect(footer.text()).to.equal('Copyright: AppFolio Inc. Onboarding');
  });
});
