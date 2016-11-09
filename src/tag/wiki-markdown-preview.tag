import marked from 'marked';
import hljs from 'highlight.js';

<wiki-markdown-preview>
  <section name='markedPreview'></section>

  <script>
    this.on('mount', () => {
      hljs.initHighlightingOnLoad();
      marked.setOptions({
        gfm: true,
        sanitize: true,
        highlight: (code => hljs.highlightAuto(code).value),
        sanitizer: (html, encode) => {
          if (/^<img/.test(html)) {
            return html;
          } else {
            return html
              .replace(!encode ? /&(?!#?\w+;)/g : /&/g, '&amp;')
              .replace(/</g, '&lt;')
              .replace(/>/g, '&gt;')
              .replace(/"/g, '&quot;')
              .replace(/'/g, '&#39;');
          }
        }
      });
    });

    this.on('updated', () => {
      this.markedPreview.innerHTML = marked(opts.value);
    });
  </script>

  <style scoped>
    :scope code {
      background-color: #fff;
    }
    :scope .default-view {
      color: #aaa;
      text-align: center;
    }
  </style>
</wiki-markdown-preview>
