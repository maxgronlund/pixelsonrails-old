require 'spec_helper'

describe "text_contents/show.html.slim" do
  before(:each) do
    @text_content = assign(:text_content, stub_model(TextContent,
      :identity => "Identity",
      :title => "Title",
      :body => "MyText"
    ))

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Identity/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
