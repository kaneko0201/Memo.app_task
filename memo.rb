require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

def prompt_memo_type
  puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
  memo_type = gets.to_i
  until memo_type == 1 || memo_type == 2
    puts "無効な入力です。"
    puts "1(新規でメモを作成する)または2(既存のメモを編集する)を入力してください。"
    memo_type = gets.to_i
  end
  memo_type
end

selected_type = prompt_memo_type
# if文を使用して続きを作成していきましょう。
# 「memo_type」の値（1 or 2）によって処理を分岐させていきましょう。

if selected_type == 1
  puts "新しいメモを作成します。"
  puts "拡張子を除いたファイル名を入力してください。"

  memo_file = gets.chomp

  puts "メモしたい内容を記入してください。"
  puts "完了したら ctrl + D を押してください。"

  begin
    memo_contents = readlines(chomp:true)

    CSV.open("#{memo_file}.csv",'w') do |csv|
      memo_contents.each do |line|
        csv << [line]
      end
      puts "メモが#{memo_file}.csvに保存されました！"
    end
    rescue EOFError
  end

elsif selected_type == 2
  puts "既存のメモを編集します。"
  puts "拡張子を除いたファイル名を入力してください。"
  memo_file = gets.chomp

  if File.exist?("#{memo_file}.csv")
    puts "現在のメモ内容です。"
    CSV.foreach("#{memo_file}.csv") do |row|
      puts row[0]
    end

    puts "追加したい内容を記入してください。"
    puts "完了したら ctrl + D を押してください。"

    begin
      memo_edit = readlines(chomp:true)
        CSV.open("#{memo_file}.csv", 'a') do |csv|
          memo_edit.each do |line|
            csv << [line]
          end
          puts "メモを編集しました！"
        end
      rescue EOFError
    end

  else
    puts "存在しないファイルです。"
  end
end
