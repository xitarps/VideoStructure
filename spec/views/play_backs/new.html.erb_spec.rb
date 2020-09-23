require 'rails_helper'

RSpec.describe "play_backs/new", type: :view do
  before(:each) do
    assign(:play_back, PlayBack.new(
      title: "MyString",
      url: "MyString",
      views: 1
    ))
  end

  it "renders new play_back form" do
    render

    assert_select "form[action=?][method=?]", play_backs_path, "post" do

      assert_select "input[name=?]", "play_back[title]"

      assert_select "input[name=?]", "play_back[url]"

      assert_select "input[name=?]", "play_back[views]"
    end
  end
end
