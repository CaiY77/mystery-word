class Word
  attr_reader :word

  def initialize(word)
    @word = word.downcase.split("").map{|letter| [letter,false]}
  end

  def guess?(letter)
    changed = false
    @word.each do |letter_bool|
      if letter_bool[0] == letter
        letter_bool[1] = true
        changed=true
      end
    end
    changed
  end

  def guessed_all_correct?
    @word.each do |letter_bool|
      if letter_bool[1] == false
        return false
      end
    end
    return true
  end

  def output_word
    output = ""
    @word.each do |letter_bool|
      if letter_bool[1] == true
        output += letter_bool[0] + " "
      else
        output += "_ "
      end
    end
    print output
  end

  def self.is_letter?(character)
  end
end

class MysteryWordGame

  def initialize
    ask_for_word
  end

  def ask_for_word
    puts "Gimme a word"
    word = gets.chomp
    @secret_word = Word.new(word)
    @lives = 3
    game_loop
  end

  # Run the game loop, which continues until the player wins or loses.
  def game_loop

    while @secret_word.guessed_all_correct? == false && @lives > 0

      puts "Guess a letter: "
      @secret_word.output_word
      letter = gets.chomp

      while letter.length != 1 || letter.match(/[0-9]/)
        puts "Invalid Input"
        puts "Try Again: "
        @secret_word.output_word
        letter = gets.chomp
      end


      if @secret_word.guess?(letter)
        puts "#{letter} exist"
      else
        @lives -= 1;
        puts "#{letter} does not exist"
        puts "You have #{@lives} left"

        if @lives == 0
          puts "You lose"
          return
        end

      end

    end # while loop

    @secret_word.output_word
    puts "\nFinally, You win!"
  end
end

game = MysteryWordGame.new
# game.ask_for_word
