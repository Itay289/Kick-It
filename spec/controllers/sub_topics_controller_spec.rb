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
        

          # context "with valid information" do

          # #   it "should create a Topic" do
          # #     @topic = Topic.find_by(title: "test")
          # #     expect { post :create, @success_attrs }.to change(@topic.sub_topics, :count).by(1)
          # #   end
          # # end

          it "should create topic with current user mail" do
            post :create, @success_attrs
            Topic.last.sub_topics.last.created_by.should eq(cookies[:mail])
          end

        context "voting" do
          it "should change the score" do
            @topic = Topic.last
            post :create, @success_attrs
            byebug
            @sub_topic = @topic.sub_topics.last 
            a = {sub_topic_id: @sun_topic_id, count_action: :like}
            expect { get :change_score, a  }.to change(@sub_topic.score).by(1)
          end  
        end
      end

    describe "GET index" do
      it "should not require authentication" do
        cookies[:mail] = nil
        get :index, @success_attrs
        expect(response).to render_template(:index)
      end
    end
  end 
end