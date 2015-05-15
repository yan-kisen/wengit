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
  menu.popup(remote.getCurrentWindow());
}, false);

var $ = window.jQuery = require('jquery');
require('select2');

$(document).ready(function(){
  $("#close").click(function(){
    BrowserWindow.getFocusedWindow().close();
  });

  $(".filter ~ i.uk-icon-remove").click(function(){
    $(this.previousSibling).val("").attr("value", "");
  });

  $(".filter").keyup(function(){
    $(this).attr("value", this.value);
  });

  $("#create-repo-gitignore").select2();
});



/*

var git = require('nodegit');
var remote = require('remote');
var EventEmitter = require('events').EventEmitter;
var wengit = new EventEmitter();
var app = remote.require('app');

*/
