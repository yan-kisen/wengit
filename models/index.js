"use strict";

var riot = module.parent.require('riot');

riot.mixin('getSetOpts', {
  init: function(){
    this.root.riot = this;
  },
  getOpts: function() {
    return this.opts;
  },
  setOpts: function(nopts){
    Object.apply(this.opts, nopts);
    console.log(this.opts, nopts);
    return this;
  },
  getRiotObject: function(){
    return this;
  }
});

require('./window-buttons.tag');
require('./sidebar.tag');
require('./repository.tag');

require('./dropdown.tag');
require('./tabs.tag');
require('./inputs.tag');
require('./overlay.tag');
