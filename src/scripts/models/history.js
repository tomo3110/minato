import { Record, List, fromJS } from 'immutable';

const HistoryRecord = Record({ list: List() });

class HistoryModel extends HistoryRecord {
  constructor(data = "[]") {
    super({ list: List(data)  });
  }
  register(data) {
    if (data) {
      return this.set('list', this.list.push(data));
    } else {
      return this.set('list', this.list);
    }
  }
  call(index = (this.list.size - 1)) {
    return this.list.get(index);
  }
  fromString(strData = '[]') {
    const data = JSON.parse(strData);
    if (typeof data !== 'string') {
      return this.set('list', List(data));
    } else {
      return this.set('list', this.list);
    }
  }
  toString() {
    return JSON.stringify(this.list.toJS());
  }
}

export default HistoryModel;
