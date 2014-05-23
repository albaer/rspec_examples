require_relative "flashcards.rb"


describe "DeckModel" do
  let(:deck) {DeckModel.new}

  describe "#show_random_card" do
    it "returns random card from deck" do
      deck.load_cards_to_deck
      expect(deck.cards).to include(deck.show_random_card)
    end
  end

  describe "#load_cards_to_deck" do
    it "loads cards into deck from file" do
      expect{deck.load_cards_to_deck}.to change{deck.cards.size}.by 38
    end
  end
end

describe "ScoreModel" do
  let(:score) {ScoreModel.new}
  describe "#correct_answer" do
    it "increases correct tally by 1" do
      expect{score.correct_answer}.to change {score.number_correct}.by 1
    end
  end

  describe "#incorrect_answer" do
    it "increases incorrect tally by 1" do
      expect{score.incorrect_answer}.to change {score.number_incorrect}.by 1
    end
  end
end

describe "QuizMasterController" do
  describe "#runner" do
    it "runs the game" do
      pending
    end
  end
end

describe "GameViewer" do
  let(:viewer) {GameViewer.new}
  let(:score) {ScoreModel.new}

  describe "#show_instructions" do
    it "prints instructions to screen" do
      $stdout.should_receive(:puts).with %Q{
    Welcome to the flash card app!
    We will give you the definition you will give the word!
    If you want to quit type 'quit'.
    Anything you type will be recorded and will be keeping score.
    Type 'score' if you want to know your current score.
    }
      viewer.show_instructions
    end
  end

  describe "#show_guess" do
    it "prints 'Guess:'" do
      $stdout.should_receive(:puts).with "Guess:"
      viewer.show_guess
    end
  end

  describe "#show_correct" do
    it "prints 'Correct'" do
      $stdout.should_receive(:puts).with "CORRECT!\n\n"
      viewer.show_correct
    end
  end

  describe "#show_wrong" do
    it "prints 'Wrong'" do
      $stdout.should_receive(:puts).with "WRONG!\n\n"
      viewer.show_wrong
    end
  end

  describe "#score_results" do
    it "prints 'Results'" do
      $stdout.should_receive(:puts).with "CORRECT: #{score.number_correct}\nINCORRECT: #{score.number_incorrect}"
      viewer.score_results(score)
    end
  end
end
