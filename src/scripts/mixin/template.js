const templateMixin = {
  getTemplateList(wikiList = []) {
    const res = wikiList.filter(wiki => wiki.title.indexOf('template') != -1);
    return res.map(wiki => {
      return {
        label: this.parseTempate(wiki.title),
        value: wiki.key
      };
    });
  },
  parseTempate(str = '') {
    const // 
      yearDate = this.toDoubleDigits(new Date().getFullYear()),
      monthDate = this.toDoubleDigits(new Date().getMonth() + 1),
      dayDate = this.toDoubleDigits(new Date().getDate()),
      weekDate = this.getWeek();
    
    const // 
      yearReg = new RegExp(/%{Year}/, 'g'),
      monthReg = new RegExp(/%{month}/, 'g'),
      dayReg = new RegExp(/%{day}/, 'g'),
      weekReg = new RegExp(/%{week}/, 'g');
    
    return str
      .replace(yearReg, yearDate)
      .replace(monthReg, monthDate)
      .replace(dayReg, dayDate)
      .replace(weekReg, weekDate);
  },
  toDoubleDigits(num = 1) {
    const numStr = num + '';
    if (numStr.length === 1) {
      return '0' + num;
    } else {
      return numStr;
    }
  },
  getWeek() {
    const weeklist = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];
    return weeklist[new Date().getDay()];
  }
};

export default templateMixin;