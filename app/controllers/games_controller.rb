require "json"
require "open-uri"
class GamesController < ApplicationController

  

  def new
    @letters = []
    9.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    
    # the word is build out the grid

    @included =included?(@letters, @word)
    # is an english word
    @english =isEnglish?(@word) 
    
    
  end

  def isEnglish?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    return user['found']
  end

  def included?(lettersArray, word)
    word.chars.all? do |letter|
      lettersArray.chars.count(letter) >= word.chars.count(letter)
    end

  end


end


