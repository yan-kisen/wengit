"use strict";

/*
var riot = require('riot');
var fs = require('fs');

var models = [
  "inputs",
  "dropdown",
  "overlay",
  "window-buttons"
];

var scripts = "";
models.forEach(function(model){
  var script = fs.readFileSync(__dirname + '/' + model + '.tag');
  scripts += riot.compile(script);
});

module.exports = scripts;

*/



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
  }
});

require('./windowbuttons.tag');
require('./sidebar.tag');
require('./repository.tag');

require('./dropdown.tag');
require('./tabs.tag');
require('./inputs.tag');
require('./overlay.tag');
