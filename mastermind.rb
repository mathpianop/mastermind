COLORS = %w(red yellow green blue purple black)

class Codemaker
    attr_reader :name, :code

    def initialize(player = "computer", name = "Computer")
        @name = name
        if player == "human"
            #add this later
        else
           @code = [COLORS[rand(6)], 
                    COLORS[rand(6)], 
                    COLORS[rand(6)], 
                    COLORS[rand(6)]] 
        end
    end

    def give_feedback(guess, guess_number)
        matches = {"red" => 0, "yellow" => 0, "green" => 0, 
                    "blue" => 0, "purple" => 0, "black" =>0}
        positions_matched = []
        matched_wrong_pos = []
        feedback = {colored: 0, white: 0}

        guess.each_with_index do |color, index|
            if @code[index] == color
                feedback[:colored] += 1
                matches[color] += 1
                positions_matched.push(index)
            end
        end
                
        guess.each_with_index do |color, index|
            if @code.include?(color) && 
                !matched_wrong_pos.include?(color) && 
                !positions_matched.include?(index)
                then
                x = ([@code.count(color), guess.count(color)].min - matches[color])
                feedback[:white] += x
                matched_wrong_pos.push(color)
            end
        end
       
        puts "Feedback ##{guess_number}: colored(#{feedback[:colored]}), white(#{feedback[:white]})"
        
    end

    def guess_correct?(guess)
        guess == @code
    end

    def reveal_code
        @code
    end

end


class Codebreaker
    
    def initialize
        #do nothing for right now
    end

    def submit_guess(guess_number)
        puts "Enter four colors, one at a time:"
        guess = []
        guess_string = "Code guess ##{guess_number}: ["
        i = 0
        while i < 4
        input_color = gets.chomp.downcase
            if !COLORS.include?(input_color)
               puts "Please enter Red, Yellow, Green, Blue, Purple, or Black"
               redo
            else
                guess.push(input_color)
                i == 3 ? guess_string += "#{input_color}]" : guess_string += "#{input_color}, "
                puts "#{guess_string}"
            end
            i += 1
        end
        return guess
    end
end

computer = Codemaker.new

puts "What is your name?"

player = Codebreaker.new

puts "#{computer.name} has created a four-color code \
with red, yellow, green, blue, purple, or black. \
You get 12 guesses to break the code. \
Enter your first guess!"

i = 0
while i < 12 do
    guess = player.submit_guess(i+1)
    computer.give_feedback(guess, i+1)
    

    if computer.guess_correct?(guess)
        puts "You did it! The code is #{computer.reveal_code}"
        break
    end

    if i == 11 && !computer.guess_correct?(guess)
        puts "Close, but no cigar! The code was #{computer.reveal_code}"
    end
    i += 1
end




