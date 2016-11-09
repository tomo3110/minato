import {
  Map
} from 'immutable';

<wiki-dir>

  <script>
    let resolt = {};
    let test = opts.store.content.list.map(item => item.title);
    let test1 = test.map(url => url.split('/')).toJS();
    let arr1 = test1[0];
    console.log(arr1);

    testfunc(arr = [], obj = {}) {
      const item = arr.shift();
      let next = obj[item] = {};
      if (arr.length) {
        return this.testfunc(arr, next);
      } else {
        return obj;
      }
    }

    let test2 = this.testfunc(arr1, {});
    console.log(test2);
    let test3 = {};
    test3['test'] = {};
    test3['test']['post'] = {};
    test3['test']['post']['投稿テスト'] = {};
    console.log(test3);
  </script>

  <style scoped>
    :scope .wiki-dir-list {
      white-space: nowrap;
      height: 7vh;
      min-height: 5rem;
      display: flex;
      align-items: center;
      margin: 0;
      margin-left: 3rem;
    }
    :scope .wiki-dir-item {
      margin: 0;
      display: inline-block;
      font-size: 2.5rem;
    }
    :scope .wiki-dir-item > a {
      text-decoration: none;
      white-space: nowrap;
    }
    :scope .wiki-dir-item > a.content-link {
      color: #3b94fb;
    }
    :scope .wiki-dir-item > a.content-link:hover {
      color: #72b3fe;
    }
    :scope .wiki-dir-item > a.list-link {
      margin-left: 1rem;
      margin-right: 1rem;
      color: #aaa;
    }
  </style>
</wiki-dir>
