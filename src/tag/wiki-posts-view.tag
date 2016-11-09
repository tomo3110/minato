import './wiki-posts-list';

<wiki-posts-view>
  <header>
    <wiki-button-group>
      <button type='button' onclick={ this.parent.tabSelect(0) } class={ (this.parent.tabIndex == 0) && 'active' }>all</button>
      <button type='button' onclick={ this.parent.tabSelect(1) } class={ (this.parent.tabIndex == 1) && 'active' }>stock</button>
      <button type='button' onclick={ this.parent.tabSelect(2) } class={ (this.parent.tabIndex == 2) && 'active' }>wip</button>
    </wiki-button-group>
  </header>
  <wiki-posts-list show={ tabIndex == 0 } posts={ opts.posts }></wiki-posts-list>
  <wiki-posts-list show={ tabIndex == 1 } posts={ [] }></wiki-posts-list>
  <wiki-posts-list show={ tabIndex == 2 } posts={ wipList }></wiki-posts-list>

  <script>
    this.tabIndex = 0;
    this.wipList = opts.posts.filter(post => post.isWip);

    tabSelect(index = 0) {
      return () => {
        this.tabIndex = index;
        this.update();
      }
    }
  </script>

  <style scoped>
    :scope {
      display: flex;
      flex-direction: column;
      padding-left: 3.5rem;
      padding-right: 2rem;
    }
    :scope header {
      height: 50px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    :scope wiki-posts-list {
      height: 90vh;
      overflow: scroll;
    }
  </style>
</wiki-posts-view>
