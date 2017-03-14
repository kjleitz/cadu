require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        :content => "MyText",
        :user => nil,
        :status => 2,
        :timestamps => "Timestamps"
      ),
      Task.create!(
        :content => "MyText",
        :user => nil,
        :status => 2,
        :timestamps => "Timestamps"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Timestamps".to_s, :count => 2
  end
end
