import './wiki-posts-list';
import './wiki-dir';

<wiki-home-view>
  <wiki-search></wiki-search>
  <section class='home-content'>
    <wiki-dir store={ opts.store }></wiki-dir>
    <wiki-posts-list posts={ opts.list }></wiki-posts-list>
  </section>

  <script>
    console.log(opts.list);
  </script>

  <style scoped>
    :scope {
      display: flex;
      flex-direction: column;
    }
    :scope wiki-search {
      height: 10vh;
      border-bottom: solid thin #aaa;
    }
    :scope section.home-content {
      display: flex;
      flex:1;
    }
    :scope wiki-posts-list {
      flex: 3;
      margin: 1.5rem;
      overflow: scroll;
    }
    :scope wiki-dir {
      flex: 1;
      border-right: solid thin #aaa;
    }
  </style>
</wiki-home-view>
