require 'spec_helper'

describe SubTopicsController do
  render_views
  
  describe "topic create" do
    before do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      @topic_attrs = {title: "test", image: "1" } 
      Topic.create @topic_attrs
      @success_attrs = {topic_id: "test", sub_topic: {title: "test title", desc: "test desc" } }
      @failure_attrs = {}
    end

      context "User signed in" do
        before do
          @mail = "shahaf@ftbpro.com"
          cookies[:mail] = @mail
          User.create mail: @mail
        end

          context "right attributes" do
            it "should redirect to topics_sub_topics_path" do
              byebug
              post :create, @success_attrs
              response.should redirect_to topic_sub_topics_path
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
              @topic = Topic.find_by(title: "test")
              expect { post :create, @success_attrs }.to change(@topic.sub_topics, :count).by(1)
            end
          end

          it "should create topic with current user mail" do
            post :create, @success_attrs
            Topic.last.created_by.should eq(cookies[:mail])
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
end