// UI logic

function markNotificationSeen(notificationId, url) {
  $.post(url, { foo: 'bar' }, function(data) {
    $notificationLi = $('#notification_' + data.id);
    $notificationLi.removeClass('seen unseen');
    $notificationLi.addClass(data.status);
  }, 'json');
}

function notificationLinkAction(event) {
  event.preventDefault();
  event.stopPropagation();
  var notificationAnchor = event.target.parentElement;
  markNotificationSeen(notificationAnchor.dataset.id, notificationAnchor.href);
  var taskId = notificationAnchor.dataset.task;
  displayFloatingTaskCard(taskId);
}

function attachNotificationListeners() {
  $('.notification-item').on('click', notificationLinkAction);
}


// MAIN

$(attachNotificationListeners);
