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
  //       human_created_at: "<some readable time>",
  //       content: "content of the comment",
  //       author: {
  //         name: "author name",
  //         avatar_url: "http://avatar.com/avatar"
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
  Handlebars.registerPartial('floatingTaskCardTabs', $('#floating-task-card-tabs-partial').html());
}
