<wiki-monaco-editor>
  <section id='MonacoEditor' style='width: { opts.width }; height: { opts.height };'></section>

  <script>
    this.on('updated', () => {
      if (!window.require) {
        const loaderScript = document.createElement('script');
        loaderScript.type = 'text/javascript';
        loaderScript.src =  'assets/scripts/vs/loader.js';
        loaderScript.addEventListener('load', this.onAmdLoader);
        document.body.appendChild(loaderScript);
      } else {
        this.onAmdLoader();
      }
    });

    onAmdLoader() {
      window.require.config({ paths: { 'vs': 'assets/scripts/vs' }});
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
          fontSize: opts.fontSize || 15,
          fontFamily: opts.fontFamily,
          acceptSuggestionOnEnter: opts.isAcceptSuggestionOnEnter,
          ariaLabel: opts.ariaLabe,
          autoClosingBrackets: opts.isAutoClosingBrackets,
          automaticLayout: opts.isAutomaticLayout || false,
          codeLens: opts.isCodeLens,
          contextmenu: opts.isContextmenu,
          formatOnType: opts.isFormatOnType || false,
          glyphMargin: opts.isGlyphMargin || false,
          hideCursorInOverviewRuler: opts.isHideCursorInOverviewRuler || false,
          hover: opts.isHover || false,
          iconsInSuggestions: opts.isIconsInSuggestions,
          lineDecorationsWidth: opts.lineDecorationsWidth || 10,
          lineHeight: opts.lineHeight,
          lineNumbers: opts.lineNumbers,
          lineNumbersMinChars: opts.lineNumbersMinChars || 5,
          mouseWheelScrollSensitivity: opts.mouseWheelScrollSensitivity || 1,
          mouseWheelZoom: opts.isMouseWheelZoom || false,
          overviewRulerLanes: opts.overviewRulerLanes || 2,
          parameterHints: opts.isHints || false,
          quickSuggestions: opts.isQuickSuggestions,
          quickSuggestionsDelay: opts.quickSuggestionsDelay || 500,
          readOnly: opts.isReadOnly || false,
          renderControlCharacters: opts.isControlCharacters || false,
          renderIndentGuides: opts.isIndentGuides,
          renderLineHighlight: opts.isLineHighlight,
          renderWhitespace: opts.isWhitespace || 'none',
          revealHorizontalRightPadding: opts.revealHorizontalRightPadding || 30,
          roundedSelection: opts.roundedSelection,
          rulers: opts.rulers || [],
          scrollBeyondLastLine: opts.isScrollBeyondLastLine,
          scrollbar: opts.scrollbar || {},
          selectOnLineNumbers: opts.isSelectOnLineNumbers,
          selectionClipboard: opts.selectionClipboard,
          selectionHighlight: opts.isSelectionHighlight || false,
          snippetSuggestions: opts.snippetSuggestions ||  'true',
          suggestOnTriggerCharacters: opts.isSuggestOnTriggerCharacters,
          tabCompletion: opts.isTabCompletion || false,
          useTabStops: opts.isTabStops || false,
          wordBasedSuggestions: opts.isWordBasedSuggestions || true,
          wordSeparators: opts.wordSeparators,
          wordWrap: opts.isWordWrap || false,
          wrappingColumn: opts.wrappingColumn || 300,
          wrappingIndent: opts.wrappingIndent || 'none'
        });
      }
    }
  </script>

  <style scoped>
    :scope {
      display: flex;
    }
    :scope section#MonacoEditor {
      border: solid thin #ccc;
      border-radius: 2px;
      padding: 0.5rem;
    }
  </style>
</wiki-monaco-editor>
