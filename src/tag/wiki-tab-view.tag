import RiotControl from 'riotcontrol';

import './wiki-dir';
import './wiki-button-group';
import './wiki-edit-view';
import './wiki-markdown-preview';
import './wiki-post-header';
import './wiki-history-view';
import './wiki-comment-field';
import './wiki-comment-list';

<wiki-tab-view>
  <header>
    <wiki-button-group>
      <button type='button' onclick={ this.parent.tabSelect(0) } class={ (this.parent.tabIndex == 0) && 'active' }>preview</button>
      <button type='button' onclick={ this.parent.tabSelect(1) } class={ (this.parent.tabIndex == 1) && 'active' }>edit</button>
      <button type='button' onclick={ this.parent.tabSelect(2) } class={ (this.parent.tabIndex == 2) && 'active' }>history</button>
    </wiki-button-group>
  </header>
  <section show={ tabIndex == 0 } class='tab-preview'>
    <article>
      <wiki-post-header dir={ title }></wiki-post-header>
      <wiki-markdown-preview value={ edit }></wiki-markdown-preview>
    </article>
    <section class='sub-colum'>
      <p><i class='fa fa-comments' aria-hidden='true'></i>comments</p>
      <wiki-comment-field key={ opts.key }></wiki-comment-field>
      <wiki-comment-list list={ comments } key={ opts.key }></wiki-comment-list>
    </section>
  </section>
  <wiki-edit-view show={ tabIndex == 1 } edit={ edit } title={ title } key={ opts.key }></wiki-edit-view>
  <wiki-history-view show={ tabIndex == 2 } history={ history } key={ opts.key }></wiki-history-view>

  <script>
    this.mixin('control');
    this.control.addStore(this);

    this.tabIndex = opts.tabIndex || 0;
    this.comments = opts.comments;
    this.title = opts.title;
    this.edit = opts.edit;
    this.history = opts.history;

    this.on('update_edit', data => {
      this.title = data.title;
      this.edit = data.edit;
    });

    tabSelect(index = 0) {
      return () => {
        this.tabIndex = index;
        this.update();
      }
    }

  </script>

  <style scoped>
    :scope {
      display: flex;
      flex-direction: column;
      padding-left: 3.5rem;
      padding-right: 2rem;
    }
    :scope header {
      height: 50px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    :scope .tab-preview {
      display: flex;
      justify-content: flex-start;
      height: 92vh;
    }
    :scope .tab-preview > article {
      flex: 1;
      height: 92vh;
      overflow: scroll;
    }
    :scope .tab-preview > .sub-colum {
      margin: 0;
      margin-left: 1.5rem;
      width: 25vw;
    }
    :scope .sub-colum {
      display: flex;
      flex-direction: column;
    }
    :scope .sub-colum > p {
      margin: 0;
      margin-left: 3rem;
      color: #aaa;
      font-size: 2rem;
    }
    :scope .sub-colum > p > i {
      margin-right: 1rem;
      color: #aaa;
    }
    :scope wiki-comment-list {
      flex: 1;
      overflow: scroll;
    }
    :scope wiki-edit-view {
      height: 92vh;
      overflow: scroll;
    }
    :scope wiki-history-view {
      height: 92vh;
      overflow: scroll;
    }
  </style>
</wiki-tab-view>
