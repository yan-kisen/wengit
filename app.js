"use strict";

var remote = require('remote');
var Menu = remote.require('menu');
var MenuItem = remote.require('menu-item');
var BrowserWindow = remote.require('browser-window');
var Dialog = remote.require('dialog');

var menu = new Menu();
menu.append(new MenuItem({ label: 'Toggle DevTools', accelerator: 'Ctrl+Shift+J', click: function() { BrowserWindow.getFocusedWindow().toggleDevTools(); } }));
menu.append(new MenuItem({ type: 'separator' }));
menu.append(new MenuItem({ label: 'Reload', accelerator: 'Ctrl+R', click: function() { BrowserWindow.getFocusedWindow().reloadIgnoringCache(); } }));

window.addEventListener('contextmenu', function (e) {
  e.preventDefault();
  menu.popup(mainWindow());
}, false);

// var $ = require('jquery');
var fuzzy = require('fuzzysearch');

var riot = require('riot');
var mainWindow = function(){
  return BrowserWindow.getFocusedWindow();
};

require("./models");

window.addEventListener('load', function(){
  // handle mounting of riot elements
  riot.mount('window-buttons, sidebar, repository');

  require('gitignore').getTypes(function(err, types){
    if(err){
      console.error("Could not load git ignore types. Using cache.");
      types = require('./gitignore-cache.json');
    }
    var select = document.querySelector("#create-repo-git-ignore > ul");
    types.forEach(function(type){
      var a = document.createElement('a');
      a.href = "#";
      var li = document.createElement('li');
      li.dataset.value = a.innerHTML = type;
      li.appendChild(a);
      select.appendChild(li);
    });
  });

  // set and update state of window to class of html
  var maxed = mainWindow().isMaximized();
  document.documentElement.className = maxed ? "max" : "";
  mainWindow().on('maximize', function(){
    document.documentElement.className = "max";
  });
  mainWindow().on('unmaximize', function(){
    document.documentElement.className = "";
  });
});
