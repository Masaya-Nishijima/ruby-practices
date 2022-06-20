# frozen_string_literal: true
require_relative '../lib/game'

RSpec.describe 'ゲーム' do
  describe 'スコアの算出' do
    context 'ストライク・スペア無し' do
      it '3,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0' do
        game = Game.new('3,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
        expect(game.score).to eq 6
      end
    end

    context 'スペアあり(ストライク、三投はなし)' do
      it '0,10,1,5,0,0,0,0,0,0,0,0,0,0,5,1,8,1,0,4' do
        game = Game.new('0,10,1,5,0,0,0,0,0,0,0,0,0,0,5,1,8,1,0,4')
        expect(game.score).to eq 36
      end
    end

    context 'ストライクあり(連続ストライク、三投はなし)' do
      it 'X,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0' do
        game = Game.new('X,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
        expect(game.score).to eq 28
      end
    end

    context '連続ストライクあり(3投はなし)' do
      it 'X,X,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0' do
        game = Game.new('X,X,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
        expect(game.score).to eq 47
      end
    end

    context '三投あり' do
      it '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5' do
        game = Game.new('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5')
        expect(game.score).to eq 15
      end
    end
  end

  # ストライク・スペアの無い試合
  # ストライク・スペアがある試合
  # 10フレーム目が三投の試合
end
