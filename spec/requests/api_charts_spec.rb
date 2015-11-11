require 'rails_helper'

RSpec.describe "API for Charts", type: :request do
  describe "GET /charts" do

    let(:user){ create :user }
    before(:each) do
      Warden.test_mode!
      login_as user, scope: :user
    end

    it "responds to JSON format by default" do
      expect{ get charts_path }.not_to raise_error
      expect(response).to have_http_status(200)
      expect(json["filters"]["message"]).to eq "No data points found for your sensors!"
    end

    it "raises errors when requesting XML format" do
      expect{ get charts_path(format: :xml) }.to raise_error(ActionController::UnknownFormat)
    end

    it "raises errors when requesting other formats" do
      expect{ get charts_path(format: :html) }.to raise_error(ActionController::UnknownFormat)
    end

    context "with Javascript format" do
      it "responds to remote AJAX requests" do
        allow_any_instance_of(ChartsController).to receive(:current_user).and_return user
        expect{ xhr :get, charts_path(format: :js) }.not_to raise_error
        expect(response).to have_http_status(200)
        expect(response.body).to include("No data points found for your sensors!")
      end

      it "does not allow Cross-Origin requests" do
        expect{ get charts_path(format: :js) }.to raise_error(ActionController::InvalidCrossOriginRequest)
      end
    end

    # @see `create_datasets_for` and `chart_data_for` in `ApiHelper` module for RSpec
    it "provides average per minute measurements for the sensors belonging to the current user", slow: true do
      create_datasets_for(user, points: 5)
      get charts_path
      returned = chart_data_for(:minute)
      (1..5).each do |i|
        timestamp = "January 01, 2000 00:#{"%02d" % i}:00 UTC"
        expect(returned[timestamp]).to be_in([nil, i*user.id])
      end
    end

    it "provides average per 5-min measurements for the sensors belonging to the current user", slow: true do
      create_datasets_for(user, points: 4)
      get charts_path
      returned = chart_data_for("5-minute")
      (1..4).each do |i|
        timestamp = "january 01, 2000 00:#{"%02d" % i}:00 utc"
        expect(returned[timestamp]).to be_in([nil, i*user.id*5])
      end
    end

    it "provides average per hour measurements for the sensors belonging to the current user", slow: true do
      create_datasets_for(user, points: 3)
      get charts_path
      returned = chart_data_for("hour")
      (1..3).each do |i|
        timestamp = "january 01, 2000 00:#{"%02d" % i}:00 utc"
        expect(returned[timestamp]).to be_in([nil, i*user.id*60])
      end
    end
  end
end
