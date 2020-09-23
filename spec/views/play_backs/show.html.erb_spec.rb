require 'rails_helper'

RSpec.describe "play_backs/show", type: :view do
  before(:each) do
    @play_back = assign(:play_back, PlayBack.create!(
      title: "Title",
      url: "Url",
      views: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/2/)
  end
end
