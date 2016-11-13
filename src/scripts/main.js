import 'babel-polyfill';
import RiotControl from 'riotcontrol';

import Store from './store';

import '../tag/wiki-nav';
import '../tag/wiki-content';

const navlist = [
  {label: 'NEW', icon: 'fa-pencil', url: '#NEW'},
  {label: 'HOME', icon: 'fa-home', url: '#HOME'},
  {label: 'POSTS', icon: 'fa-newspaper-o', url: '#POSTS'},
  {label: 'CONFIG', icon: 'fa-cog', url: '#CONFIG'}
];

(async () => {
  const config = await fetch('firebase.json').then(res => res.json());

  const store = Store.getInstance(config);

  RiotControl.addStore(store);

  await store.init();

  riot.mount('wiki-nav', {navlist: navlist, store: store});
  riot.mount('wiki-content', {store: store});
})();
