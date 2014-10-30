# PUT /topics/id/sub_topics/id/upvote
#

require 'spec_helper'

describe "routing" do
  describe "upvoting for subtopics" do
    it "should route for subtopics" do
      { put: "/topics/1/sub_topics/2/upvote" }.
      should route_to(
        controller: "sub_topics",
        topic_id: "1",
        id: "2",
        action: "upvote"
      )
    end
  end

end
