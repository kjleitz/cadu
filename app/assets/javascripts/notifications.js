// UI logic

function notificationLinkAction(event) {
  event.preventDefault();
  var taskId = event.target.dataset.task;
  // open floater
}

function attachNotificationListeners() {
  $('.notification-link').on('click', notificationLinkAction);
}


// MAIN

$(attachNotificationListeners);
