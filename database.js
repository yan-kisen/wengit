"use strict";

var fs = require('fs');
var del = require('del');

var database = module.exports = {
  defaultData: {

  },
  save: function(data, callback){
    callback = callback || function(){};
    var json = JSON.stringify(data);
    var counter = 0;
    function done(err){
      if(err){
        counter = 3;
        return callback(err);
      }
      counter++;
      if(counter === 2){
        callback();
      }
    }
    fs.writeFile('dumps/'+(Date()).toISOString()+'.dmp', json, done);
    fs.writeFile('dumps/latest.dmp', json, done);
  },
  load: function(){
    try {
      var file = fs.readFileSync('dumps/latest.dmp');
      return JSON.parse(file);
    } catch(e){
      return database.defaultData;
    }
  },
  purge: function(){
    return del.sync("dumps/*.dmp");
  }
};
