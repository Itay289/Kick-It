require 'spec_helper'

describe TopicsController do
  render_views
  describe "POST create" do
    it_behaves_like "authenticated route", [ { verb: :post, action: :create, params: {} } ]
    before :each do
      @success_attrs = { topic: {title: "test", image: "1" } }
      @failure_attrs = {}
    end

    context "User signed in" do
      before do
        @user = sign_in_user
      end

      context "valid attributes" do
        describe "response" do
          before {post :create, @success_attrs}
          subject {response}
          it {should redirect_to topics_path}
        end

        #Alternative way
        #it "should redirect to topics_path" do
          #post :create, @success_attrs
          #response.should redirect_to topics_path
          #Topic.last.created_by.should
        #end

        it "should create a Topic" do
          expect { post :create, @success_attrs }.to change(Topic, :count).by(1)
        end

        describe "created topic attributes" do
          before {post :create, @success_attrs}
          subject {Topic.last}
          its(:created_by) {should eq @user.mail}
          its(:title) {should eq @success_attrs[:topic][:title]}
        end

      end

      context "wrong attributes" do
        it "should raise an errors" do
          expect {
            post :create, @failure_attrs
          }.to raise_error
        end
      end

    end
  end

  describe "GET index" do
    it "should not require authentication" do
      sign_out_user
      get :index 
      expect(response).to render_template(:index)
    end

    #t1 = Topic.create title: "shahaf"
    #t2 = Topic.create title: "itay"
    #rendered.should_contain "shahaf"
  end

end