require 'spec_helper'

describe "pages/index" do
  before(:each) do
    assign(:pages, [
      stub_model(Page,
        :title => "Title",
        :content => "Content"
      ),
      stub_model(Page,
        :title => "Title",
        :content => "Content"
      )
    ])
  end

  it "renders a list of pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title", :count => 2
    assert_select "tr>td", :text => "Content", :count => 2
  end
end
