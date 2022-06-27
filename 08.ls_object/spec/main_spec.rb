# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'メイン' do
  describe '表示' do
    before do
      ARGV.clear
    end
    context 'ショート表示' do
      it 'オプションなしで昇順ショート表示されること' do
        main = Main.new
        expect { main.print }.to output.to_stdout
        expect { main.print }.to_not output(/[0-9]+:[0-9]+/).to_stdout
      end

      it '指定のディレクトリで降順ショート表示されること' do
        ARGV.concat('-r spec/test_dir'.split(' '))
        main = Main.new
        expect { main.print }.to output(/test_file9\s*test_file4/).to_stdout
        main.print
      end
    end
    context 'ロング表示' do
      it '-lを指定されたときにロング表示されること' do
        ARGV.concat('-l'.split(' '))
        main = Main.new
        expect { main.print }.to output.to_stdout
        expect { main.print }.to output(/[0-9]+:[0-9]+/).to_stdout
      end
    end
  end
end
