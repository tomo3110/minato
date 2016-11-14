import RiotControl from 'riotcontrol';
import '../scripts/mixin/scrollSync';

<wiki-post-textarea>
  <textarea id='postTextarea'
    style='width: { opts.width }; height: { opts.height };'
    oninput={ inputed }
    onscroll={ scrolled }>
  </textarea>

  <script>
    this.mixin('scrollSync');
    this.on('mount', () => {
      this.postTextarea.value = opts.value;
    });

    inputed(e) {
      const value = this.postTextarea.value;
      opts.onChange(value);
    }

    scrolled(e) {
      const rate = this.getScrollRate(this.postTextarea);
      RiotControl.trigger('scroll_sync', rate);
    }

  </script>

  <style scoped>
    :scope {
      display: flex;
    }
    :scope #postTextarea {
      flex: 1;
      padding: 1rem;
      border: solid thin #ccc;
      line-height: 2.5rem;
      resize: none;
    }
  </style>
</wiki-post-textarea>