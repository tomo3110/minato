
const markdownHelper = {
  // init() {
    
  // },
  inputed(e) {
    const value = this.postTextarea.value;
    // opts.onChange(value);
    switch (e.which || e.keyCode) {
      case 9: {
        this.tabKeyPus(e);
        block;
      }
      case 13: {
        this.enterKeyPush(e);
        block;
      }
      case 32: {
        this.spaceKeyPush(e);
        block;
      }  
    }
  },
  tabKeyPush(e) {
    console.log(e);
  },
  enterKeyPush(e) {

  },
  spaceKeyPush(e) {

  }
};

riot.mixin('markdownHelper', markdownHelper);