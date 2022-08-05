# frozen_string_literal: true

require 'open-uri'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      hostname = 'https://rails-collective-blog-ru.hexlet.app'
      get_path = '/users/sign_up'
      post_path = '/users'
      response = sign_up_page(URI.join(hostname, get_path))
      token = parser(response.body)
      cookie = response.response['set-cookie'].split('; ')[0]
      params = {
        email: email,
        password: password,
        password_confirmation: password,
        authenticity_token: token
      }

      sign_up(hostname, post_path, params, cookie)
    end

    def sign_up_page(uri)
      http = setup_ssl(uri)
      request = Net::HTTP::Get.new uri
      http.request request
    end

    def sign_up(hostname, post_path, params, cookie)
      uri = URI.join(hostname, post_path)
      request = Net::HTTP::Post.new uri
      http = setup_ssl(uri)

      request.body = URI.encode_www_form(params)
      request['Cookie'] = cookie

      http.request request
    end

    def setup_ssl(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def parser(page)
      html = Nokogiri::HTML(page)
      token_tag = html.at('input[@name="authenticity_token"]')
      token_tag['value']
    end
    # END
  end
end