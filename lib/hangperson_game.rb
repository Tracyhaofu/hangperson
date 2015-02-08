class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  attr_accessor :word , :guesses, :wrong_guesses 

  def initialize(new_word)
    @word = new_word.downcase 
    @guesses = '' 
    @wrong_guesses= ''
  end   
  
  def guess(new_guess)
      
     if new_guess == '' or new_guess =='%' or new_guess == nil or !/[a-zA-z]/.match(new_guess.to_s[0])  
         raise ArgumentError
     end 
     !new_guess.downcase
     if (@guesses + @wrong_guesses).include?(new_guess) 
         return false  
     elsif @word.include?(new_guess)  
         @guesses +=new_guess 
     else 
         @wrong_guesses +=new_guess
     end 
     true   
  end 

  def word_with_guesses 
     sofar = '' 
     @word.chars do |letter| 
        if @guesses.include?(letter) 
            sofar += letter 
        else 
            sofar += '-' 
        end 
     end 
     return sofar 
  end 

  def check_win_or_lose 
      
      if @wrong_guesses.length >= 7 
          return :lose 
      end 
       @word.chars do |letter| 
        if !@guesses.include?(letter) 
          return :play 
        end 
       end 
       return :win  
  end 

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
