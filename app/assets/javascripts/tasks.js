// Task-related objects

function taskContext(data) {
  // this is assuming a GET of /tasks/1.json returns the following:
  // {
  //   id: "task id",
  //   title: "task title",
  //   content: "task content",
  //   human_due_date: "<some readable time>",
  //   status: "task status",
  //   idle: <boolean>,
  //   requested: <boolean>,
  //   accepted: <boolean>,
  //   in_progress: <boolean>,
  //   completed: <boolean>,
  //   num_comments: <number>,
  //   labels: [
  //     {
  //       id: "label id",
  //       name: "label name"
  //     },
  //     // ...
  //   ],
  //   client: {
  //     id: "client id",
  //     name: "client name"
  //   }
  // }

  return { task: data };
}


// UI logic

function placeShade() {
  var shade = document.createElement('div');
  $(shade).addClass('shade');
  $(shade).css({
    'position': 'fixed',
    'top': 0,
    'right': 0,
    'bottom': 0,
    'left': 0,
    'background-color': 'rgba(0, 0, 0, 0.5)',
    'z-index': 10
  });
  $('body').append(shade);
}

function removeShade() {
  $('.shade').remove();
}

function attachShadeListeners() {
  $('.shade').on('click', closeFloatingTaskCard);
}

function attachFloatingTaskListeners() {
  $('.floating-task .comments-link').on('click', commentsLinkAction);
  $('.floating-task .summary-link').on('click', summaryLinkAction);
}

function displayFloatingTaskCard(taskId) {
  function placeFloatingTaskCard(taskId, data) {
    var floatingTaskHTML = floatingTaskTemplate(taskContext(data));
    $('body').append(floatingTaskHTML);
    $('.floating-task').css({
      'position': 'absolute',
      'top': $(document).scrollTop(),
      'margin-top': '2.5rem',
      'z-index': '20'
    });
  }

  $.get('/tasks/' + taskId + '.json')
    .success([
      placeShade,
      attachShadeListeners,
      placeFloatingTaskCard.bind(null, taskId),
      attachFloatingTaskListeners
    ]);
}

function closeFloatingTaskCard() {
  $('.floating-task').remove();
  removeShade();
}

function attachTaskTabListeners() {
  $('.comments-link').on('click', commentsLinkAction);
  $('.summary-link').on('click', summaryLinkAction);
}

// MAIN

$(document).on('turbolinks:load', initTaskPartials);
$(document).on('turbolinks:load', attachTaskTabListeners);
