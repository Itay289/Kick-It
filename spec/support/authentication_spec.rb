shared_examples "authenticated route" do |actions|
  context "User not signed in" do
    before do
      sign_out_user
    end

    actions.each do |action|
      it "should redirect to signin path" do
        send action[:verb], action[:action], action[:params]
        response.should redirect_to signin_path
      end
    end
  end
end

#TODO: Add unauthenticaetd route shared example
