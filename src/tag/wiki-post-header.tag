import './wiki-category';

<wiki-post-header>
  <wiki-category category={ category }></wiki-category>
  <h1>{ title }</h1>

  <style scoped>
    :scope h1 {
      border-bottom: solid thin #aaa;
      padding-top: 1rem;
      padding-bottom: 1rem;
    }
  </style>

  <script>
    this.on('update', () => {
      this.dirArr = this.opts.dir.split('/');
      this.title = this.dirArr.pop();
      this.category = this.dirArr;
    });
  </script>
</wiki-post-header>
