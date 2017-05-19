// UI logic

function attachTaskTabListeners() {
  $('.comments-link').on('click', commentsLinkAction);
  $('.summary-link').on('click', summaryLinkAction);
}

// MAIN

$(initTaskPartials);
$(attachTaskTabListeners);
