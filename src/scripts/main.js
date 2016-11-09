import 'babel-polyfill';
import riot from 'riot';
import RiotControl from 'riotcontrol';

import Store from './store';

import '../tag/wiki-nav';
import '../tag/wiki-content';

const
  navlist = [
    {label: 'NEW', icon: 'fa-pencil', url: '#NEW'},
    {label: 'HOME', icon: 'fa-home', url: '#HOME'},
    {label: 'POSTS', icon: 'fa-newspaper-o', url: '#POSTS'},
    {label: 'CONFIG', icon: 'fa-cog', url: '#CONFIG'}
  ],
  posts = [
    {
      photo_url: '',
      user_url: '',
      category: 'hello/world',
      title: 'Hello,World',
      url: 'POSTS/hello/world/Riot',
      last_update_user: 'hoge',
      last_update_user_url: ''
    }, {
      photo_url: '',
      user_url: '',
      category: 'public/howto',
      title: 'Riot',
      url: 'POSTS/public/howto/Riot',
      last_update_user: 'tomokazu',
      last_update_user_url: ''
    }
  ];

(async () => {

  const store = Store.getInstance({
    apiKey: "AIzaSyAsazPHiujSwixz7hGv5x_SDYEo68hJ64c",
    authDomain: "mysampleapp-5b5db.firebaseapp.com",
    databaseURL: "https://mysampleapp-5b5db.firebaseio.com",
    storageBucket: "mysampleapp-5b5db.appspot.com",
    messagingSenderId: "162101395061"
  });

  RiotControl.addStore(store);

  const res = await store.init();
  riot.mount('wiki-nav', {navlist: navlist, store: store});
  riot.mount('wiki-content', {store: store});
})();
