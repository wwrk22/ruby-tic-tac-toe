# frozen_string_literal: true

require_relative '../board.rb'

RSpec.describe Board do

  # Suppress print and puts messages
  before :all do
    @stdout = $stdout
    @stderr = $stderr
    $stdout = File.open(File::NULL, 'w')
    $stderr = File.open(File::NULL, 'w')
  end

  describe '#mark' do
    # TO-DO
  end

  describe '#full?' do
    # TO-DO
  end

  describe '#clear_board' do
    let(:game_board) { instance_double(Array) }
    subject(:board) { described_class.new }

    before do
      allow(Array).to receive(:new).and_return(game_board)
      allow(game_board).to receive(:clear)
    end

    it "sends #clear to @board" do
      expect(game_board).to receive(:clear)
      board.clear_board
    end
  end


  describe '#get_board' do
    context "when the board is empty" do
      subject(:empty_board) { described_class.new }
      let(:expected_board) { "[ ][ ][ ]\n[ ][ ][ ]\n[ ][ ][ ]\n" }

      it "returns the empty board" do
        expect(empty_board.get_board).to eq(expected_board)
      end
    end

    context "when the board has markers on it" do
      subject(:marked_board) { described_class.new }
      let(:expected_board) { "[X][O][ ]\n[ ][ ][ ]\n[ ][ ][ ]\n" }
      let(:actual_board) {
        board = Array.new(9)
        board[0] = 'X'
        board[1] = 'O'
        board
      }
      
      before do
        allow(Array).to receive(:new).and_return(actual_board)
      end

      it "returns the correct board" do
        expect(marked_board.get_board).to eq(expected_board)
      end
    end

    context "when the board is full" do
      subject(:full_board) { described_class.new }
      let(:expected_board) { "[O][O][O]\n[O][O][O]\n[O][O][O]\n" }
      let(:actual_board) { %w(O O O O O O O O O) }

      before do
        allow(Array).to receive(:new).and_return(actual_board)
      end

      it "returns the full board" do
        expect(full_board.get_board).to eq(expected_board)
      end
    end
  end


  describe '#check_rows' do
    context "when no rows indicate a winner" do
      context "when no rows have any markers" do
        subject(:empty_board) { described_class.new }

        it "returns nil" do
          expect(empty_board.check_rows).to eq(nil)
        end
      end

      context "when rows have markers" do
        subject(:board_with_markers) { described_class.new }
        let(:actual_board) {
          board = Array.new(9)
          board[0] = 'X'
          board[3] = 'O'
          board
        }

        before do
          allow(Array).to receive(:new).and_return(actual_board)
        end

        it "returns nil" do
          expect(board_with_markers.check_rows).to eq(nil)
        end
      end
    end

    context "when a row indicates a winner" do
      subject(:winning_board) { described_class.new }
      let(:actual_board) {
        board = Array.new(9)
        board[0..2] = ['O', 'O', 'O']
        board
      }

      before do
        allow(Array).to receive(:new).and_return(actual_board)
      end

      it "returns the marker of the winner" do
        expect(winning_board.check_rows).to eq('O')
      end
    end
  end


  describe '#check_columns' do
    context "when no columns indicate a winner" do
      context "when no columns have any markers" do
        subject(:empty_board) { described_class.new }

        it "returns nil" do
          expect(empty_board.check_columns).to eq(nil)
        end
      end

      context "when columns have markers" do
        subject(:board_with_markers) { described_class.new }
        let(:actual_board) {
          board = Array.new(9)
          board[6] = 'X'
          board[2] = 'O'
          board
        }

        before do
          allow(Array).to receive(:new).and_return(actual_board)
        end

        it "returns nil" do
          expect(board_with_markers.check_columns).to eq(nil)
        end
      end
    end

    context "when a column indicates a winner" do
      subject(:winning_board) { described_class.new }
      let(:actual_board) {
        board = Array.new(9)
        board[0] = 'O'
        board[3] = 'O'
        board[6] = 'O'
        board
      }

      before do
        allow(Array).to receive(:new).and_return(actual_board)
      end
      
      it "returns the marker of the winner" do
        expect(winning_board.check_columns).to eq('O')
      end
    end
  end


  describe '#check_diagonals' do
    context "when there is a winner" do
      it "returns the marker of the winner" do

      end
    end

    context "when there is no winner" do
      subject(:no_winner_board) { described_class.new }
      
      context "when the board is empty" do
        it "returns nil" do
          expect(no_winner_board.check_diagonals).to eq(nil)
        end
      end

      context "when the board is not empty" do
        let(:actual_board) {
          board = Array.new(9)
          board[0] = 'O'
          board[4] = 'X'
          board
        }

        before do
          allow(Array).to receive(:new).and_return(actual_board)
        end

        it "returns nil" do
          expect(no_winner_board.check_diagonals).to eq(nil)
        end
      end
    end
  end


  # Reset outputs correctly
  after :all do
    $stdout = @stdout
    $stderr = @stderr
    @stdout = nil
    @stderr = nil
  end

end