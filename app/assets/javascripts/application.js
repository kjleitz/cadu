// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


/* * * * * * * * * * * * * * * * * * * *
 *  YES, I KNOW HOW TERRIBLE THIS      *
 *  JAVASCRIPT IS. PLEASE DON'T JUDGE  *
 *  ME, I SWEAR I'LL FIX IT LATER      *
 * * * * * * * * * * * * * * * * * * * */


function addClassById(addHook, addClass) {
  let addElem = document.getElementById(addHook);
  let nAdded = addElem.className.indexOf(addClass);
  if(nAdded === -1) {
    addElem.className += (" " + addClass);
  }
}

function remClassById(remHook, remClass) {
  let remElem = document.getElementById(remHook);
  let nRemoved = remElem.className.indexOf(remClass);
  if(nRemoved > -1) {
    remElem.className = remElem.className.replace(remClass, "").trim();
  }
}

window.onload = function(){
  let newRemindersLink = document.getElementById('new-reminders-tab-link');
  newRemindersLink.onclick = function(){
    // Make the new tab active
    addClassById('new-reminders-tab-link', 'active');
    remClassById('dismissed-reminders-tab-link', 'active');

    // Make the dismissed tab muted
    remClassById('new-reminders-tab-link', 'text-muted');
    addClassById('dismissed-reminders-tab-link', 'text-muted');

    // Hide the dismissed tab contents
    remClassById('new-reminder-card-list', 'hidden-xs-up');
    addClassById('dismissed-reminder-card-list', 'hidden-xs-up');

    return false;
  }

  let disRemindersLink = document.getElementById('dismissed-reminders-tab-link');
  disRemindersLink.onclick = function(){
    // Make the dismissed tab active
    addClassById('dismissed-reminders-tab-link', 'active');
    remClassById('new-reminders-tab-link', 'active');

    // Make the new tab muted
    remClassById('dismissed-reminders-tab-link', 'text-muted');
    addClassById('new-reminders-tab-link', 'text-muted');

    // Hide the new tab contents
    remClassById('dismissed-reminder-card-list', 'hidden-xs-up');
    addClassById('new-reminder-card-list', 'hidden-xs-up');

    return false;
  }
}
