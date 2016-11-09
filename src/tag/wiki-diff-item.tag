import RiotControl from 'riotcontrol';
import { diffLines } from 'diff';
import moment from 'moment';

import './wiki-user-photo';

<wiki-diff-item>
  <!--opts list

    opts.photo
    opts.name
    opts.update

    opts.newStr
    opts.oldStr

  -->
  <section class='diff-item'>
    <wiki-user-photo size='50px' url={ opts.photo }></wiki-user-photo>
    <section class='diff-ditail'>
      <p>{ opts.name } has been updated to { updateDate } .</p>
      <section class='diff-actions'>
        <a onclick={ toggle }>diff view</a>
        <a onclick={ rollback }>Revert to this version</a>
      </section>
      <pre class='diff-code-view'>
        <code name='diff'></code>
      </pre>
    </section>
  </section>

  <script>
    const diff = diffLines(opts.oldstr || '', opts.newstr);
    this.updateDate = moment(opts.update).format('YYYY-MM-DD');
    this.isView = false;

    this.on('update', () => {
      this.diff.innerHTML = '';
      diff.forEach(item => {
        if (item.added) {
          item.value.split('\n').forEach(line => {
            this.diff.innerHTML += `<span class='diff-view-add'>+ ${line}\n</span>`;
          });
        } else if (item.removed) {
          item.value.split('\n').forEach(line => {
            this.diff.innerHTML += `<span class='diff-view-rm' style='color: red;'>- ${line}\n</span>`;
          });
        } else {
          if (this.isView) {
            item.value.split('\n').forEach(line => {
              this.diff.innerHTML += `<span>  ${line}\n</span>`;
            });
          }
        }
      });
    });

    toggle(e) {
      this.isView = !this.isView;
      this.update();
    }
    rollback(e) {
      RiotControl.trigger('history_rollback', {index: opts.index, key: opts.key});
    }
  </script>

  <style scoped>
    :scope {
      display: block;
    }
    :scope section.diff-item {
      display: flex;
      align-items: flex-start;
    }
    :scope wiki-user-photo {
      margin: 1rem;
    }
    :scope section.diff-ditail {
      width: 100%;
      display: flex;
      margin-left: 1rem;
      justify-content: center;
      flex-direction: column;
    }
    :scope section.diff-ditail > p {
      margin: 0;
    }
    :scope section.diff-actions {
      display: flex;
    }
    :scope section.diff-actions > a {
      border: solid thin 1px #0094ff;
      border-radius: 4px;
      color: #0094ff;
      cursor : pointer;
      margin: 1rem;
      padding: 0.2rem 2rem 0.2rem 2rem;
      text-decoration: none;
    }
    :scope section.diff-actions > a:hover {
      background-color: #0094ff;
      color: #fff;
    }
    :scope pre.diff-code-view {
      margin: 0;
      margin-bottom: 3rem;
      width: 100%;
    }
    :scope pre.diff-code-view > code {
      width: 100%;
      background-color: #fff;
    }
    :scope span.diff-view-add {
      color: green;
    }
    :scope span.diff-view-rm {
      color: red;
    }
  </style>
</wiki-diff-item>
