require_relative '../lib/shot'
require_relative '../lib/frame'
require_relative '../lib/game'

RSpec.describe "ゲーム" do
  describe "文字列の入力をフレームごと配列化" do
    context "ストライクがない場合" do
      it "1,1,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,0,0" do
        game = Game.new("1,1,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,0,0")
        expect(game.score_board).to eq [[1,1],[2,2],[3,3],[4,4],[5,5],[6,0],[7,0],[8,0],[9,0],[0,0]]
      end
    end

    context "ストライクがある場合(3投はなし)" do
      it "X,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,0,0" do
        game = Game.new("X,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,0,0")
        expect(game.score_board).to eq [['X'],[2,2],[3,3],[4,4],[5,5],[6,0],[7,0],[8,0],[9,0],[0,0]]
      end
      it "X,2,2,3,3,4,4,5,5,6,0,7,0,8,0,X,0,0" do
        game = Game.new("X,2,2,3,3,4,4,5,5,6,0,7,0,8,0,X,0,0")
        expect(game.score_board).to eq [['X'],[2,2],[3,3],[4,4],[5,5],[6,0],[7,0],[8,0],['X'],[0,0]]
      end
    end

    context "10投目が3球" do
      it "1,1,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,5,5,5" do
        game = Game.new("1,1,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,5,5,5")
        expect(game.score_board).to eq [[1,1],[2,2],[3,3],[4,4],[5,5],[6,0],[7,0],[8,0],[9,0],[5,5,5]]
      end
      it "1,1,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,X,5,5" do
        game = Game.new("1,1,2,2,3,3,4,4,5,5,6,0,7,0,8,0,9,0,X,5,5")
        expect(game.score_board).to eq [[1,1],[2,2],[3,3],[4,4],[5,5],[6,0],[7,0],[8,0],[9,0],['X',5,5]]
      end
    end
  end

  describe "スコアの算出" do
    context "ストライク・スペア無し" do
      it "3,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" do
        game = Game.new("3,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0")
        expect(game.score).to eq 6
      end
    end

    context "スペアあり(ストライク、三投はなし)" do
      it "0,10,1,5,0,0,0,0,0,0,0,0,0,0,5,1,8,1,0,4" do
        game = Game.new("0,10,1,5,0,0,0,0,0,0,0,0,0,0,5,1,8,1,0,4")
        expect(game.score).to eq 36
      end
    end

    context "ストライクあり(連続ストライク、三投はなし)" do
      it "X,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" do
        game = Game.new("X,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0")
        expect(game.score).to eq 28
      end
    end

    context "連続ストライクあり(3投はなし)" do
      it "X,X,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0" do
        game = Game.new("X,X,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0")
        expect(game.score).to eq 47
      end
    end

    context "三投あり" do
      it "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5" do
        game = Game.new("0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5")
        expect(game.score).to eq 15
      end
    end
  end

  # ストライク・スペアの無い試合
  # ストライク・スペアがある試合
  # 10フレーム目が三投の試合
end
