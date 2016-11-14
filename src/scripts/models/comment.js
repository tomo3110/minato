import {
  Record,
  List
} from 'immutable';

const CommentRecord = Record({
  key: '',
  comment: '',
  photo_src: '',
  name: ''
});

export class CommentModel extends CommentRecord {
  constructor(data) {
    super({
      key: data.key,
      comment: data.comment,
      photo_src: data.photo_src,
      name: data.name
    });
  }
}

const CommentListRecord = Record({
  list: List()
});

export class CommentListModel extends CommentListRecord {
  constructor() {
    super({
      list: List()
    });
  }
  addComment(comment) {
    if (comment) {
      return this.set('list', this.list.push(comment));
    } else {
      return this.set('list', this.list);
    }
  }
  getByURL(url) {
    return this.list.filter(item => item.url == url);
  }
  getByKey(key = '') {
    if (key.length) {
      return this.set('list', this.list.filter(item => item.key === key)).get('list');
    } else {
      return this.get('list');
    }
  }
}
