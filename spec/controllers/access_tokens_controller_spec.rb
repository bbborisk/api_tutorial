require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  describe "#create" do
    shared_examples_for "unauthorized_requests" do
      let(:error) do
        {
          "status" => "401",
          "source" => { "pointer" => "/code" },
          "title" =>  "Invalid code",
          "detail" => "You must provide valid code"
        }

      end
      it "should return 401 status" do
        subject
        expect(response).to have_http_status(401)
      end
      it "should return propper error msg " do
        subject
        expect(json['errors']).to include(error)
      end
    end

    context "when no code provided" do
      subject{ post :create }
      it_behaves_like "unauthorized_requests"
    end

    context "when invalid code provided" do
      let(:github_errors) {double("Sawyer::Resource", error: "bad_verification")}
      before do
        allow_any_instance_of(Octokit::Client).to receive(:exchange_code_for_token).and_return(github_errors)
      end

      subject{ post :create, params: { code: 'invalid_code'}}
      it_behaves_like "unauthorized_requests"
    end
    context "when succesfull request" do

    end

  end
end
