import './wiki-spinner';
import './wiki-tab-view';
import './wiki-posts-view';
import './wiki-edit-view';
import './wiki-home-view';
import './wiki-new-post';

<wiki-content>
  <wiki-spinner></wiki-spinner>

  <style scoped>
    :scope {
      flex: 1;
      background-color: #fefefe;
    }
  </style>

  <script>
    this.mixin('template');

    riot.route('*', local => {
      switch (local) {
        case 'NEW': {
          const templateList = this.getTemplateList(opts.store.content.list.toJS());
          console.log(templateList);
          opts.store.edit = '';
          opts.store.title = '';
          riot.mount('wiki-content', 'wiki-new-post', {
            edit: opts.store.edit,
            title: opts.store.title,
            templateList,
            key: ''
          });
          break;
        }
        case 'HOME': {
          const postList = opts.store.content.list.map((post, i) => {
            const
              dirArr = post.title.split('/'),
              title = dirArr.pop(),
              category = dirArr;
            return {
              title,
              category,
              isWip: post.isWip,
              url: `POSTS/${post.key}`,
              photo_url: post.history.call(0).auth.photo_url,
              last_update_user: post.history.call().auth.name,
              update_user_url: '',
              user_url: ''
            }
          });
          riot.mount('wiki-content', 'wiki-home-view', {store: opts.store, list: postList.sort().toJS()});
          break;
        }
        case 'POSTS': {
          const postList = opts.store.content.list.map(post => {
            const
              dirArr = post.title.split('/'),
              title = dirArr.pop(),
              category = dirArr;
            return {
              title,
              category,
              isWip: post.isWip,
              url: `POSTS/${post.key}`,
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
    riot.route('POSTS/*', key => {
      const targetWiki = opts.store.content.searchByKey(key);
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
    riot.route('NEW..', () => {
      const q = riot.route.query();
      const templateList = this.getTemplateList(opts.store.content.list.toJS());
      if (q.template_post_key) {
        const targetWiki = opts.store.content.searchByKey(q.template_post_key);
        opts.store.edit = this.parseTempate(targetWiki.history.call().text);
        opts.store.title = this.parseTempate(targetWiki.get('title').replace( /^template\//, ''));
      } else {
        opts.store.edit = '';
        opts.store.title = '';
      }
      riot.mount('wiki-content', 'wiki-new-post', {
        edit: opts.store.edit,
        title: opts.store.title,
        templateList,
        key: ''
      });
    riot.route('HOME..', () => {
      const q = riot.route.query();
      const targetWikiList = opts.store.content.searchByURL(decodeURIComponent(q.tree)).map((post, i) => {
        const
          dirArr = post.title.split('/'),
          title = dirArr.pop(),
          category = dirArr;
        return {
          title,
          category,
          isWip: post.isWip,
          url: `POSTS/${post.key}`,
          photo_url: post.history.call(0).auth.photo_url,
          last_update_user: post.history.call().auth.name,
          update_user_url: '',
          user_url: ''
        }
      });
      const tree = q.tree.split('%2F');
      riot.mount('wiki-content', 'wiki-home-view', {store: opts.store, list: targetWikiList.sort().toJS(), tree: tree});
    });

    riot.route.start();
    riot.route.exec();
  </script>
</wiki-content>
