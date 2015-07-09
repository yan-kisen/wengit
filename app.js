"use strict";

// electron modules
var remote = require('remote');
var Menu = remote.require('menu');
var MenuItem = remote.require('menu-item');
var BrowserWindow = remote.require('browser-window');
var Dialog = remote.require('dialog');

// contextmenu for reload, devtools
var menu = new Menu();
menu.append(new MenuItem({
  label: 'Toggle DevTools',
  accelerator: 'Ctrl+Shift+J',
  click: function() {
    BrowserWindow.getFocusedWindow().toggleDevTools();
  }
}));
menu.append(new MenuItem({ type: 'separator' }));
menu.append(new MenuItem({
  label: 'Reload',
  accelerator: 'Ctrl+R',
  click: function() {
    BrowserWindow.getFocusedWindow().reloadIgnoringCache();
  }
}));
window.addEventListener('contextmenu', function(e) {
  e.preventDefault();
  menu.popup(mainWindow);
}, false);

// setup easier DOM stuff
NodeList.prototype[Symbol.iterator] = Array.prototype[Symbol.iterator];
Element.prototype.on = function(eventType, callback){
  this.addEventListener(eventType, callback, false);
};
Element.prototype.off = function(eventType, callback){
  this.removeEventListener(eventType, callback, false);
};

// var $ = require('jquery');
var fuzzy = require('fuzzysearch');

// setup riot stuff
var riot = require('riot');
require("./models");

// add gitignore types to list in add tab
require('gitignore').getTypes(function(err, types){
  if(err){
    console.error("Could not load git ignore types. Using cache.");
    types = require('./gitignore-cache.json');
  }
  var select = document.querySelector("#create-repo-git-ignore");
  for(let type of types){
    var a = document.createElement('a');
    a.href = "#";
    var li = document.createElement('li');
    li.dataset.value = a.innerHTML = type;
    li.appendChild(a);
    select.appendChild(li);
  }
});

var mainWindow = BrowserWindow.getFocusedWindow();

window.addEventListener('load', function(){
  // handle mounting of riot elements
  riot.mount('window-buttons, sidebar, repository');

  // set and update state of window to class of html and variable
  var maxed = mainWindow.isMaximized();
  document.documentElement.classList.toggle("max", maxed);
  mainWindow.on('maximize', function(){
    document.documentElement.classList.add("max");
  });
  mainWindow.on('unmaximize', function(){
    document.documentElement.classList.remove("max");
  });
}, false);
