# require 'json'
# require 'net/http'
# require 'uri'
# require 'openssl'
# require 'base64'
class HomeController < ApplicationController
  def index
    @response = HTTParty.get('http://127.0.0.1:3000/students')
    @result = JSON.parse(@response.body)
  end

  def new_student
  end

  def create_student

    payload = params["student"]

    @result = HTTParty.post('http://127.0.0.1:3000/students',
    :body => payload.to_json,
    :headers => {
                  'Content-type' => "application/json",
                  'Accept' => 'application/json'
    } )
    redirect_to '/home/index'
  end

  # def delete_student
  #   puts "deleted"
  # end
  def edit_student

    @result = HTTParty.get("http://127.0.0.1:3000/students/#{params['id'].to_i}",
    :headers => {
                  'Content-type' => "application/json",
                  'Accept' => 'application/json'
    } )
    @student = @result.parsed_response
    render 'edit'
  end

  def update_student

    payload = params["student"]

    @result = HTTParty.put("http://127.0.0.1:3000/students/#{params['id'].to_i}",
    :body => payload.to_json,
    :headers => {
                  'Content-type' => "application/json",
                  'Accept' => 'application/json'
    } )
    redirect_to '/home/index'
  end

  def delete_student
    #raise params['id'].inspect
    #payload = params["student"]

    @result = HTTParty.delete("http://127.0.0.1:3000/students/#{params['id'].to_i}",
    :headers => {
                  'Content-type' => "application/json",
                  'Accept' => 'application/json'
    } )
    redirect_to '/home/index'
  end
end

