class RaceinfoToPDF
  KEIBA_GO_URL = 'https://www.keiba.go.jp/KeibaWeb/TodayRaceInfo/DebaTableSmall'
  MAX_RACE_COUNT = 12

  class << self
    def generate!
      baba_code, year, month, day = get_race_info
      puts 'start generate...'
      file = fetch_pdf(baba_code, year, month, day)
      File.write("pdf/#{baba_name(baba_code)}_#{year}_#{month}_#{day}.pdf", file)
      puts 'complete!'
    end

    def get_race_info
      puts BabaList::BABA_LIST
      puts 'リストから馬場コードを入力してください。'
      baba_code = gets.chomp
      unless BabaList::BABA_LIST.values.include?(baba_code.to_i)
        raise '馬場コードが間違っています'
      end

      puts 'Enter the year. ex.2020'
      year = gets.chomp

      puts 'Enter the month. ex.01'
      month = gets.chomp

      puts 'Enter the day. ex.01'
      day = gets.chomp

      [baba_code, year, month, day]
    end

    def fetch_pdf(baba_code, year, month, day)
      pdf = CombinePDF.new

      MAX_RACE_COUNT.times do |i|
        url = "#{KEIBA_GO_URL}?k_raceDate=#{year}%2f#{month}%2f#{day}&k_raceNo=#{i + 1}&k_babaCode=#{baba_code}"
        page = page(url, i + 1)
        break if page.to_html.include?('errorInfo')
        puts " race: #{i + 1} generating...."
        pdf << CombinePDF.parse(page.to_pdf)
      end
      pdf.to_pdf
    end

    def page(url, race_no)
      page = Grover.new(url, format: 'A4')
      raise '開催日が存在しません。' if page.to_html.include?('errorInfo') && race_no == 1
      page
    end

    def baba_name(baba_code)
      BabaList::BABA_LIST.key(baba_code.to_i)
    end
  end
end
