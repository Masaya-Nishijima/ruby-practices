require 'spec_helper'

RSpec.describe '引数クラス' do
  describe "引数とオプション" do
    before do
      ARGV.clear
    end

    context "単一オプション" do
      it "-rを取得できる" do
        ARGV.concat('-r'.split(' '))
        argument = Argument.new()
        expect(argument.reverse?).to eq true
        expect(argument.all?).to be_falsey
        expect(argument.long?).to be_falsey
      end

      it "-aを取得できる" do
        ARGV.concat('-a'.split(' '))
        argument = Argument.new()
        expect(argument.reverse?).to be_falsey
        expect(argument.all?).to eq true
        expect(argument.long?).to be_falsey
      end

      it "-lを取得できる" do
        ARGV.concat('-l'.split(' '))
        argument = Argument.new()
        expect(argument.reverse?).to be_falsey
        expect(argument.all?).to be_falsey
        expect(argument.long?).to eq true
      end
    end

    context "複合したオプション" do
      it "-a -rを取得できる" do
        ARGV.concat('-a -r'.split(' '))
        argument = Argument.new()
        expect(argument.reverse?).to eq true
        expect(argument.all?).to eq true
        expect(argument.long?).to be_falsey
      end

      it "-arlを取得できる" do
        ARGV.concat('-arl'.split(' '))
        argument = Argument.new()
        expect(argument.reverse?).to eq true
        expect(argument.all?).to eq true
        expect(argument.long?).to eq true
      end
    end

    context "パス" do
      it "./spec/test_dir/test_file1を取得できる" do
        ARGV.concat('./spec/test_dir/test_file1'.split(' '))
        argument = Argument.new()
        expect(argument.path).to eq './spec/test_dir/test_file1'
      end

      it "./Gemfileを取得できる" do
        ARGV.concat('./Gemfile'.split(' '))
        argument = Argument.new()
        expect(argument.path).to eq './Gemfile'
      end

      it "Gemfileを取得できる" do
        ARGV.concat('Gemfile'.split(' '))
        argument = Argument.new()
        expect(argument.path).to eq 'Gemfile'
      end
    end

    context "オプションとパス" do
      it "-ra ./Gemfileを取得できる" do
        ARGV.concat('-ra ./Gemfile'.split(' '))
        argument = Argument.new()
        expect(argument.path).to eq './Gemfile'
        expect(argument.reverse?).to eq true
        expect(argument.all?).to eq true
        expect(argument.long?).to be_falsey
      end
    end
  end
end
