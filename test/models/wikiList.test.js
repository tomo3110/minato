import assert from 'power-assert';
import Immutable from 'immutable';
import WikiListModel from '../../src/scripts/models/wikiList';
import WikiModel from '../../src/scripts/models/wiki';

describe('WikiList Model Tset', () => {
  let wikiList, wikiList1, wikiList2, wikiList3, wikiList4, wikiList5;
  before(() => {
    wikiList = new WikiListModel([
      new WikiModel({url: '/test'}),
      new WikiModel({url: '/hello'})
    ]);
  });

  it('instance check', () => {
    assert(wikiList.list.size === 2);
  });
  it('search by URL', () => {
    assert(wikiList.searchByURL('/test').url === '/test');
  });
  it('added new wiki', () => {
    wikiList1 = wikiList.add(new WikiModel({url: '/test/add'}));
    assert(wikiList1.list.size === 3);
    assert(wikiList1.searchByURL('/test/add').url === '/test/add');
    wikiList2 = wikiList1.add(new WikiModel({url: '/test'}));
    assert(wikiList2.list.size === 3);
  });
  it('remove by id wiki', () => {
    wikiList3 = wikiList.removeById(0);
    assert(wikiList.list.size === 2);
    assert(wikiList3.list.size === 1);
  });
  it('remove by URL wiki', () => {
    wikiList4 = wikiList1.removeByURL('/hello');
    assert(wikiList4.list.size === 2);
    wikiList5 = wikiList4.removeByURL('/test/add');
    assert(wikiList5.list.size === 1);
  });
});
