require 'spec_helper'

RSpec.describe 'メイン' do
  describe '引数' do
    context '引数を取得できること' do
      before do
        ARGV.clear
      end
      it '-a' do
        ARGV.concat(['-a'])
        main = Main.new
        expect(main.params[:all]).to eq true
        expect(main.params[:reverse]).to be_falsey
        expect(main.params[:long_format]).to be_falsey
      end

      it '-r' do
        ARGV.concat(['-r'])
        main = Main.new
        expect(main.params[:all]).to be_falsey
        expect(main.params[:reverse]).to eq true
        expect(main.params[:long_format]).to be_falsey
      end

      it '-l' do
        ARGV.concat(['-l'])
        main = Main.new
        expect(main.params[:all]).to be_falsey
        expect(main.params[:reverse]).to be_falsey
        expect(main.params[:long_format]).to eq true
      end

      it '-arl' do
        ARGV.concat(['-arl'])
        main = Main.new
        expect(main.params[:all]).to eq true
        expect(main.params[:reverse]).to eq true
        expect(main.params[:long_format]).to eq true
      end
    end
  end

  describe "表示" do
    before do
      ARGV.clear
    end
    context "ショート表示" do
      it "オプションなし" do
        main = Main.new
        expect{main.print}.to output.to_stdout
        expect{main.print}.to_not output(/[0-9]+:[0-9]+/).to_stdout
      end
    end
    context "ロング表示" do
      it "-lのみ" do
        ARGV.concat('-l'.split(' '))
        main = Main.new
        expect{main.print}.to output.to_stdout
        expect{main.print}.to output(/[0-9]+:[0-9]+/).to_stdout
      end
    end

  end


  # it "RSpecでARGVの変更" do
  #   ARGV.clear
  #   ARGV.concat('-a man.rb'.split(' '))
  #   main = Main.new
  #   # p ARGV
  #   expect("a").to eq "a"
  # end
end
