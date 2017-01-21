import { BartenderFrontendPage } from './app.po';

describe('bartender-frontend App', function() {
  let page: BartenderFrontendPage;

  beforeEach(() => {
    page = new BartenderFrontendPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
