// Handlebars setup stuff

function templateFor(name) {
  return Handlebars.compile($('#' + name + '-template').html());
}

function commentsTemplate(context) {
  // context should be of this format:
  // {
  //   task_id: <task id>,
  //   comments: [
  //     {
  //       human_created_at: "<some readable time>",
  //       content: "content of the comment",
  //       author: {
  //         name: "author name"
  //       }
  //     },
  //     {
  //       human_created_at: "<some readable time>",
  //       content: "content of the comment",
  //       author: {
  //         name: "author name"
  //       }
  //     },
  //     // ...
  //   ],
  //   newComment: {
  //     task: {
  //       id: "task id",
  //       title: "task title"
  //     }
  //   }
  // }

  return templateFor('comments')(context);
}

function initCommentPartials() {
  Handlebars.registerPartial('commentCard', $('#comment-card-partial').html());
  Handlebars.registerPartial('commentFormCard', $('#comment-form-card-partial').html());
}


// Comment-related objects

function CommentFor(taskId) {
  this.task = {
    id: taskId,
    title: $('#task_title_' + taskId).text()
  };
}

function commentsContextFor(data) {
  // this is assuming a GET of /tasks/1/comments.json returns the following:
  // {
  //   task_id: 1,
  //   comments: [
  //     {
  //       human_created_at: "<some readable time>",
  //       content: "content of the comment",
  //       author: {
  //         name: "author name"
  //       }
  //     },
  //     {
  //       human_created_at: "<some readable time>",
  //       content: "content of the comment",
  //       author: {
  //         name: "author name"
  //       }
  //     },
  //     // ...
  //   ]
  // };

  var newComment = { newComment: new CommentFor(data.task_id) };

  return Object.assign({}, data, newComment);
}


// UI logic

function displayCommentsFor(taskId) {
  $.get('/tasks/' + taskId + '/comments.json')
    .success(function(data) {
      var context = commentsContextFor(data);
      var commentsHTML = commentsTemplate(context);
      var $taskCard = $('#task_card_' + data.task_id);
      $taskCard.after(commentsHTML);
    });
}

function attachListeners() {
  $('.comments-link').on('click', function(e) {
    e.preventDefault();
    var taskId = $(this).data('task');
    displayCommentsFor(taskId);
  });
}


// MAIN

$(initCommentPartials);
$(attachListeners)
