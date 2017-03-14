require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :content => "MyText",
      :user => nil,
      :status => 1,
      :timestamps => "MyString"
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "textarea#task_content[name=?]", "task[content]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_status[name=?]", "task[status]"

      assert_select "input#task_timestamps[name=?]", "task[timestamps]"
    end
  end
end
