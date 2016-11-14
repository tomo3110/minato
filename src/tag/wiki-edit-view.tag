import RiotControl from 'riotcontrol';

import './wiki-post-textarea';
import './wiki-markdown-preview';
import './wiki-post-header';

<wiki-edit-view>
  <section class='wiki-edit'>
    <input type='text'
      name='title_input'
      value={ title }
      oninput={ inputTitle }
      placeholder='category.. / Title' />
    <wiki-post-textarea
      value={ edit }
      width='100%'
      height='75vh'
      on-change={ edited }>
    </wiki-post-textarea>
    <section class='save-buttons'>
      <button type='button' class='wip' onclick={ saveWip }>save as wip</button>
      <button type='button' class='ship' onclick={ saveShipIt }>ship it!</button>
    </section>
  </section>
  <section name='preview' class='wiki-preview'>
    <wiki-post-header dir={ title }></wiki-post-header>
    <wiki-markdown-preview name='previewElement' value={ edit }></wiki-markdown-preview>
  </section>

  <script>
    RiotControl.addStore(this);
    this.mixin('scrollSync');

    this.title = opts.title;
    this.edit = opts.edit;

    this.on('history_update', data => {
      this.tags['wiki-monaco-editor'].editor.setValue(data.edit);
    });

    this.on('scroll_sync', rate => {
      this.getScrollRate(this.preview);
      const resolt = this.maxScrollTop * rate;
      this.preview.scrollTop = resolt;
    });

    edited(value) {
      this.edit = value;
      RiotControl.trigger('update_edit', {
        title: this.title_input.value,
        edit: this.edit,
        key: opts.key
      });
      this.tags.previewElement.update({value: this.edit});
    }

    inputTitle(e) {
      this.title = this.title_input.value;
      RiotControl.trigger('update_edit', {
        title: this.title,
        edit: this.edit,
        key: opts.key
      });
    }

    saveWip() {
      RiotControl.trigger('save_wip', {
        title: this.title,
        edit: this.edit,
        key: opts.key
      });
    }
    saveShipIt() {
      RiotControl.trigger('save_shipIt', {
        title: this.title,
        edit: this.edit,
        key: opts.key
      });
    }
  </script>

  <style scoped>
    :scope {
      display: flex;
    }
    :scope .wiki-preview {
      flex: 1;
      height: 90vh;
      overflow: scroll;
      padding: 0.5rem;
      margin: 0;
      margin-left: 1.5rem;
    }
    :scope .wiki-edit {
      flex: 1;
      height: 90vh;
      padding: 0.5rem;
      margin: 0;
      margin-right: 1.5rem;
    }
    :scope .wiki-edit > input {
      width: 100%;
    }
    :scope .save-buttons {
      display: flex;
      justify-content: flex-end;
      margin-top: 1rem;
    }
    :scope .save-buttons > button {
      margin-left: 1rem;
    }
    :scope button.wip {
      border: solid thin #0094ff;
      color: #0094ff;
    }
    :scope button.ship {
      border: solid thin #0094ff;
      color: #fff;
      background-color: #0094ff
    }
  </style>
</wiki-edit-view>
