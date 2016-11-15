<wiki-dir-item>
  <a href='#HOME?tree={href}' class='dir-item'>{opts.label}</a>
  <ul class='dir-children' if={ isView }>
    <li class='dir-child' each={ label in keys }>
      <wiki-dir-item
        label={ label }
        values={ parent.values.get(label) }
        tree={ parent.tree }
        index={ parent.index }>
      </wiki-dir-item>
    </li>
  </ul>

  <script>
    this.on('update', () => {
      this.index = opts.index + 1;
      this.tree = opts.tree || [];
      this.values = opts.values;
      this.keys = opts.values.keySeq().filter(key => !/^_/.test(key)).toJS();
      this.href = opts.values.get('_href');
      this.isView = (this.tree[opts.index] === opts.label);
    });
  </script>

  <style scoped>
    :scope {
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    :scope a {
      margin: 0;
      text-decoration: none;
      cursor: pointer;
      font-size: 1.5rem;
      padding-top: 1rem;
      padding-bottom: 1rem;
      padding-left: 2rem;
      padding-right: 2rem;
    }
    :scope a::before {
      content: '└';
      margin-right: 1rem;
    }
    :scope a:visited {
      color: #777;
    }
    :scope a:hover {
      color: #0094ff;
    }
    :scope ul.dir-children {
      margin: 0;
      padding-left: 30px;
      list-style: none;
    }
    :scope li.dir-child {
      margin: 0;
    }
  </style>
</wiki-dir-item>
