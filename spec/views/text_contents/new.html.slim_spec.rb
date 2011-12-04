require 'spec_helper'

describe "text_contents/new.html.slim" do
  before(:each) do
    assign(:text_content, stub_model(TextContent,
      :identity => "MyString",
      :title => "MyString",
      :body => "MyText"
    ).as_new_record)

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  it "renders new text_content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => text_contents_path, :method => "post" do
      assert_select "input#text_content_identity", :name => "text_content[identity]"
      assert_select "input#text_content_title", :name => "text_content[title]"
      assert_select "textarea#text_content_body", :name => "text_content[body]"
    end
  end
end
