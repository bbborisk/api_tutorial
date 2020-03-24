require 'rails_helper'

describe ArticlesController do

  describe '#index' do
    subject {get :index}
    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return propper response' do

      create_list :article, 2

      subject
      # Next two lines are covered with json_api_helper defined in support folder
      # json = JSON.parse(response.body)next
      # json_data = json['data']
      expect(json_data.length).to eq(2)
      Article.recent.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
                                            "title" => article.title,
                                            "content" => article.content,
                                            "slug" => article.slug})
      end

    end

    it 'should return in FILO order' do
      old_article = create :article
      new_article = create :article

      subject

      expect(json_data.first['id']).to eq(new_article.id.to_s)
      expect(json_data.last['id']).to eq(old_article.id.to_s)
    end

  end

end
