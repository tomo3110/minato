import './wiki-user-photo';
import RiotControl from 'riotcontrol';

<wiki-comment-list>
  <ul class='comment-list'>
    <li each={ list } class='comment-item'>
      <wiki-user-photo src={ photo_src } size='50px'></wiki-user-photo>
      <section class='comment-item-ditail'>
        <p class='item-text'>{comment}</p>
        <div class='item-name'>{name}</div>
      </section>
    </li>
  </ul>

  <script>
    RiotControl.addStore(this);

    this.on('update', () => {
      this.list = opts.list.filter(item => item.key === opts.key);
    });

    this.on('comment-added', data => {
      opts.list.push(data);
      this.update();
    });
  </script>

  <style scoped>
    :scope {
      margin-top: 2rem;
    }
    :scope ul.comment-list {
      display: flex;
      flex-direction: column;
      margin: 0;
    }
    :scope li.comment-item {
      display: flex;
    }
    :scope .comment-item-ditail {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
    }
    :scope .comment-item-ditail > p.item-text {
      font-size: 2rem;
      margin: 0;
      word-break: break-all;
    }
    :scope .comment-item-ditail > div.item-name {
      margin: 0.5rem;
      color: #aaa;
      font-size: 1.5rem;
    }
    :scope wiki-user-photo {
      margin: 1.5rem;
    }
  </style>
</wiki-comment-list>
