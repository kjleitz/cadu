function getUserInputData() {
  var userId = $('#user-card').data('user');
  var inputs = $.makeArray($('.user-card .user-info'));
  return inputs.reduce(function(data, elem) {
    data[elem.name] = elem.value;
    return data;
  }, {'user[id]': userId});
}

function showUserInfo(resp) {
  $('.editable').each(function(i, elem) {
    var type = $(elem).data('type');
    var info = resp[type];
    if (info !== undefined) elem.innerHTML = info;
  });
  $('.editable').show();
  $('.user-info').hide();
}

function saveUserInfo() {
  var data = getUserInputData();
  $.ajax({
    'method': 'PATCH',
    'url': '/users/' + data['user[id]'],
    'dataType': 'json',
    'data': data,
    success: showUserInfo,
    error: function() {
      alert('something went wrong');
    }
  });
}

function makeEditable(element) {
  var type = element.dataset.type;
  var $input = $('.user-info-' + type);
  $(element).hide();
  $input.show();
  $input.focus();
}

function attachEditableListeners() {
  $('.user-card').on('click', function(event) {
    var element = event.target;
    if ($(element).hasClass('editable')) {
      makeEditable(element);
    } else if (!$(element).hasClass('user-info')) {
      saveUserInfo();
    }
  });
}

function attachUserInfoListeners() {
  $('.user-info').on('keypress', function(event) {
    if (event.which === 13) {
      saveUserInfo();
    }
  });
}

$(document).on('turbolinks:load', attachEditableListeners);
$(document).on('turbolinks:load', attachUserInfoListeners);
