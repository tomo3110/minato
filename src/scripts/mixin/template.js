const templateMixin = {
  getTemplateList(wikiList = []) {
    const reg = new RegExp(/^tamplate/, 'g');
    return wikiList.filter(wiki => wiki.title.match(reg));
  },
  parseTempate(str = '') {
    const // 
      yearDate = this.toDoubleDigits(new Date().getFullYear()),
      monthDate = this.toDoubleDigits(new Date().getMonth()),
      dayDate = this.toDoubleDigits(new Date().getDay());
    
    const // 
      yearReg = new RegExp(/%{Year}/, 'g'),
      monthReg = new RegExp(/%{month}/, 'g'),
      dayReg = new RegExp(/%{day}/, 'g');
    
    return str
      .replace(yearReg, yearDate)
      .replace(monthReg, monthDate)
      .replace(dayReg, dayDate);
  },
  toDoubleDigits(num = 1) {
    const numStr = num + '';
    if (numStr.length === 1) {
      return '0' + num;
    } else {
      return numStr;
    }
  }
};

export default templateMixin;