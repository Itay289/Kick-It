require 'spec_helper'

describe SessionsHelper, type: :controller do

  controller do
    include SessionsHelper
    before_filter :signed_in_user, only: [:index]
    def index
      render nothing: true
    end
  end

  context "User signed in" do
    before do
      sign_in_user
    end

    it "should return 200" do
      get :index
      response.should be_ok
    end

  end
  context "User not signed in" do
    before do
      sign_out_user
    end

    context "right attributes" do
      it "should redirect to sign_in path" do
        get :index
        response.should redirect_to signin_path
      end
    end
  end

end

