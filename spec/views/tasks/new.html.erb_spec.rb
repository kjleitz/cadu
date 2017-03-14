require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :content => "MyText",
      :user => nil,
      :status => 1,
      :timestamps => "MyString"
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "textarea#task_content[name=?]", "task[content]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_status[name=?]", "task[status]"

      assert_select "input#task_timestamps[name=?]", "task[timestamps]"
    end
  end
end
