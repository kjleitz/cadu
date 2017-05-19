// Handlebars setup stuff

// function templateFor(name) {
//   return Handlebars.compile($('#' + name + '-template').html());
// }
//
// function commentsTemplate(context) {
//   // context should be of this format:
//   // {
//   //   comments: [
//   //     {
//   //       id: <comment_id>,
//   //       task_id: <task_id>,
//   //       human_created_at: "<some readable time>",
//   //       content: "content of the comment",
//   //       author: {
//   //         name: "author name",
//   //         avatar_url: "http://avatar.com/avatar"
//   //       }
//   //     },
//   //     // ...
//   //   ],
//   //   newComment: {
//   //     task: {
//   //       id: "task id",
//   //       title: "task title"
//   //     }
//   //   }
//   // }
//
//   return templateFor('comments')(context);
// }
//
// function initCommentPartials() {
//   Handlebars.registerPartial('commentCard', $('#comment-card-partial').html());
//   Handlebars.registerPartial('commentFormCard', $('#comment-form-card-partial').html());
// }


// Comment-related objects

function CommentFor(taskId) {
  this.task = {
    id: taskId,
    title: $('#task_card_' + taskId + ' .task-title').text()
  };
}

function commentsContextFor(taskId, data) {
  // this is assuming a GET of /tasks/1/comments.json returns the following:
  // [
  //   {
  //     id: <comment id>,
  //     task_id: 1,
  //     human_created_at: "<some readable time>",
  //     content: "content of the comment",
  //     author: {
  //       name: "author name"
  //       avatar_url: "http://avatar.com/avatar"
  //     }
  //   },
  //   // ...
  // ]

  var newComment = { newComment: new CommentFor(taskId) };
  var comments = { comments: data };

  return Object.assign({}, comments, newComment);
}


// UI logic

function displayCommentsFor(taskId, isFloater) {
  function placeComments(taskId, data) {
    var context = commentsContextFor(taskId, data);
    var commentsHTML = commentsTemplate(context);
    commentsDivSelector = '#' + (isFloater ? 'floating_' : '') + 'task_comments_' + taskId;
    $(commentsDivSelector).html(commentsHTML);
  }

  $.get('/tasks/' + taskId + '/comments.json')
    .success(placeComments.bind(null, taskId));
}

function collapseCommentsFor(taskId) {
  $('#task_comments_' + taskId).html('');
}

function activateTab(tabName, taskId) {
  var tabsSelector = '#task_card_' + taskId + ' .card-header .nav-item > .nav-link';
  var tabSelector = tabsSelector + '.' + tabName + '-link';
  $(tabsSelector).removeClass('active');
  $(tabsSelector).addClass('text-muted');
  $(tabSelector).removeClass('text-muted');
  $(tabSelector).addClass('active');
}

function activateSummaryTab(taskId) {
  return activateTab.call(this, 'summary', taskId);
}

function activateCommentsTab(taskId) {
  return activateTab.call(this, 'comments', taskId);
}

function activateEditTab(taskId) {
  return activateTab.call(this, 'edit', taskId);
}

function commentsLinkAction(event) {
  event.preventDefault();
  var taskId = event.target.dataset.task;
  activateCommentsTab(taskId);
  displayCommentsFor(taskId);
}

function summaryLinkAction(event) {
  event.preventDefault();
  var taskId = event.target.dataset.task;
  activateSummaryTab(taskId);
  collapseCommentsFor(taskId);
}

function attachListeners() {
  $('.comments-link').on('click', commentsLinkAction);
  $('.summary-link').on('click', summaryLinkAction);
}


// MAIN

$(initCommentPartials);
$(attachListeners);
