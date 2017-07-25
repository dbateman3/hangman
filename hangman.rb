def get_secret_word
	dictionary = File.readlines("5desk.txt")
	size = dictionary.length
	word = dictionary[rand(size) + 1] until word.to_s.length > 4 && word.to_s.length < 13
	return word.downcase.to_s
end

def guess_count_down(guesses)
	guess_count = guesses - 1
	puts "You have #{guess_count} incorrect guesses left"
	return guess_count
end

incorrect_characters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
"p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

secret_word = get_secret_word

puts secret_word

temp_secret_word = secret_word

puts "Enter a letter:"
guess = gets.chomp

	if secret_word.include?(guess) == true
		puts "Correct!"
		incorrect_characters.each do |character|
			if character == guess
				incorrect_characters.delete(character)
			end
		end
	end

	incorrect_characters.each do |character|
		temp_secret_word.gsub!(character, "_ ")
	end

	puts temp_secret_word

	temp_secret_word = secret_word