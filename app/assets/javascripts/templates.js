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

function initCommentPartials() {
  Handlebars.registerPartial('commentCard', $('#comment-card-partial').html());
  Handlebars.registerPartial('commentFormCard', $('#comment-form-card-partial').html());
}
