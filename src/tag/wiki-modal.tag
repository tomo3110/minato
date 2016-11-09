<wiki-modal>
  <section class='modal-content'>
    <yield />
  </section>
  <section class='modal-overlay' onclick={ opts.hide }></section>

  <style scoped>
    :scope section.modal-content {
      display: flex;
      flex-direction: column;
      position: fixed;
      background-color: #fff;
      top: 20%;
      left: 50%;
      margin-left: -200px;
      z-index: 101;
      border-radius: 5px;
      box-shadow: 0px 4px 10px 1px rgba(0,0,0,0.5);
      min-width: 400px;
    }
    :scope .modal-content-body {
      margin: 3rem;
    }
    :scope section.modal-overlay {
      position: fixed;
      background-color: rgba(0,0,0,0.5);
      z-index: 100;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
  </style>
</wiki-modal>
