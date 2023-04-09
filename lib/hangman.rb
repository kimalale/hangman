require 'json'

#mixin
module BasicSerializable

  #should point to a class; change to a different
  #class (e.g. MessagePack, JSON, YAML) to get a different
  #serialization
  @@serializer = JSON

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end

    @@serializer.dump obj
  end

  def unserialize(string)
    obj = @@serializer.parse(string)
    obj.keys.each do |key|
      instance_variable_set(key, obj[key])
    end
  end
end

module Reuseable
  def generate_random_number(range)
    random_code = Random.new
    random_code.rand(0..range)
  end
end

class Hangman
  include Reuseable
  include BasicSerializable

  attr_accessor  :secret_word, :plays, :guessed_word

  def initialize
    @plays = 8
    @secret_word = random_word
    @guessed_word = @secret_word.split('').map { |letter| letter = '_' if ('a'..'z').include?(letter) }.join('')
  end

  private

  def open_file
    content_word = File.readlines('google-10000-english-no-swears.txt').map { |line| line.chomp }
    content_word.select { |word| (5..12).include?(word.length) }
  end

  def random_word
    open_file[generate_random_number(open_file.length)]
  end

  public

  def check_word(guess_letter)
    switched = false
    guess_letter = guess_letter.downcase
    @secret_word.split('').each_with_index do |letter, index|
      if letter == guess_letter
        @guessed_word[index] = letter
        switched = true
      end
    end

    @plays -= 1 unless switched

    switched
  end

  def serialize
  obj = {}
  instance_variables.map do |var|
    obj[var] = instance_variable_get(var)
  end

  @@serializer.dump obj
end

def unserialize(string)
  obj = @@serializer.parse(string)
  obj.keys.each do |key|
    instance_variable_set(key, obj[key])
  end
end

  def check_win
    return true if @guessed_word == @secret_word
  end
end


hangman = Hangman.new
puts 'Welcome Hangman'
puts "1. New game \n2. Open saved game"

if gets.chomp == '2'
  # Unserialize the JSON into an object
  json = File.read("./saved/hangman.json")
  hangman.unserialize (json)
end

until hangman.plays == 0
  puts "\n\nChances: #{hangman.plays}\n\n"

  puts "The word: #{hangman.guessed_word}"
  break if hangman.check_win
  print 'Enter a letter to guess or [0] to save: '
  guess_letter = gets.chomp
  if guess_letter == '0'

    File.open("./saved/hangman.json", "w") do |f|
      f.write(hangman.serialize)
    end
  end
  hangman.check_word(guess_letter)


end

puts hangman.check_win ? "\n\nYou won!" : "\n\nYou ran out of moves!\nThe word was #{hangman.secret_word}"

# for a in 'a'..'z'
#   puts hangman.guessed_word
#   hangman.check_word(a)
# end
