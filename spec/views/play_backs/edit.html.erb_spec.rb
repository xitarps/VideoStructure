require 'rails_helper'

RSpec.describe "play_backs/edit", type: :view do
  before(:each) do
    @play_back = assign(:play_back, PlayBack.create!(
      title: "MyString",
      url: "MyString",
      views: 1
    ))
  end

  it "renders the edit play_back form" do
    render

    assert_select "form[action=?][method=?]", play_back_path(@play_back), "post" do

      assert_select "input[name=?]", "play_back[title]"

      assert_select "input[name=?]", "play_back[url]"

      assert_select "input[name=?]", "play_back[views]"
    end
  end
end
