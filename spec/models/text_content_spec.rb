require 'spec_helper'

describe TextContent do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @text_content = FactoryGirl.create(:text_content)
  end

  it { should validate_presence_of(:identity) }
  it { should validate_uniqueness_of(:identity) }
  it { should validate_presence_of(:title) }

  describe "with_identity"

  describe "welcome"

end
