module ApplicationHelper

  def user_os_mac?
    request.env['HTTP_USER_AGENT'].downcase.match(/mac/i)
  end

end
