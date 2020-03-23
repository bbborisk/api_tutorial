require 'rails_helper'

describe ArticlesController do

  describe '#index' do

    it 'should return success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should return propper response' do

      create_list :article, 2

      get :index
      json = JSON.parse(response.body)
      pp json
      json_data = json['data']
      expect(json_data.length).to eq(2)
      expect(json_data[0]['attributes']).to eq({"title" => "MyString 1",
                                                "content" => "MyText 1",
                                                "slug" => "my-String-1"})

    end

  end

end
