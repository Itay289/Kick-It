require 'spec_helper'

describe TopicsController do
  render_views
	describe "POST create" do
    before do
      @success_attrs = { topic: {title: "test", image: "1" } }
      @failure_attrs = {}
    end

    context "User signed in" do
      before do
        @mail = "shahaf@ftbpro.com"
        cookies[:mail] = @mail
        User.create mail: @mail
      end

      context "right attributes" do
        it "should redirect to topics_path" do
          post :create, @success_attrs
          response.should redirect_to topics_path
        end
      end

      context "wrong attributes" do
        it "should raise an errors" do
          expect {
            post :create, @failure_attrs
          }.to raise_error
        end
      end
    

      context "with valid information" do

        it "should create a Topic" do
          expect { post :create, @success_attrs }.to change(Topic, :count).by(1)
        end
      end


        it "should create topic with current user mail" do
          post :create, @success_attrs
          Topic.last.created_by.should eq(cookies[:mail])
        end
    	end
    end

  describe "GET index" do
    it "should not require authentication" do
      cookies[:mail] = nil
      get :index 
      expect(response).to render_template(:index)
    end

    #t1 = Topic.create title: "shahaf"
    #t2 = Topic.create title: "itay"
    #rendered.should_contain "shahaf"
  end

end