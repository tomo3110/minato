import './wiki-user';

<wiki-nav>
  <ul class='nav-list'>
    <li each={ opts.navlist }>
      <a href={ url } class='nav-item { (this.parent.local == label) && "active" }'>
        <h3><i class='fa { icon }' aria-hidden='true'></i></h3>
        <span>{label}</span>
      </a>
    </li>
  </ul>
  <wiki-user user={ opts.store.user } store={ opts.store }></wiki-user>

  <script>
    this.on('mount', () => {
      riot.route('*', local => {
        this.local = local;
        this.update();
      });
    });
  </script>

  <style scoped>
    :scope {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-between;
      min-width: 5rem;
      width: 80px;
      height: 100vh;
    }
    :scope .nav-list > li {
      display: flex;
      list-style: none;
      text-align: center;
    }
    :scope .nav-list > li > a.nav-item {
      width: 100%;
      display: flex;
      flex-direction: column;
      margin: 1rem;
      margin-top: 3rem;
      text-decoration: none;
      color: #aad3f6;
    }
    :scope .nav-list > li > a.nav-item > h3 {
      display: flex;
      justify-content: center;
      flex: 1;
      color: #aad3f6;
      width: 100%;
      margin: 0;
    }
    :scope .nav-list > li > a.nav-item > span {
      margin: 0;
    }
    :scope a.nav-item {
      position: relative;
    }
    :scope .nav-item.active > span {
      color: #fff;
    }
    :scope .nav-item.active > h3 > i {
      color: #fff;
    }
    :scope .nav-item.active::after {
      position: absolute;
      content: "";
      display: block;
      border: 10px solid transparent;
      border-right: 10px solid #FFF;
      left: 50px;
      top: 20px;
    }
  </style>
</wiki-nav>
