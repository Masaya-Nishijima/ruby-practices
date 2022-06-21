require 'spec_helper'

RSpec.describe 'ファイル群' do
  describe 'ファイル群の表示' do
    context '基本的なファイルの表示' do
      it 'カレントディレクトリ' do
        files = Files.new
        expect { files.print_short_form }.to output.to_stdout
        files.print_short_form
      end

      it '指定ディレクトリ' do
        files = Files.new Dir.getwd + '/spec/test_dir'
        expect { files.print_short_form }.to output(/test_file10/).to_stdout
        expect { files.print_short_form }.to_not output(/\.test_file/).to_stdout
        files.print_short_form
      end
    end
    context '隠しファイルの表示' do
      it '指定ディレクトリの隠しファイル' do
        files = Files.new Dir.getwd + '/spec/test_dir', true
        expect { files.print_short_form }.to output(/\.test_file/).to_stdout
        files.print_short_form
      end
    end
    context 'ファイル群の反転表示' do
      it '指定ディレクトリの反転表示' do
        files = Files.new Dir.getwd + '/spec/test_dir'
        files.reverse!
        expect { files.print_short_form }.to output(/test_file9\s*test_file4/).to_stdout
        files.print_short_form
      end
    end
  end
end
