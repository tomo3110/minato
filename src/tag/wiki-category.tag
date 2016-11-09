<wiki-category>
  <ul class='category-list'>
    <li class='category-item' each={ item in opts.category }>
      <a style='font-size: { this.parent.opts.fontsize || "2rem" }'>{ item }</a>
    </li>
  </ul>

  <style scoped>
    :scope ul.category-list {
      display: flex;
      list-style: none;
      margin: 0;
    }
    :scope li.category-item {
      margin: 0;
      margin-right: 3px;
      line-height: 1.2;
      display: inline-block;
    }
    :scope li.category-item::after {
      content: '/';
      margin-left: 3px;
      color: #aaa;
    }
    :scope li.category-item > a {
      color: #aaa;
      text-decoration: none;
      cursor: pointer;
      font-size: 2rem;
    }
    :scope li.category-item > a:hover {
      color: #0094ff;
    }
  </style>
</wiki-category>
