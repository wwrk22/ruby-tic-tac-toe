# frozen_string_literal: true

require_relative "../player.rb"

RSpec.describe Player do
  
  # Suppress print and puts messages
  before :all do
    @stdout = $stdout
    @stderr = $stderr
    $stdout = File.open(File::NULL, 'w')
    $stderr = File.open(File::NULL, 'w')
  end

  describe "#initialize" do

    context "when an invalid marker is given" do
      let(:invalid_marker) { 'A' }

      it "raises an ArgumentError" do
        expect {
          described_class.new('Foo', invalid_marker)
        }.to raise_error(ArgumentError)
      end
    end

    context "when a valid marker is given" do
      it "does not raise an ArgumentError" do
        expect {
          described_class.new('Foo', described_class.o_marker)
        }.not_to raise_error
      end
    end

  end


  describe "#make_move" do

    let(:name) { 'Foo' }
    subject(:player) { described_class.new(name, described_class.o_marker) }
    let(:valid_input) { 0 }
    let(:prompt) { "#{name}, make a move. Choose from 0 to 8: " }

    context "when given a valid input" do

      before do # Implicitly same as `before :each do`
        allow(player).to receive(:gets).and_return(valid_input.to_s)
      end

      it "asks for input once" do
        expect(player).to receive(:print).with(prompt).once
        player.make_move
      end

      it "returns the valid input" do
        move = player.make_move
        expect(move).to eq(valid_input)
      end
    end

    context "when given an invalid input then a valid input" do
      let(:invalid_input) { 22 }

      before do 
        allow(player).to receive(:gets).and_return(
          invalid_input.to_s,
          valid_input.to_s
        )
      end

      it "asks for input twice" do
        expect(player).to receive(:print).with(prompt).twice
        player.make_move
      end

      it "returns the valid input" do
        move = player.make_move
        expect(move).to eq(valid_input)
      end
    end

  end


  describe "#add_one_to_score" do
    subject(:player) { described_class.new('Foo', 'O') }

    context "when score is the initial value of zero" do
      it "returns one" do
        player.add_one_to_score
        expect(player.score).to eq(1)
      end
    end
  end

  
  describe "#reset_score" do
    subject(:player) { described_class.new('Foo', 'O') }

    context "when score is one" do
      it "returns zero" do
        player.instance_variable_set(:@score, 1)
        player.reset_score
        expect(player.score).to eq(0)
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