import riot from 'riot';
import firebase from 'firebase';
import WikiListModel from './models/wikiList';
import WikiModel from './models/wiki';

class Router {
  constructor(url = 'wiki', config = {}) {

    const app = firebase.initializeApp(config);

    this.database = app.database();
    this.storage = app.storage();
    this.auth = app.auth();
    this.wiki = new WikiListModel();

    this.initRoute = url;

    riot.route(this.routing.bind(this));
    riot.route.start();
    riot.route.exec();
  }
  init() {
    return new Promise((resolve, reject) => {
      this.wikiRef = this.database.ref('wiki');
      this.wikiRef.off();
      this.commentsRef = this.database.ref('comments');
      this.commentsRef.off();

      this.wikiRef.on('child_added', data => {
        const res = new WikiModel(data.val());
        this.wiki = this.wiki.add(res);
        resolve(res);
      });

      this.wikiRef.on('child_changed', data => {
        const res = new WikiModel(data.val());
        this.wiki.add(res);
      });
    });
  }
  routing(...urlList) {
    if (urlList[0] !== this.initRoute) {
      this.go(urlList.join('/'));
    }
    const newData = this.wiki.searchByURL(urlList.join('/'));
    console.log(newData);
  }
  go(url) {
    const list = url.split('/');
    if (list[0] === this.initRoute) {
      riot.route(url);
    } else {
      list.unshift(this.initRoute);
      riot.route(list.join('/'));
    }
  }
}

export default Router;
