// Comment-related objects

function CommentFor(taskId) {
  this.task = {
    id: taskId,
    title: $('.task_card_' + taskId + ' .task-title').text()
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

function displayCommentsFor(taskId) {
  function placeComments(taskId, data) {
    var context = commentsContextFor(taskId, data);
    var commentsHTML = commentsTemplate(context);
    var commentsDivSelector = '.task_comments_' + taskId;
    $(commentsDivSelector).html(commentsHTML);
  }

  $.get('/tasks/' + taskId + '/comments.json')
    .success(placeComments.bind(null, taskId));
}

function collapseCommentsFor(taskId) {
  var commentsDivSelector = '.task_comments_' + taskId;
  $(commentsDivSelector).html('');
}

function activateTab(tabName, taskId) {
  var tabsSelector = '.task_card_' + taskId + ' .card-header .nav-item > .nav-link';
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


// MAIN

$(initCommentPartials);
