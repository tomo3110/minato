<wiki-monaco-editor>
  <section id='MonacoEditor' style='width: { opts.width }; height: { opts.height };'></section>

  <script>
  this.on('updated', () => {
    this.VS_LOAD_SRC = opts.vssrc || 'assets/scripts/vs';
    if (!window.require) {
      const loaderScript = document.createElement('script');
      loaderScript.type = 'text/javascript';
      loaderScript.src = `${this.VS_LOAD_SRC}/loader.js`;
      loaderScript.addEventListener('load', this.onAmdLoader);
      document.body.appendChild(loaderScript);
    } else {
      this.onAmdLoader();
    }
  });

  onAmdLoader() {
    window.require.config({ paths: { 'vs': this.VS_LOAD_SRC }});
    window.require(['vs/editor/editor.main'], () => {
      this.initMonaco();
    });
  }

  initMonaco() {
    if (window.monaco) {
      this.editor = window.monaco.editor.create(this.MonacoEditor, {
        value: opts.value,
        language: opts.mode || 'javascript',
        theme: opts.theme || 'vs',
        fontSize: opts['font-size'] || 15,
        fontFamily: opts['font-family'],
        acceptSuggestionOnEnter: opts['is-accept-suggestion-on-enter'] || true,
        ariaLabel: opts['aria-label'],
        autoClosingBrackets: opts['auto-closing-brackets'] || true,
        automaticLayout: opts['is-automatic-layout'] || false,
        codeLens: opts['is-code-lens'] || true,
        contextmenu: opts['is-contextmenu'] || true,
        hover: opts['is-hover'] || false,
        parameterHints: opts['is-hints'] || false,
        readOnly: opts['is-read-only'] || false,
        renderIndentGuides: opts['is-indent-guides'] || true,
        renderLineHighlight: opts['is-line-highlight'] || true,
        renderWhitespace: opts['is-whitespace'] || 'none',
        scrollbar: opts.scrollbar || {},
        selectionHighlight: opts['is-selection-highlight'] || false,
        useTabStops: opts['is-tab-stops'] || false,
        wordBasedSuggestions: opts['is-word-based-suggestions'] || true,
        wordSeparators: opts['word-separators'],
        wordWrap: opts['is-word-wrap'] || false
      });
    }
  }
  </script>

  <style scoped>
    :scope section#MonacaEditor {
      display: flex;
    }
  </style>
</wiki-monaco-editor>
