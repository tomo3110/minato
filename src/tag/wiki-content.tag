import './wiki-spinner';
import './wiki-tab-view';
import './wiki-posts-view';
import './wiki-edit-view';
import './wiki-home-view';

<wiki-content>
  <wiki-spinner></wiki-spinner>

  <style scoped>
    :scope {
      flex: 1;
      background-color: #fefefe;
    }
  </style>

  <script>
    riot.route('*', (local, id) => {
      switch (local) {
        case 'NEW': {
          opts.store.edit = '';
          opts.store.title = '';
          riot.mount('wiki-content', 'wiki-tab-view', {
            edit: opts.store.edit,
            title: opts.store.title,
            comments: opts.store.comments.get('list').toJS(),
            key: '',
            tabIndex: 1
          });
          break;
        }
        case 'HOME': {
          riot.mount('wiki-content', 'wiki-home-view', {store: opts.store});
          break;
        }
        case 'POSTS': {
          const postList = opts.store.content.list.map((post, i) => {
            const
              dirArr = post.title.split('/'),
              title = dirArr.pop(),
              category = dirArr;
            return {
              title,
              category,
              isWip: post.isWip,
              url: `POSTS/${i}`,
              photo_url: post.history.call(0).auth.photo_url,
              last_update_user: post.history.call().auth.name,
              update_user_url: '',
              user_url: ''
            }
          });
          riot.mount('wiki-content', 'wiki-posts-view', {store: opts.store, posts: postList.sort().toJS()});
          break;
        }
        // case 'CONFIG': {}
        default: {
          riot.mount('wiki-content', 'wiki-tab-view', {
            edit: opts.store.edit,
            title: opts.store.title,
            comments: opts.store.comments.get('list').toJS(),
            key: '',
            store: opts.store
          });
          break;
        }
      }
    });
    riot.route('*/*', (local, id) => {
      const targetWiki = opts.store.content.searchByID(id);
      if (targetWiki) {
        opts.store.edit = targetWiki.history.call().text;
        opts.store.title = targetWiki.get('title');
        riot.mount('wiki-content', 'wiki-tab-view', {
          edit: opts.store.edit,
          title: opts.store.title,
          comments: opts.store.comments.get('list').toJS(),
          history: targetWiki.history,
          key: (targetWiki.get('key') || '')
        });
      }
    });

    riot.route.start();
    riot.route.exec();
  </script>
</wiki-content>
