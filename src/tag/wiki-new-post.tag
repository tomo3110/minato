import './wiki-edit-view';

<wiki-new-post>
  <wiki-edit-view edit={ edit } title={ title } key={ opts.key }></wiki-edit-view>

  <script>
    this.mixin('control');
    this.control.addStore(this);

    this.title = opts.title;
    this.edit = opts.edit;

    this.on('update_edit', data => {
      this.title = data.title;
      this.edit = data.edit;
    });
  </script>

  <style scoped>
    :scope {
      display: flex;
      flex-direction: column;
      padding-left: 3.5rem;
      padding-right: 2rem;
    }
    :scope wiki-edit-view {
      height: 100vh;
      margin-top: 1rem;
      overflow: scroll;
    }
  </style>
</wiki-new-post>