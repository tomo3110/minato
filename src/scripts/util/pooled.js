
class Pool {
  constructor(CopyConstructor = {}, poolSize = 50) {
    this.PoolConstructor = CopyConstructor;
    this.instancePool = [];
    this.poolSize = poolSize;
  }
  allocate(...args) {
    if (this.instancePool.length) {
      const instance = this.instancePool.pop();
      return instance.init(...args);
    } else {
      return new this.PoolConstructor(...args);
    }
  }
  release(instance) {
    if (instance instanceof this.PoolConstructor) {
      instance.destructor();
      if (this.instancePool.length < this.poolSize) {
        this.instancePool.push(instance);
      }
    }
  }
  releaseList(instanceList = []) {
    instanceList.forEach(this.release, this);
  }
}

export default Pool;
