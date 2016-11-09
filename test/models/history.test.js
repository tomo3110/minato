import assert from 'power-assert';
import Immutable from 'immutable';
import HistoryModel from '../../src/scripts/models/history';

describe('History Model Tset', () => {
  let history, history1, history2;
  const test = '[{"text":"# test"},{"text":"## Add History Test","create":"2017-03-31T15:00:00.000Z"}]';
  before(() => {
    history = new HistoryModel().register({text: '# test'});
  });

  it('instance check', () => {
    assert(history.list.size === 1);
  });

  it('It is registered in the history.', () => {
    history1 = history.register({
      text: '## Add History Test',
      create: new Date('2017/04/01')
    });
    assert(history1.list.size === 2);
  });

  it('Call from the history.', () => {
    const resolt = history1.call(0);
    assert(resolt.text === "# test");
  });

  it('To convert this object to a string.', () => {
    assert(history1.toString() === test);
  });

  it('fromString', () => {
    const newHistory = history1.fromString(test);
    assert(newHistory.list.size === 2);
  });
});
