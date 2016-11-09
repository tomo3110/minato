import './wiki-category';
import './wiki-user-photo';

<wiki-posts-list>
  <ul class='post-list'>
    <li class='posts-item' each={ opts.posts }>
      <wiki-user-photo size='70px' url={ photo_url } href={ user_url }></wiki-user-photo>
      <section class='posts-ditail'>
        <wiki-category category={ category } fontsize='1.5rem'></wiki-category>
        <a href='#{ url }' class='posts-title'>{ title }</a>
        <wiki-comments-list url={ url } store={ this.parent.opts.store }></wiki-comments-list>
        <p class='last-update-user'>updated by <a class='last-update-user-link' href='#{ update_user_url }'>{ last_update_user }</a> .</p>
      </section>
    </li>
    <section show={ opts.posts.length == 0 } class='none-data'>
      <h3>Now try to post !</h3>
    </section>
  </ul>

  <style scoped>
    :scope {
      display: flex;
    }
    :scope ul.post-list {
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    :scope li.posts-item {
      display: flex;
      border-bottom: solid thin #aaa;
      margin: 0;
      padding-top: 2rem;
      padding-bottom: 1.5rem;
    }
    :scope wiki-user-photo {
      margin-right: 2rem;
    }
    :scope .posts-title {
      font-size: 3rem;
      text-decoration: none;
      margin: 0;
    }
    :scope p.last-update-user {
      margin: 0;
    }
    :scope a.last-update-user-link {
      text-decoration: none;
      cursor: pointer;
    }
    :scope .none-data {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    :scope .none-data > h3 {
      color: #aaa;
    }
  </style>
</wiki-posts-list>
