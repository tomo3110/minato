import './wiki-posts-list';
import './wiki-dir';

<wiki-home-view>
  <wiki-search></wiki-search>
  <section class='home-content'>
    <wiki-dir dir={ dir } tree={ tree }></wiki-dir>
    <wiki-posts-list posts={ opts.list }></wiki-posts-list>
  </section>

  <script>
    this.tree = opts.tree || [];
    this.dir = opts.store.content.list.map(item => item.title);
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
      overflow: scroll;
      border-right: solid thin #aaa;
    }
  </style>
</wiki-home-view>
