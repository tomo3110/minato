import assert from 'power-assert';
import WikiModel from '../../src/scripts/models/wiki';
import { List } from 'immutable';
describe('Wiki Model Test', () => {
  let wiki, wiki1, wiki2;
  const test = {url: '/hello/world', history: [{text: '# test', update: new Date()}], tags: ['hoge', 'fuga']}

  before(() => {
    wiki = new WikiModel(test);
  });
  it('instance check', () => {
    assert(wiki.url === '/hello/world');
  });
  xit('world', () => {
    assert();
  });
});
