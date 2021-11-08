require 'json'
require 'open-uri'
require 'nokogiri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word].upcase
    @array = params[:letters_array]
    if included?(@word, @array) && valid?(@word)
      @message = "Congratulations! #{@word} is included in #{@array} and it's a valid word"
    elsif included?(@word, @array) && !valid?(@word)
      @message = "Sorry, #{@word} is included in #{@array} but isn't valid"
    else
      @message = "Sorry, but #{@word} is not included in #{@array}"
    end
  end
end

def included?(word, array)
  word.split('').all? { |letter| array.include?(letter) }
end

def valid?(word_to_check)
  url = "https://wagon-dictionary.herokuapp.com/#{word_to_check}"
  JSON.parse(open(url).read)['found']
end
