import './wiki-new-edit-view';

<wiki-new-post>
  <wiki-new-edit-view edit='{ edit }' title='{ title }' key='{ opts.key }' options='{ options }'></wiki-new-edit-view>

  <script>
    this.mixin('control');
    this.control.addStore(this);

    this.title = opts.title;
    this.edit = opts.edit;
    this.options = opts.templateList || [];

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
      padding-top: 1rem;
    }
    :scope wiki-edit-view {
      height: 100vh;
    }
  </style>
</wiki-new-post>