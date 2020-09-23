require "rails_helper"

RSpec.describe PlayBacksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/play_backs").to route_to("play_backs#index")
    end

    it "routes to #new" do
      expect(get: "/play_backs/new").to route_to("play_backs#new")
    end

    it "routes to #show" do
      expect(get: "/play_backs/1").to route_to("play_backs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/play_backs/1/edit").to route_to("play_backs#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/play_backs").to route_to("play_backs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/play_backs/1").to route_to("play_backs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/play_backs/1").to route_to("play_backs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/play_backs/1").to route_to("play_backs#destroy", id: "1")
    end
  end
end
