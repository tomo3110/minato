import 'babel-polyfill';
import RiotControl from 'riotcontrol';

import Store from './store';

import controlMixin from './mixin/control';
import scrollSyncMixin from './mixin/scrollSync';
import templateMixin from './mixin/template';

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

  riot.mixin('control', controlMixin);
  riot.mixin('scrollSync', scrollSyncMixin);
  riot.mixin('template', templateMixin);

  await store.init();

  riot.mount('wiki-nav', {navlist: navlist, store: store});
  riot.mount('wiki-content', {store: store});
})();
