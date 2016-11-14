const scrollSync = {
  getScrollRate(targetElement) {
    const rect = targetElement.getBoundingClientRect();  
    this.scrollTop = targetElement.scrollTop;
    this.scrollHeight = targetElement.scrollHeight;
    this.maxScrollTop = this.scrollHeight - rect.height;
    return this.scrollTop / this.maxScrollTop;
  }
};

riot.mixin('scrollSync', scrollSync);