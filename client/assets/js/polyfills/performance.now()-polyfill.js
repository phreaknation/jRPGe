(function(){

  // prepare base perf object
  if (typeof window.performance === 'undefined') {
      window.performance = {};
  }

  if (!window.performance.now){

    var nowOffset = Date.now();

    if (performance.timing && performance.timing.navigationStart){
      nowOffset = performance.timing.navigationStart
    }

    window.performance.now = function now(){
      return Date.now() - nowOffset;
    }

  }

})();