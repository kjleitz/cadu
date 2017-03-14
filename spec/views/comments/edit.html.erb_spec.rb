require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :content => "MyText",
      :task => nil,
      :user => nil,
      :pinned => false,
      :edited => false
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "textarea#comment_content[name=?]", "comment[content]"

      assert_select "input#comment_task_id[name=?]", "comment[task_id]"

      assert_select "input#comment_user_id[name=?]", "comment[user_id]"

      assert_select "input#comment_pinned[name=?]", "comment[pinned]"

      assert_select "input#comment_edited[name=?]", "comment[edited]"
    end
  end
end
