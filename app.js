"use strict";

var remote = require('remote');
var Menu = remote.require('menu');
var MenuItem = remote.require('menu-item');
var BrowserWindow = remote.require('browser-window');

var menu = new Menu();
menu.append(new MenuItem({ label: 'Toggle DevTools', accelerator: 'Ctrl+Shift+J', click: function() { BrowserWindow.getFocusedWindow().toggleDevTools(); } }));
menu.append(new MenuItem({ type: 'separator' }));
menu.append(new MenuItem({ label: 'Reload', accelerator: 'Ctrl+R', click: function() { BrowserWindow.getFocusedWindow().reloadIgnoringCache(); } }));

window.addEventListener('contextmenu', function (e) {
  e.preventDefault();
  menu.popup(mainWindow());
}, false);

var $ = require('jquery');
var fuzzy = require('fuzzysearch');

var riot = require('riot');
var mainWindow = function(){
  return BrowserWindow.getFocusedWindow();
};

require("./models");

window.addEventListener('load', function(){
  // handle mounting of riot elements
  riot.mount('windowbuttons, sidebar, repository');

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
