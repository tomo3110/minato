import { fromJS } from 'immutable';
import './wiki-dir-item';

<wiki-dir>
  <a href='#HOME' class='dir-root'>README</a>
  <ul class='dir'>
    <li each={ label in keys } class='dir-item'>
      <wiki-dir-item label={ label } values={ parent.map.get(label) } query={ parent.query }></wiki-dir-item>
    </li>
  </ul>

  <script>

    riot.route('*..', () => {
      const q = riot.route.query();
      this.query = q.tree.split('/');
      this.update();
    });

    this.list = [
      'test/post/投稿テスト',
      'test/hello/world',
      'bug/ace editorの日本語入力',
      'blog/大学/卒論の環境について'
    ];

    const res = this.list.map(title => title.split('/'));

    dirCreate(ref = [],  href = [], obj = {}) {
      if (ref.length === 0) {
        return obj;
      } else {
        const url = ref.shift();
        href.push(url);
        if (typeof obj[url] === 'undefined') {
          obj[url] = {};
          obj[url]['_href'] = encodeURIComponent(href.join('/'));
          return this.dirCreate(ref, href, obj[url]);
        } else if (typeof obj[url] === 'object') {
          return this.dirCreate(ref, href, obj[url]);
        }
      }
    }

    let resolt = {};
    res.forEach(titleArr => {
      this.dirCreate(titleArr, [], resolt);
    });
    console.log(resolt);

    this.map = fromJS(resolt);
    this.keys = this.map.keySeq().toJS();
  </script>

  <style scoped>
    :scope {
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    :scope ul.dir {
      flex: 1;
      margin: 0;
      list-style: none;
    }
    :scope li.dir-item {
      margin: 0;
      border-bottom: solid thin #aaa;
    }
    :scope a.dir-root {
      margin: 0;
      text-decoration: none;
      cursor: pointer;
      padding-top: 0.5rem;
      padding-bottom: 0.5rem;
      padding-left: 1.5rem;
      padding-right: 1.5rem;
      color: #777;
      border-bottom: solid thin #aaa;
    }
    :scope a.dir-root:hover {
      color: #0094ff;
    }
    :scope li.dir-item > a {
      background-color: red;
    }
    </style>
</wiki-dir>
