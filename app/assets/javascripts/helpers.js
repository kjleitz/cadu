function ifEqual(value1, value2, options) {
  if (value1 === value2) {
    return options.fn(this);
  }
}

function commentCount(num) {
  return num + " comment" + (num === 1 ? "" : "s");
}

function initHelpers() {
  Handlebars.registerHelper('ifEqual', ifEqual);
  Handlebars.registerHelper('commentCount', commentCount);
}

$(document).on('turbolinks:load', initHelpers);
