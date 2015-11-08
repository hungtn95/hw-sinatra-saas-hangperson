class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @invalid = false
  end
  
  attr_accessor(:word, :guesses, :wrong_guesses, :invalid)

  def guess(guess_letter)
    unless guess_letter.is_a?(String) && !guess_letter.empty? && !(guess_letter =~ /[^a-zA-Z]/)
      raise ArgumentError.new("Guess argument invalid (cannot be nil, empty string or different of string type)")
    end      
    return false if @guesses.include? guess_letter.downcase or @wrong_guesses.include? guess_letter.downcase
    if @word.include? guess_letter.downcase
      @guesses += guess_letter
      @invalid = false
    else 
      @wrong_guesses += guess_letter
      @invalid = true
    end
    true
  end
  def guess_several_letters(guess_letters) 
    guess_letters.split("").each do |i|
      self.guess(i)
    end
  end
  def word_with_guesses
    if @guesses.empty? 
      @word.gsub(/./,"-") 
    else
      @word.gsub(/[^#{@guesses}]/,"-")
    end
  end
  def check_win_or_lose
    return :lose if wrong_guesses.length >= 7
    return :win if self.word_with_guesses == @word 
    :play
  end
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
