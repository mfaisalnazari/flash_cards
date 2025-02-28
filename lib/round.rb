class Round
    attr_reader :deck, :turns
    def initialize(deck)
        @deck = deck
        @turns = []
        @currentcard = 0
       
    end

    def current_card
         @deck.cards[(@currentcard)]
    end

    
    def take_turn(guess)
        new_turn = Turn.new(guess,current_card)
        @turns << new_turn
        @currentcard +=1
         new_turn
    end

    def number_correct
        numc = 0
        @turns.each do |turn|
            if turn.correct?
                numc += 1
            end
        end
        numc
    end
    def number_correct_by_category(category)
        numcbc = 0
        @turns.each do |turn|
            if turn.card.category == category && turn.correct?
                numcbc += 1
            end
        end
        numcbc
    end
    def percent_correct
        
        percentage_correct = (number_correct.to_f / @turns.length) * 100
        percentage_correct
    end
    def percent_correct_by_category(category)
        new_cat = @turns.count {|turn|  category == turn.card.category }
        percentage_correct_by_category = (number_correct_by_category(category).to_f / new_cat ) *100
        percentage_correct_by_category
        
    end


    def start
        puts " Welcome! You're playing with #{deck.count} cards."
        "-------------------------------------------------------"
        deck.cards.each do |card|
            puts "This is card number #{@currentcard + 1} out of #{deck.count}."
            puts"Question: #{card.question}"
            user_answer = gets.chomp
            new_turn = take_turn(user_answer)
            new_turn.feedback
         end
         puts "****** Game over! *******"
         puts "You had #{number_correct} correct guesses out of #{deck.count} for a total score of #{percent_correct.round(1)}% "
         new_cat = [] 
         @turns.each do |turn| new_cat << turn.card.category end
         new_cat.uniq.each do |cat|    
            puts "#{cat} - #{percent_correct_by_category(cat)} correct"
         end
    end
end