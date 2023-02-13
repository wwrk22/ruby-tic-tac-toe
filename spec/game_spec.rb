# frozen_string_literal: true

require_relative '../game.rb'

RSpec.describe Game do

  # Suppress print and puts messages
  before :all do
    @stdout = $stdout
    @stderr = $stderr
    $stdout = File.open(File::NULL, 'w')
    $stderr = File.open(File::NULL, 'w')
  end

  subject(:game) { described_class.new }
  let(:p1) { instance_double(Player) }
  let(:p2) { instance_double(Player) }

  before do
    game.instance_variable_set(:@p1, p1)
    game.instance_variable_set(:@p2, p2)
  end

  # Script method that calls Player#score and Player#name
  describe '#display_score' do
    before do
      allow(p1).to receive(:name)
      allow(p2).to receive(:name)
      allow(p1).to receive(:score)
      allow(p2).to receive(:score)
    end

    it "sends #name and #score to both players" do
      expect(p1).to receive(:name)
      expect(p2).to receive(:name)
      expect(p1).to receive(:score)
      expect(p2).to receive(:score)
      game.display_score
    end
  end

  # Script method that calls Player#reset_score
  describe '#reset_score' do
    before do
      allow(p1).to receive(:reset_score)
      allow(p2).to receive(:reset_score)
    end

    it "sends #reset_score to both players" do
      expect(p1).to receive(:reset_score)
      expect(p2).to receive(:reset_score)
      game.reset_score
    end
  end

  # ------------------------------------------------------------------------
  # TO-DO: change the method to return 'X', 'O', or nil to indicate game winner
  # or that the game is not over yet.
  # ------------------------------------------------------------------------
  
  # Script method that calls:
  #   Board#check_rows
  #   Board#check_columns
  #   Board#check_diagonals
  describe '#game_over?' do
    let(:board) { instance_double(Board) }

    before do
      allow(board).to receive(:check_rows)
      allow(board).to receive(:check_columns)
      allow(board).to receive(:check_diagonals)
      game.instance_variable_set(:@board, board)
    end

    it "sends all #check_... messages to the board" do
      expect(board).to receive(:check_rows)
      expect(board).to receive(:check_columns)
      expect(board).to receive(:check_diagonals)
      game.game_over?
    end
  end

  # Script method
  # Run test to simulate one turn followed by game over.
  # describe '#start' do
  #   let(:board) { instance_double(Board) }
  #   let(:mark_index) { 0 }

  #   before do
  #     allow(p1).to receive(:make_move).and_return(mark_index)
  #     allow(board).to receive(:mark).with(mark_index)
  #     allow(board).to receive(:get_board)
  #   end

  #   it "runs a new game until game is over" do

  #   end
  # end


  # Reset outputs correctly
  after :all do
    $stdout = @stdout
    $stderr = @stderr
    @stdout = nil
    @stderr = nil
  end

end