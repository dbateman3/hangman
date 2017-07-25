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

incorrect_characters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
"p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

secret_word = get_secret_word

hidden = secret_word.gsub(/./, "_ ")

puts hidden

temp_secret_word = secret_word.clone

guesses_left = 6

game_over = false

while guesses_left > 0 && game_over == false
	
		puts "Enter a letter:"
		guess = gets.chomp

		if secret_word.include?(guess) == true
			puts "Correct!"
			incorrect_characters.each do |character|
				if character == guess
					incorrect_characters.delete(character)
				end
			end
			guess = guess
		else
			puts "Incorrect!"
			guesses_left = guess_count_down(guesses_left)
			if guesses_left > 0
				puts "You have #{guesses_left} incorrect guess(s) left"
			else
				puts "GAME OVER!"
			end
		end

		incorrect_characters.each do |character|
			temp_secret_word.gsub!(character, "_ ")
		end

		if temp_secret_word.include?("_") == true
			puts temp_secret_word
			game_over = false
		else
			puts temp_secret_word
			puts "CONGRATS, YOU WIN!"
			game_over = true
		end

		temp_secret_word = secret_word.clone
end