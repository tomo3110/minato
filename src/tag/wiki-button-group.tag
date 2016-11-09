<wiki-button-group>
  <yield />

  <style scoped>
    :scope {
      display: flex;
      margin: 0;
      width: 50rem;
    }

    button {
      margin: 0;
      flex: 1;
      font-size: 1rem;
      height: 3rem;
      line-height: 0;
      border-color: #0094ff;
      color: #0094ff;
      border-radius: 0px;
      border-width: 1px;
      border-left-width: 0px;
      font-family: Raleway, serif;
    }
    button:first-child {
      border-top-left-radius: 15px;
      border-bottom-left-radius: 15px;
      border-left-width: 1px;
      border-rigth-width: 0px;
    }
    button:last-child {
      border-top-right-radius: 15px;
      border-bottom-right-radius: 15px;
      border-left-width: 0px;
      border-rigth-width: 1px;
    }
    button.active {
      background-color: #0094ff;
      color: #fff;
      border-color: #0094ff;
    }
    button:hover {
      background-color: #0094ff;
      color: #fff;
      border-color: #0094ff;
    }
  </style>
</wiki-button-group>
