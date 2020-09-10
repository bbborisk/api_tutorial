require 'rails_helper'

describe 'article routes' do
  it 'should rout to articles index' do
    expect(get '/articles').to route_to('articles#index')
  end

  it 'should rout to articles show' do
    expect(get '/articles/1').to route_to('articles#show', id:'1')
  end

  it 'should rout to articles show' do
    expect(get '/articles/2').to route_to('articles#show', id:'2')
  end

it 'should rout to access_tokens destroy action' do
  expect(delete '/logout').to route_to('access_tokens#destroy')
end

end
