require 'spec_helper'

describe "text_contents/index.html.slim" do
  before(:each) do
    assign(:text_contents, [
      stub_model(TextContent,
        :identity => "Identity",
        :title => "Title",
        :body => "MyText"
      ),
      stub_model(TextContent,
        :identity => "Identity",
        :title => "Title",
        :body => "MyText"
      )
    ])

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }

    view.stub(:sortable) { '' }
  end

  it "renders a list of text_contents" do
    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Identity".to_s, :count => 2
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Title".to_s, :count => 2
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
