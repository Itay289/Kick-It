require 'spec_helper'

describe "topics view" do
  describe "index" do
    before do
      Topic.create :title "not deleted"
      Topic.create :title "deleted"
    end

    it "should show only not deleted topics" do
      render

      rendered.should contain("not deleted")
      rendered.should contain("deleted")
     
    end
  end

end