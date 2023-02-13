# frozen_string_literal: true

require_relative '../game.rb'

RSpec.describe Game do

  # Suppress print and puts messages
  # before :all do
  #   @stdout = $stdout
  #   @stderr = $stderr
  #   $stdout = File.open(File::NULL, 'w')
  #   $stderr = File.open(File::NULL, 'w')
  # end

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

  # Script method that calls:
  #   Board#check_rows
  #   Board#check_columns
  #   Board#check_diagonals
  describe '#get_winner' do
    context "when a winner exists in a row" do
      let(:winning_row_board) {
        instance_double(
          Board,
          check_rows: 'X',
          check_columns: nil,
          check_diagonals: nil
        )
      }

      it "returns the winner marker" do
        game.instance_variable_set(:@board, winning_row_board)
        expect(game.get_winner).to eq('X')
      end

      context "when a winner exists in a column" do
        let(:winning_row_col_board) {
          instance_double(
            Board,
            check_rows: 'X',
            check_columns: 'O',
            check_diagonals: nil
          )
        }

        it "returns the row winner marker" do
          game.instance_variable_set(:@board, winning_row_col_board)
          expect(game.get_winner).to eq('X')  
        end
      end
    end

    context "when no winner exists" do
      let(:no_winner_board) {
        instance_double(
          Board,
          check_rows: nil,
          check_columns: nil,
          check_diagonals: nil
        )
      }

      it "returns nil" do
        game.instance_variable_set(:@board, no_winner_board)
        expect(game.get_winner).to eq(nil)
      end
    end
  end

  # Script method
  describe '#play_turn' do
    let(:p1) { instance_double(Player, marker: 'O') }
    let(:board) { instance_double(Board) }

    before do
      allow(p1).to receive(:make_move).and_return(0)
      allow(board).to receive(:mark).with(0, 'O').and_return(true)
      allow(board).to receive(:get_board)
      allow(game).to receive(:get_winner).and_return('O')
      game.instance_variable_set(:@board, board)
    end

    it "runs a new game until game is over" do
      expect(p1).to receive(:make_move)
      expect(board).to receive(:mark)
      expect(board).to receive(:get_board)
      expect(game).to receive(:get_winner)
      game.play_turn(p1)
    end
  end

  # Script method
  describe '#start' do
    context "when the next turn ends the game" do
      before do
        allow(game).to receive(:play_turn).and_return('X')
      end

      it "plays one turn" do
        expect(game).to receive(:play_turn).once
        game.start
      end
    end

    context "when the next two turns end the game" do
      before do
        allow(game).to receive(:play_turn).and_return(nil, 'X')
      end

      it "plays two turns" do
        expect(game).to receive(:play_turn).twice
        game.start
      end
    end
  end


  # Reset outputs correctly
  # after :all do
  #   $stdout = @stdout
  #   $stderr = @stderr
  #   @stdout = nil
  #   @stderr = nil
  # end

end