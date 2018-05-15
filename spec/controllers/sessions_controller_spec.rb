require 'rails_helper'

describe SessionsController, type: :controller do

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe "#create" do

    it "should redirect the user to the root url" do
      post :create, params: { provider: :facebook }
      expect(response).to redirect_to root_url
    end

    it "should successfully create a user" do
      expect{ 
        post :create, params: { provider: :facebook }
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      expect(session[:user_id]).to be_nil
      post :create, params: { provider: :facebook }
      expect(session[:user_id]).not_to be_nil
    end

  end

  describe "#destroy" do
    before do
      post :create, params: { provider: :facebook }
    end

    it "should clear the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "should redirect to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end

  end

end

