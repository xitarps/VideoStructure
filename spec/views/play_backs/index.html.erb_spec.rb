require 'rails_helper'

RSpec.describe "play_backs/index", type: :view do
  before(:each) do
    assign(:play_backs, [
      PlayBack.create!(
        title: "Title",
        url: "Url",
        views: 2
      ),
      PlayBack.create!(
        title: "Title",
        url: "Url",
        views: 2
      )
    ])
  end

  it "renders a list of play_backs" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Url".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
