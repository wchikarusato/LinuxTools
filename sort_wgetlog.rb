
File.open(ARGV[0]) do |file|
  urlbefore = ""
  urlafter = ""
  file.each_line do |l|
    if l =~ /^--/
      str = l.match(/^--(.+?)--  (.*)/)
      if urlbefore == "" then urlbefore = str[2] end
#      puts str[2]
    end
    if l =~ /に保存/
      str = l.match(/`(.+?)' に保存中/)
#      puts str[1]
      urlafter = str[1]
    end
    if l =~ /エラー 404: Not Found。/
      urlafter = "エラー 404: Not Found。"
    end
    if l =~ /失敗しました: 接続を拒否されました/
      urlafter = "失敗しました: 接続を拒否されました"
    end
    if urlafter != "" then
      puts "#{urlbefore}\t#{urlafter}"
      urlbefore = ""
      urlafter = ""
    end
  end
end

