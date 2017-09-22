class GoogleDomainsController < ApplicationController
  OOB_URI = "http://localhost:3000/oauth2callback"
  APPLICATION_NAME = "Movidhdkh"
  CLIENT_SECRETS_PATH = "lib/google_domain/client_secret.json"
  CREDENTIALS_PATH = File.join "lib/google_domain/", ".credentials", "google_domain.yaml"
  SCOPE = ["https://www.googleapis.com/auth/drive",
          "https://www.googleapis.com/auth/plus.me",
          "https://www.googleapis.com/auth/plus.media.upload",
          "https://www.googleapis.com/auth/plus.stream.write",
          "https://www.googleapis.com/auth/userinfo.profile"]

  def index
    service = Google::Apis::PlusDomainsV1::PlusDomainsService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize
    # service = Google::Apis::DriveV2::DriveService.new
    # service.client_options.application_name = APPLICATION_NAME
    # service.authorization = authorize
    binding.pry
  end

  def update
    client_id = Google::Auth::ClientId.from_file CLIENT_SECRETS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: CREDENTIALS_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    code = params[:code]
    credentials = authorizer.get_and_store_credentials_from_code user_id: user_id, code: code, base_url: OOB_URI
    redirect_to google_domains_path
  end

  private
  def authorize
    FileUtils.mkdir_p File.dirname(CREDENTIALS_PATH)

    client_id = Google::Auth::ClientId.from_file CLIENT_SECRETS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: CREDENTIALS_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      redirect_to url
    end
    credentials
  end
end
