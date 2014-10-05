require 'spec_helper'

describe CommentsController do
	describe "POST create" do
		context "User not signed in" do
			before do
				cookies["mail"] = nil
			end
			it "should vsvdsv" do
				true.should be_true
			end
		end
	end

end