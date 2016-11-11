<wiki-dir-item>
  <a href='#HOME?tree={ href }' class='dir-item'>{opts.label}</a>
  <ul class='dir-children' if={ isView }>
    {isView}
    <li class='dir-child' each={ label in keys }>
      <wiki-dir-item label={ label } values={ parent.values.get(label) } query={ parent.query }>
      </wiki-dir-item>
    </li>
  </ul>

  <script>
    this.on('update', () => {
      this.keys = opts.values.keySeq().filter(key => !/^_/.test(key)).toJS();
      this.href = opts.values.get('_href');
      this.values = opts.values;
      riot.route('*..', () => {
        const q = riot.route.query();
        const reg = new RegExp(`^${q.tree}`, 'g');
        this.isView = reg.test(this.href);
      });
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
