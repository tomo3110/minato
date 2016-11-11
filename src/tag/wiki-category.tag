<wiki-category>
  <ul class='category-list'>
    <li class='category-item' each={ item in category }>
      <a href='#HOME?tree={ item.href }' style='font-size: { parent.opts.fontsize || "2rem" }'>{ item.label }</a>
    </li>
  </ul>

  <script>
    this.on('update', () => {
      this.category = this.categoryListCreate(opts.category);
    });

    categoryListCreate(list = [], resolt = [], hrefArr = []) {
      if (list.length) {
        const item = list.shift();
        hrefArr.push(item);
        resolt.push({
          label: item,
          href: encodeURIComponent(hrefArr.join('/'))
        });
        return this.categoryListCreate(list, resolt, hrefArr);
      } else {
        return resolt;
      }
    }
  </script>

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
