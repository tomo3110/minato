import riot from 'riot';
import {
  Record,
  List
} from 'immutable';

const WikiListRecord = Record({
  list: List()
});

class WikiListModel extends WikiListRecord {
  constructor(data) {
    super({ list: List(data) });
    riot.observable(this);
  }
  searchByURL(url) {
    if (this.list.count(item => item.title === url)) {
      return this.list.find(item => item.title == url);
    } else {
      return false;
    }
  }
  searchByID(index) {
    return this.list.get(index);
  }
  searchByKey(key) {
    if (this.list.count(item => item.key === key)) {
      return this.list.find(item => item.key === key);
    } else {
      return false;
    }
  }
  add(wiki) {
    if (!this.list.count(item => item.title === wiki.title)) {
      return this.set('list', this.list.push(wiki));
    } else {
      return this.set('list', this.list);
    }
  }
  removeById(index) {
    if (typeof index === 'number') {
      return this.set('list', this.list.delete(index));
    } else {
      return this.set('list', this.list);
    }
  }
  removeByURL(url) {
    if (this.list.count(item => item.title === url) === 1) {
      return this.set('list', this.list.filter(item => item.title !== url));
    } else {
      return this.set('list', this.list);
    }
  }
  removeByKey(key) {
    if (this.list.count(item => item.key === key) === 1) {
      return this.set('list', this.list.filter(item => item.key !== key));
    } else {
      return this.set('list', this.list);
    }
  }
}

export default WikiListModel;
