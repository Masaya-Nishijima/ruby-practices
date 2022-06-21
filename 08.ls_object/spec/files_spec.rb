require 'spec_helper'

RSpec.describe 'ファイル群' do
  describe 'ファイル群の表示' do
    context '基本的なファイルの表示' do
      it 'カレントディレクトリ' do
        files = Files.new
        expect { files.print_short_format }.to output.to_stdout
        files.print_short_format
      end

      it '指定ディレクトリ' do
        files = Files.new Dir.getwd + '/spec/test_dir'
        expect { files.print_short_format }.to output(/test_file10/).to_stdout
        expect { files.print_short_format }.to_not output(/\.test_file/).to_stdout
        files.print_short_format
      end
    end
    context '隠しファイルの表示' do
      it '指定ディレクトリの隠しファイル' do
        files = Files.new Dir.getwd + '/spec/test_dir', true
        expect { files.print_short_format }.to output(/\.test_file/).to_stdout
        files.print_short_format
      end
    end

    context 'ファイル群の反転表示' do
      it '指定ディレクトリの反転表示' do
        files = Files.new Dir.getwd + '/spec/test_dir'
        files.reverse!
        expect { files.print_short_format }.to output(/test_file9\s*test_file4/).to_stdout
        files.print_short_format
      end
    end

    context "ファイル群をロング表示" do
      it '指定ディレクトリをロング表示' do
        files = Files.new Dir.getwd + '/spec/test_dir'
        long_format_regular = /^[-dxrw]*\s*[0-9]*\s*[a-zA-Z]*\s*[a-zA-Z]*\s*[0-9]*\s*[0-9]*\s[0-9]*\s*[0-9]*:[0-9]*\s[a-zA-Z.]*/
        expect { files.print_long_format }.to output(long_format_regular).to_stdout
        files.print_long_format
      end
    end
  end
end
