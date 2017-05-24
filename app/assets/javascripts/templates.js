function templateFor(name) {
  return Handlebars.compile($('#' + name + '-template').html());
}

function commentsTemplate(context) {
  // context should be of this format:
  // {
  //   comments: [
  //     {
  //       id: <comment_id>,
  //       task_id: <task_id>,
  //       author_id: <task_id>,
  //       human_created_at: "<some readable time>",
  //       content: "content of the comment",
  //       author: {
  //         id: <author id>,
  //         name: "author name",
  //         avatar_url: "http://avatar.com/avatar"
  //       },
  //       task: {
  //         id: 1
  //         title: "task title"
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

function floatingTaskTemplate(context) {
  // context should be of this format:
  // {
  //   task: {
  //     id: "task id",
  //     status: "task status",
  //     content: "task content",
  //     human_due_date: "<some readable time>",
  //     labels: [
  //       {
  //         id: "label id",
  //         name: "label name"
  //       },
  //       // ...
  //     ],
  //     client: {
  //       id: "client id",
  //       name: "client name"
  //     }
  //   }
  // }

  return templateFor('floating-task-card')(context);
}

function initCommentPartials() {
  Handlebars.registerPartial('commentCard', $('#comment-card-partial').html());
  Handlebars.registerPartial('commentFormCard', $('#comment-form-card-partial').html());
}

function initTaskPartials() {
  Handlebars.registerPartial('floatingTaskCardTabs', $('#floating-task-card-tabs-partial').html());
}


// MAIN

$(document).on('turbolinks:load', initTaskPartials);
$(document).on('turbolinks:load', initCommentPartials);
