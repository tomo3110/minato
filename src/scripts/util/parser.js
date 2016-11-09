export function urlArrParser(url) {

  if(!typeof url === 'string') return false;

  return url.split('/');
};

export function arrObjSearch(arr = [], obj = {}) {

  const key = arr.shift();
  let resolt = null;

  if (typeof obj[key] === 'undefined') {
    return false;
  } else {
    resolt = obj[key];
  }

  if (arr.length) {
    return arrObjSearch(arr, resolt);
  } else {
    return resolt;
  }
};

export function keysUrlParser(url = '', obj = {}) {

  if (!typeof obj === 'object') return false;

  const keys = Object.keys(obj);

  const resolt = [];
  if (keys.length) {
    keys.forEach(key => {
      if (!/^_/.test(key) && !/^content/.test(key)) {
        resolt.push(`${(url.length) ? `${url}/` : ''}${key}/`);
      }
    });
  }
  return resolt;
};

export function objArrParser(obj = {}, url = '', resolt = []) {

  if (!typeof obj === 'object') return false;

  const list = Object.keys(obj);

  list.forEach(key => {
    if (/^_/.test(key)) return false;
    if (key === 'content') {
      if (obj._local === url) {
        resolt.push(url);
      }
    } else  {
      if (typeof obj === 'object') {
        return objArrParser(obj[key], `${(url.length) ? `${url}/` : ''}${key}`, resolt);
      }
    }
  });
  return resolt;
};

export function urlObjParser(url, obj = {}) {

  if(!typeof url === 'string') return false;
  if(!typeof obj === 'object') return false;

  const urlArr = urlArrParser(url);

  return arrObjSearch(urlArr, obj);
};
