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
      @request.env["HTTP_REFERER"] = root_path
      @topic_attrs = {title: "test"} 
      @topic = Topic.create @topic_attrs
      @success_attrs = {topic_id: @topic_attrs[:title], sub_topic: {title: "test title", descr: "d"*31 } }
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
          expect { post :create, @success_attrs }.to change{Topic.find_by(title: @topic_attrs[:title]).sub_topics.count}.by(1)
        end
      end

      it "should create topic with current user mail" do
        post :create, @success_attrs
        Topic.last.reload.sub_topics.last.created_by.should eq(@user.mail)
      end
 
      describe "PUT upvote" do
        before do
          post :create, @success_attrs
        end

        it "should increase topics score by 1" do
          expect {put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title}.to change {Topic.last.sub_topics.last.reload.score}.by(1)
        end

        it "should redirect to topic sub topics path" do
          put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title
          response.should redirect_to topic_sub_topics_path
        end

        describe "should set voting values to the current user" do
          before {put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title}
          subject {Topic.last.sub_topics.last.votes.last}
          its(:mail) {should eq @user.mail}
          its(:voting) {should eq 1}
        end

        context "user already voted" do
          before {put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title}

          it "should delete user from votes" do 
            expect {put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title}.to change{Topic.last.sub_topics.last.votes.count}.by(-1) 
          end

          context "user voted before" do 
            context "user vote is 1" do 
              before {topic = Topic.last.sub_topics.last.votes.find_by(mail: @user.mail).set(voting: 1)}
            
              it "should decriminate the score" do
                expect {put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title}.to change{Topic.last.sub_topics.last.score}.by(-1) 
              end
            end

            context "user vote is 0" do 
              before {topic = Topic.last.sub_topics.last.votes.find_by(mail: @user.mail).set(voting: 0)}

              it "should change user vote to 1" do 
                put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title
                Topic.last.sub_topics.last.votes.find_by(mail: @user.mail).voting.should eq 1
              end
              it "should incriminate the score" do
                expect {put :upvote, id: Topic.last.sub_topics.last.id, topic_id: Topic.last.title}.to change{Topic.last.sub_topics.last.score}.by(1) 
              end
            end
            

          end
          
        end

      end
    end

    describe "GET index" do
      it "should not require authentication" do
        sign_out_user
        get :index, @success_attrs
        expect(response).to render_template(:index)
      end

      context "topic not found params" do
        describe "wrong topic params" do
          it "should redirect to home" do
            get :index , {topic_id: "1", sub_topic: {title: "test title", descr: "test descr" } }
            response.should redirect_to root_path 
          end
        end
        describe "wrong sub topic params" do
          it "should redirect to home" do
            get :show , {topic_id: @topic_attrs[:title], id: "3" }
            response.should redirect_to root_path 
          end
        end
      end
    end

  end 
end