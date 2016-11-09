import './wiki-user-photo';
import './wiki-modal';

<wiki-user>
  <wiki-user-photo show={ opts.user } src={ opts.user.photoURL } size='50px' onclick={ showModal }></wiki-user-photo>
  <a show={ !opts.user } class='user-login' onclick={ login }><i class='fa fa-sign-in' aria-hidden='true'></i>LOGIN</a>
  <wiki-modal show={ isShowModal } hide={ hideModal }>
    <section class='modal-content-body'>
      <wiki-user-photo show={ this.parent.opts.user } src={ this.parent.opts.user.photoURL } size='85px'></wiki-user-photo>
      <p>Do you Logout ?</p>
      <button type='button' onclick={ this.parent.logout }>logout</button>
    </section>
  </wiki-modal>

  <script>
    this.isShowModal = false;

    login(e) {
      opts.store.signIn().then(res => {
        this.update();
      });
    }
    logout(e) {
      opts.store.signOut().then(res => {
        opts.store.user = null;
        this.isShowModal = false;
        this.update();
      });
    }
    showModal(e) {
      this.isShowModal = true;
      this.update();
    }
    hideModal(e) {
      this.isShowModal = false;
      this.update();
    }
  </script>

  <style scoped>
    :scope {
      display: flex;
    }
    :scope wiki-user-photo {
      margin: 1.5rem;
      cursor: pointer;
    }
    :scope a.user-login {
      display: flex;
      flex-direction: column;
      align-items: center;
      color: #fff;
      text-decoration: none;
      cursor: pointer;
      margin: 1.5rem;
    }
    :scope a.user-login > i {
      color: #fff;
      font-size: 3.5rem;
    }
    :scope section.modal-content-body  {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      margin: 1.5rem;
    }
    :scope section.modal-content-body > p {
      font-size: 2rem;
    }
    :scope section.modal-content-body > button {
      width: 100%;
    }
  </style>
</wiki-user>
