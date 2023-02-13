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




  # Reset outputs correctly
  after :all do
    $stdout = @stdout
    $stderr = @stderr
    @stdout = nil
    @stderr = nil
  end

end