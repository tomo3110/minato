
import 'babel-polyfill';
import WikiListModel from './models/wikiList';
import WikiModel from './models/wiki';
import {
  CommentListModel,
  CommentModel
} from './models/comment';

import riot from 'riot';
import RiotControl from 'riotcontrol';

import firebase from 'firebase';

class Store {
  constructor(config) {
    riot.observable(this);

    this.config =  config || {};
    this.user = null;
    this.content = new WikiListModel();
    this.comments = new CommentListModel();
    this.edit = '';
    this.title = '';
    this.commentsList = [];
    this.error = {};

    const app = firebase.initializeApp(config);

    this.database = app.database();
    this.storage = app.storage();
    this.auth = app.auth();

    this.on('update_edit', data => {
      this.edit = data.edit;
      this.title = data.title;
    });

    this.on('save_wip', data => {
      const targetWiki = this.content.searchByKey(data.key);
      try {
        if (!this.user) throw Error('Login is required to update.');
        if (targetWiki) {
          if (targetWiki.history.call().text === data.edit && targetWiki.title === data.title) {
            throw Error('Save processing was canceled because it has not been updated.');
          }
          console.log('更新');
          const resolt = targetWiki.save({
            title: data.title,
            text: data.edit,
            auth: {
              photo_url: this.user.photoURL,
              name: this.user.displayName,
              email: this.user.email,
              uid: this.user.uid
            }
          });
          this.save(this.wikiRef, resolt.toBackEnd(), resolt.get('key')).catch(e => console.error(e));
        } else {
          if (this.user) throw Error('Login is required to update.');
          console.log('新規');
          const postWiki = new WikiModel(data);
          const resolt = postWiki.save({
            title: data.title,
            text: data.edit,
            auth: {
              photo_url: this.user.photoURL,
              name: this.user.displayName,
              email: this.user.email,
              uid: this.user.uid
            }
          });
          this.save(this.wikiRef, resolt.toBackEnd());
        }
      } catch (e) {
        this.error.saved = e;
        console.error(e);
      }
    });

    this.on('save_shipIt', data => {
      const targetWiki = this.content.searchByKey(data.key);
      if (targetWiki) {
        if (targetWiki.history.call().text != data.edit) {
          console.log('更新');
          const resolt = targetWiki.save({
            title: data.title,
            text: data.edit,
            auth: {
              photo_url: this.user.photoURL,
              name: this.user.displayName,
              email: this.user.email,
              uid: this.user.uid
            }
          });
          this.save(this.wikiRef, resolt.toBackEnd(false), resolt.get('key')).catch(e => console.error(e));
        } else {
          console.log(targetWiki.history.call().text);
          console.log(data.edit);
        }
      } else {
        console.log('新規');
        const postWiki = new WikiModel(data);
        const resolt = postWiki.save({
          title: data.title,
          text: data.edit,
          auth: {
            photo_url: this.user.photoURL,
            name: this.user.displayName,
            email: this.user.email,
            uid: this.user.uid
          }
        });
        this.save(this.wikiRef, resolt.toBackEnd(false));
      }
    });

    this.on('comment-post', data => {
      this.postComment(data.comment, data.key);
    });

    this.on('history_rollback', data => {
      const targetWiki = this.content.searchByKey(data.key);
      RiotControl.trigger('history_update', {
        title: this.title,
        edit: targetWiki.history.call(data.index).text
      });
    });
  }

  init() {
    return new Promise((resolve, reject) => {
      this.auth.onAuthStateChanged(user => {
        this.user = user;
      });

      this.wikiRef = this.database.ref('wiki');
      this.wikiRef.off();

      this.wikiRef.on('child_added', data => {
        console.log('store add one');
        const val = data.val();
        const wiki = new WikiModel(val, data.key);
        this.content = this.content.add(wiki);
        resolve(this);
      });

      this.wikiRef.on('child_changed', data => {
        console.log('store changed one');
        const val = data.val();
        if (this.content.searchByKey(data.key)) {
          const targetWikiList = this.content.removeByKey(data.key);
          this.content = targetWikiList.add(new WikiModel(val, data.key));
        }
      });

      this.commentsRef = this.database.ref('comments');
      this.commentsRef.on('child_added', data => {
        console.log('add comments');
        const val = data.val();
        const comment = new CommentModel(val);
        this.comments = this.comments.addComment(comment);
        RiotControl.trigger('comment-added', val);
      });
    });
  }

  save(ref, data = {}, uid) {
    return ref.transaction(oldState => {
      let newState = oldState || {};
      if (uid) {
        newState[uid] = data;
      } else {
        data.key = ref.push().key;
        newState[data.key] = data;
      }
      return newState;
    });
  }

  async postComment(comment, key) {
    if (comment.length && this.user) {
      return await this.commentsRef.push({
        key: key,
        comment: comment,
        name: this.user.displayName,
        photo_src: this.user.photoURL
      });
    }
  }

  async signIn() {
    try {
      const
        provider = new firebase.auth.GoogleAuthProvider(),
        resolt = await this.auth.signInWithPopup(provider)
          .catch(err => {
            throw err;
          });
      return resolt;
    } catch (e) {
      throw e;
    }
  }

  signOut() {
    return this.auth.signOut();
  }

  updateProfile(data) {
    if (user) {
      return user.updateProfile(data);
    }
  }
}

Store._instance = null;

Store.getInstance = (config) => {
  if (!Store._instance) {
    Store._instance = new Store(config);
  }
  return Store._instance;
};

export default Store;
