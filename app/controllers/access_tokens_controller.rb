class AccessTokensController < ApplicationController
  rescue_from UserAuthenticator::AuthenticationError, with: :authentication_error

  def create
    authenticator = UserAuthenticator.new(params[:code])
    authenticator.perform
    render json:authenticator.access_token {}, status: :created
  end

  def nothing_to_do
  end

  def destroy
  end

  private

  def authentication_error
    error = {
      "status" => "401",
      "source" => { "pointer" => "/code" },
      "title" =>  "Invalid code",
      "detail" => "You must provide valid code"
    }
    render json:{"errors":[ error ]}, status: 401
  end
end
