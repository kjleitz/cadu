module ApplicationHelper

  def user_os_mac?
    request.env['HTTP_USER_AGENT'].downcase.match(/mac/i)
  end

  def random_color_for(record)
    Random.new(record.id).rand(16**5...16**6).to_s(16)
  end

  def current_path
    request.url
  end

end
