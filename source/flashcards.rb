class CardModel
  attr_reader :definition, :answer

  def initialize(args)
    @definition = args[:definition] || "What's the object-oriented way to become wealthy?"
    @answer = args[:answer] || "Inheritance"
  end
end

class DeckModel
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def show_random_card
    cards.sample
  end

  def load_cards_to_deck
    first_read = []
    File.open("flashcard_samples.txt", "r") do |file|
      file.each_line do |line|
        first_read << line.chomp unless line == "\n"
      end
    end
    first_read.each_slice(2) do |slice|
      cards << CardModel.new({:definition=> slice[0], :answer => slice[1]})
    end
  end
end

class ScoreModel
  attr_accessor :number_correct, :number_incorrect
  def initialize
    @number_correct = 0
    @number_incorrect = 0
  end

  def correct_answer
    self.number_correct += 1
  end

  def incorrect_answer
    self.number_incorrect += 1
  end
end

class QuizMasterController
  attr_reader :deck, :viewer, :scoreboard

  def initialize
    @deck = DeckModel.new
    @viewer = GameViewer.new
    @scoreboard = ScoreModel.new
    deck.load_cards_to_deck
  end

  def runner
    question = deck.show_random_card

    viewer.show_instructions
    while true
      puts question.definition
      viewer.show_guess
      user_input = gets.chomp
      case user_input
      when question.answer
        scoreboard.correct_answer
        viewer.show_correct
        question = deck.show_random_card
      when "score"
        viewer.score_results(scoreboard)
      when "quit"
        viewer.score_results(scoreboard)
        exec( "sl" )
        break
      else
        scoreboard.incorrect_answer
        viewer.show_wrong
      end
    end
  end
end

class GameViewer

  def show_instructions
    puts %Q{
    Welcome to the flash card app!
    We will give you the definition you will give the word!
    If you want to quit type 'quit'.
    Anything you type will be recorded and will be keeping score.
    Type 'score' if you want to know your current score.
    }
  end

  def show_guess
    puts "Guess:"
  end

  def show_correct
    puts "CORRECT!\n\n"
  end

  def show_wrong
    puts "WRONG!\n\n"
  end

  def score_results(score_class)
    puts "CORRECT: #{score_class.number_correct}\nINCORRECT: #{score_class.number_incorrect}"
  end
end

#QuizMasterController.new.runner
