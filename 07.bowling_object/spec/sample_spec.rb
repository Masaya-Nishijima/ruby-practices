require_relative '../lib/shot'
require_relative '../lib/frame'
require_relative '../lib/game'

RSpec.describe "完了条件" do
  it "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5" do
    game = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5")
    expect(game.score).to eq 139
  end

  it "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X" do
    game = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X")
    expect(game.score).to eq 164
  end

  it "0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4" do
    game = Game.new("0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4")
    expect(game.score).to eq 107
  end

  it "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0" do
    game = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0")
    expect(game.score).to eq 134
  end

  it "6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8" do
    game = Game.new("6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8")
    expect(game.score).to eq 144
  end

  it "X,X,X,X,X,X,X,X,X,X,X,X" do
    game = Game.new("X,X,X,X,X,X,X,X,X,X,X,X")
    expect(game.score).to eq 300
  end
end
