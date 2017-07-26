require 'yaml'
class Hangman
	attr_accessor :history
	def initialize
		@incorrect_characters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
		"p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

		@secret_word = get_secret_word

		@hidden = @secret_word.gsub(/./, "_ ")

		@temp_secret_word = @secret_word.clone

		@guesses_left = 6

		@game_over = false

	end

	def get_secret_word
		dictionary = File.readlines("5desk.txt")
		size = dictionary.length
		word = dictionary[rand(size) + 1] until word.to_s.length > 4 && word.to_s.length < 13
		return word.downcase.to_s
	end

	def guess_count_down(guesses)
		guesses -= 1
		return guesses
	end

	def game_start
		puts "Welcome to Hangman"
		
		game_loop
		
	end

	def game_loop
		puts @hidden
		while @guesses_left > 0 && @game_over == false
			
				puts "Enter a letter or pause to stop game"
				guess = gets.chomp
				
					if @secret_word.include?(guess) == true
						puts "Correct!"
						@incorrect_characters.each do |character|
							if character == guess
								@incorrect_characters.delete(character)
							end
						end
						guess = guess
					else
						puts "Incorrect!"
						@guesses_left = guess_count_down(@guesses_left)
						if @guesses_left > 0
							puts "You have #{@guesses_left} incorrect guess(s) left"
						else
							puts "GAME OVER!"
							puts @secret_word
						end
					end

					@incorrect_characters.each do |character|
						@temp_secret_word.gsub!(character, "_ ")
					end

					if @temp_secret_word.include?("_") == true
						puts @temp_secret_word
						@game_over = false
					else
						puts @temp_secret_word
						puts "CONGRATS, YOU WIN!"
						@game_over = true
					end

					@temp_secret_word = @secret_word.clone
				

		end
	end

	def save_game
		File.open("hangman.yml", "w") { |f| YAML.dump([] << self, f) }
		exit
	end

	def load_game
		begin
			yaml = YAML.load_file("hangman.yml")
			@history = yaml[0].history
		rescue
			@history = []
		end
	end
end

hangman = Hangman.new
hangman.game_start





