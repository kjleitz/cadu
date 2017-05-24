// Comment actions

function submitComment(event) {
  event.preventDefault();
  var form = event.target;
  var comment = $(form).serialize();
  var taskId = form.dataset.task;
  createComment(comment, taskId, displayCommentsFor.bind(null, taskId), alert);
}

function createComment(commentData, taskId, callback, errorFn) {
  $.post('/tasks/' + taskId + '/comments', commentData, null, 'json')
  .done(function(data) {
    callback(data);
  })
  .fail(function() {
    errorFn('Something went wrong.');
  });
}

function deleteComment(event) {
  event.preventDefault();
  var anchor = event.target;
  var comment = new Comment({ id: anchor.dataset.comment });
  comment.destroy(displayCommentsFor.bind(null, anchor.dataset.task));
}


// Comment-related objects

function CommentFor(taskId) {
  this.task = {
    id: taskId,
    title: $('.task_card_' + taskId + ' .task-title').first().text()
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
  //       id: <author id>,
  //       name: "author name"
  //       avatar_url: "http://avatar.com/avatar"
  //     },
  //     task: {
  //       id: 1
  //       title: "task title"
  //     }
  //   },
  //   // ...
  // ]

  var newComment = { newComment: new CommentFor(taskId) };
  var comments = { comments: data };

  return Object.assign({}, comments, newComment);
}

function Comment(commentData) {
  // yes, I know this is silly and I could use Object.create(), but I'm
  // doing it the long, inflexible, traditional way on purpose
  this.id = commentData.id;
  this.url = '/comments/' + this.id;
  this.task_id = commentData.task_id;
  this.content = commentData.content;
  this.human_created_at = commentData.human_created_at;
  this.author = {
    name: commentData.author ? commentData.author.name : null,
    avatar_url: commentData.author ? commentData.author.avatar_url : null
  };
  this.task = {
    id: commentData.task ? commentData.task.id: null,
    title: commentData.task ? commentData.task.title : null
  };
}

Comment.prototype.destroy = function(callback) {
  $.ajax({
    method: 'DELETE',
    url: this.url,
    dataType: 'json',
    success: [
      alert.bind(window, 'Comment was successfully deleted.'),
      callback
    ],
    error: alert.bind(window, 'Something went wrong.')
  });
};


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
