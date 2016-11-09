import ace from 'brace';

<wiki-ace-editor>
  <section name='editor' style='width: { opts.width }; height: { opts.height };'></section>

  <script>
    const {
      annotations,
      cursorstart,
      fontsize,
      mode,
      showgutter,
      showprintmargin,
      tabsize,
      theme,
      value,
      wrapenabled,
      changed,
      focused,
      blured,
      copyed,
      pasted,
      scrolled
    } = opts;

    change() {
      if (changed) {
        const newValue = this.braceEditor.getValue();
        changed(newValue);
      }
    }
    focus() {
      if (focused) {
        focused();
      }
    }
    blur() {
      if (blured) {
        blured();
      }
    }
    copy() {
      if (copyed) {
        copyed();
      }
    }
    paste() {
      if (typeof pasted === 'function') {
        pasted();
      }
    }
    scroll(e) {
      if (typeof scrolled === 'function') {
        scrolled(e);
      }
    }

    init(editor) {
      editor.$blockScrolling = Infinity;
      editor.getSession().setMode(`ace/mode/${mode || ''}`);
      editor.setTheme(`ace/theme/${theme || ''}`);
      editor.setFontSize(fontsize || 14);
      editor.setValue((value || ''), (cursorstart || 1));
      editor.renderer.setShowGutter(showgutter);
      editor.getSession().setUseWrapMode(wrapenabled || false);
      editor.getSession().setTabSize(tabsize || 4);
      editor.setShowPrintMargin(showprintmargin || true);
      editor.on('focus', this.focus);
      editor.on('blur', this.blur);
      editor.on('copy', this.copy);
      editor.on('paste', this.paste);
      editor.on('change', this.change);
      editor.session.on('changescrolltop', this.scroll);
      editor.getSession().setAnnotations(annotations || []);
      return editor;
    }

    this.on('mount', () => {
      this.braceEditor = this.init(ace.edit(this.editor));
    });
    this.on('unmount', () => {
      this.braceEditor.off('change');
      this.braceEditor.destroy();
    });
  </script>

  <style scoped>
    :scope section {
      border: solid thin #ccc;
      border-radius: 4px;
    }
  </style>
</wiki-ace-editor>
