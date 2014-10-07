require 'spec_helper'

describe SubTopicsController do
  render_views
  it_behaves_like "authenticated route", [
    {
      verb: :post,
      action: :create,
      params: {topic_id: "1"}
    },
    {
      verb: :delete, 
      action: :destroy,
      params: {topic_id: "1", id: "1"}
    },
    {
      verb: :put,
      action: :upvote,
      params: {topic_id: "1", id: "1"}
    }

  ] 


  describe "topic create" do
    before do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      @topic_attrs = {title: "test", image: "1" } 
      @topic = Topic.create @topic_attrs
      @success_attrs = {topic_id: @topic_attrs[:title], sub_topic: {title: "test title", desc: "test desc" } }
      @failure_attrs = {}
    end

    context "User signed in" do
      before do
        @user = sign_in_user
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


      context "with valid information" do

        it "should create a Topic" do
          expect { post :create, @success_attrs }.to change{Topic.find_by(title: "test").sub_topics.count}.by(1)
        end
      end

      it "should create topic with current user mail" do
        post :create, @success_attrs
        Topic.last.sub_topics.last.created_by.should eq(cookies[:mail])
      end

      describe "PUT upvote" do
        before do
          @sub_topic = SubTopic.new
          @topic.sub_topics << @sub_topic
          @topic.save
        end

        it "should require authentcation" do


        end

        it "should increase topics score by 1" do
          expect {put :upvote, id: @sub_topic.id, topic_id: @topic.title}.to change {@sub_topic.reload.score}.by(1)
        end

        it "should redirect to topic sub topics path" do
          put :upvote, id: @sub_topic.id, topic_id: @topic.title
          response.should redirect_to topic_sub_topics_path
        end

      end
    end

    describe "GET index" do
      it "should not require authentication" do
        sign_out_user
        get :index, @success_attrs
        expect(response).to render_template(:index)
      end
    end
  end 
end