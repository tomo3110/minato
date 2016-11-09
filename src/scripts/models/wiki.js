// import riot from 'riot';
import {
  Record,
  List,
  Map
} from 'immutable';

import HistoryModel from './history';

const WikiRecord = Record({
  key: '',
  title: '',
  tags: List(),
  history: new HistoryModel(),
  isWip: false,
  create: new Date()
});

class WikiModel extends WikiRecord {
  constructor(data, key) {
    super({
      key: key || null,
      title: data.title || '',
      tags: List(JSON.parse(data.tags || "[]")),
      history: new HistoryModel().fromString(data.history),
      isWip: data.isWip,
      create: data.create || new Date().toString()
    });
    // riot.observable(this);
  }
  save(data) {
    if (data.auth) {
      const history = this.history.register({
        text: data.text,
        update: new Date(),
        auth: data.auth
      });
      return this.set('title', data.title).set('history', history);
    } else {
      return false;
    }
  }
  addTag(tagName = '') {
    if (tagName.length) {
      return this.set('tags', this.tags.push(tagName));
    } else {
      return this.set('tags', this.tags);
    }
  }
  removeTag(index) {
    if (typeof index === 'number') {
      return this.set('tags', this.tags.delete(index));
    } else {
      return this.set('tags', this.tags);
    }
  }
  toBackEnd(isWip = true) {
    return {
      title: this.get('title'),
      key: this.get('key'),
      history: this.history.toString(),
      tags: JSON.stringify(this.get('tags')),
      isWip: isWip,
      create: this.get('create')
    }
  }
}

export default WikiModel;
