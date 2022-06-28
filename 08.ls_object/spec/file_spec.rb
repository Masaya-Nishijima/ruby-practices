require 'spec_helper'

RSpec.describe 'オーバーライドしたファイルクラス' do
  describe "クラスの動作確認" do
    context "パスの出力" do
      it "入力されたファイルを出力すること" do
        file = File.new('Gemfile')
        expect(file.name).to eq 'Gemfile'
      end

      it "入力されたパスを出力すること" do
        file = File.new('./spec/test_dir/test_file1')
        expect(file.name).to eq './spec/test_dir/test_file1'
      end

      it "入力されたパスを出力すること(カレントディレクトリ直下)" do
        file = File.new('./Gemfile')
        expect(file.name).to eq './Gemfile'
      end
    end
    context "File::Statクラス関係の情報参照" do
      before do
        @file = File.new('./spec/test_dir/test_file1')
      end

      it "ファイルの種類を出力できること" do
        expect(@file.type).to eq "-"
      end

      it "ファイルの各権限を出力できること" do
        expect(@file.mode_rwx_owner).to match /[-rwx]{3}/
        expect(@file.mode_rwx_group).to match /[-rwx]{3}/
        expect(@file.mode_rwx_other).to match /[-rwx]{3}/
      end

      it "オーナー名,グループ名が出力できること" do
        expect(@file.owner).to match /\w+/
        expect(@file.owner).to_not match /\s/
        expect(@file.group).to match /\w+/
        expect(@file.group).to_not match /\s/
      end

      it "作成時間を出力できること" do
        expect(@file.time_for_ls).to match /[\s0-9]{2}\s[\s0-9]{2}\s[0-9]{2}:[0-9]{2}/
      end
    end
  end
end
