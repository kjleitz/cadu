'use strict';

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

document.getElementById('new-reminders-tab-link').onclick = function(){
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

document.getElementById('dismissed-reminders-tab-link').onclick = function(){
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
