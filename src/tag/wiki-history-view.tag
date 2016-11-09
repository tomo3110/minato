import './wiki-diff-item';

<wiki-history-view>
  <wiki-diff-item each={ item, i in history.list.toJS() }
    index={ i }
    key={ this.parent.opts.key }
    name={ item.auth.name || item.auth.email }
    photo={ item.auth.photo_url }
    update={ item.update }
    newStr={ item.text }
    oldStr={ i ? this.parent.history.call(i - 1).text : '' } >
  </wiki-diff-item>
  <section class='not-data' show={ typeof history == 'undefined' }>
    <h3>not history</h3>
  </section>

  <script>
    this.on('update', () => {
      this.history = opts.history;
    });
  </script>


  <style scoped>
    :scope {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      height: 92vh;
    }
    :scope section.not-data {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    :scope section.not-data > h3 {
      color: #aaa;
    }
  </style>
</wiki-history-view>
