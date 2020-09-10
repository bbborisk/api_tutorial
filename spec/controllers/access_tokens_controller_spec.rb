require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  describe "POST #create" do
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

      let(:user_data)do
        {login: 'jsmit',
        url: 'http://sth.com',
       avatar_url:'http://something.com/avatar',
        name: 'John Smith'}
      end
      before do
        allow_any_instance_of(Octokit::Client).to receive(:exchange_code_for_token).and_return('validaccesstoken')
        allow_any_instance_of(Octokit::Client).to receive(:user).and_return(user_data)
      end

      subject {post :create, params:{code: 'validcode'}}

      it 'should return 201 code' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'should return propper json content' do
        expect{subject}.to change{User.count}.by(1)
        user = User.find_by(login: 'jsmit')
        expect(json_data['attributes']).to eq(
          {'token' => user.access_token.token}
        )
      end

    end

  end

  describe "DELETE #destroy" do
    shared_examples_for 'forbidden_requests' do
      let(:authorization_error) do
        {
          "status" => "403",
          "source" => { "pointer" => "headers/authorization" },
          "title" =>  "Not authorized",
          "detail" => "You have no right to access this resource."
        }
    end
    it "should return 403 status" do
      subject
      expect(response).to have_http_status(:forbidden)
    end
    it "should return propper error json" do
      subject
      expect(json['error']).to eq(authorization_error)
    end
  end



    context 'when invalid reqest' do
      subject {delete :destroy}

      it_behaves_like 'forbidden_requests'

    end

    context "when valid reqest" do

    end
  end
end
