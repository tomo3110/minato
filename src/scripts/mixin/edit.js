import WikiModel from '../models/wiki';

export default function EditAction(store) {

  let title = '';
  let edit = '';

  const init = function() {

    this.on('edit_data', data => {
      console.log(data);
      title = data.title;
      edit = data.edit;
      this.update();
    });

    this.on('edit_save_wip', data => {
      const targetWiki = store.content.searchByKey(data.key);
      try {
        if (!store.user) throw Error('Login is required to update.');
        if (targetWiki) {
          if (targetWiki.history.call().text === data.edit && targetWiki.title === data.title) {
            throw Error('Save processing was canceled because it has not been updated.');
          }
          console.log('更新');
          const resolt = targetWiki.save({
            title: data.title,
            text: data.edit,
            auth: {
              photo_url: store.user.photoURL,
              name: store.user.displayName,
              email: store.user.email,
              uid: store.user.uid
            }
          });
          store.save(store.wikiRef, resolt.toBackEnd(), resolt.get('key')).catch(e => console.error(e));
        } else {
          if (this.user) throw Error('Login is required to update.');
          console.log('新規');
          const postWiki = new WikiModel(data);
          const resolt = postWiki.save({
            title: data.title,
            text: data.edit,
            auth: {
              photo_url: store.user.photoURL,
              name: store.user.displayName,
              email: store.user.email,
              uid: store.user.uid
            }
          });
          store.save(store.wikiRef, resolt.toBackEnd());
        }
      } catch (e) {
        store.error.saved = e;
        console.error(e);
      }
    });

    this.on('edit_save_shipIt', data => {
      const targetWiki = store.content.searchByKey(data.key);
      try {
        if (!store.user) throw Error('Login is required to update.');
        if (targetWiki) {
          if (targetWiki.history.call().text != data.edit) {
            console.log('更新');
            const resolt = targetWiki.save({
              title: data.title,
              text: data.edit,
              auth: {
                photo_url: store.user.photoURL,
                name: store.user.displayName,
                email: store.user.email,
                uid: store.user.uid
              }
            });
            store.save(store.wikiRef, resolt.toBackEnd(false), resolt.get('key')).catch(e => console.error(e));
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
              photo_url: store.user.photoURL,
              name: store.user.displayName,
              email: store.user.email,
              uid: store.user.uid
            }
          });
          store.save(store.wikiRef, resolt.toBackEnd(false));
        }
      } catch (e) {
        store.error.saved = e;
        console.error(e);
      }
    });
  }

  return {
    title,
    edit,
    init
  }
}
