# frozen_string_literal: true

require_relative '../lib/shot'

RSpec.describe 'ショット' do
  describe '入出力の対応' do
    context 'ストライク以外' do
      it '0点のとき' do
        shot = Shot.new(0)
        expect(shot.point).to eq 0
      end

      it '9点のとき' do
        shot = Shot.new(9)
        expect(shot.point).to eq 9
      end
    end

    context 'ストライク' do
      it 'X→10' do
        shot = Shot.new('X')
        expect(shot.point).to eq 10
      end
    end

    context 'nil入力への対応' do
      it 'nil→nil' do
        shot = Shot.new(nil)
        expect(shot.point).to eq nil
      end
    end
  end
end
