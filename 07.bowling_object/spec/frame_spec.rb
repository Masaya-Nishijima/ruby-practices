# frozen_string_literal: true
require_relative '../lib/frame'

RSpec.describe 'フレーム' do
  describe '入出力' do
    context '通常時' do
      it '2,3 → 5' do
        frame = Frame.new([2, 3])
        expect(frame.point).to eq 5
        expect(frame.status).to eq nil
      end
    end

    context 'スペア' do
      it '3,7 → 10 & SPARE' do
        frame = Frame.new([3, 7])
        expect(frame.point).to eq 10
        expect(frame.status).to eq 'SPARE'
      end
    end

    context 'ストライク' do
      it 'X → 10 & STRIKE' do
        frame = Frame.new(['X'])
        expect(frame.point).to eq 10
        expect(frame.status).to eq 'STRIKE'
      end
    end

    context '3投の場合' do
      it '2,8,5 → 15 $ THREE_SHOT' do
        frame = Frame.new([2, 8, 5])
        expect(frame.point).to eq 15
        expect(frame.status).to eq 'THREE_SHOT'
      end
    end
  end
end
