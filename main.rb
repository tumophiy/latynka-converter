

require 'dotenv/load'
require 'telegram/bot'

# token = ENV['TOKEN']
token = '5902537194:AAHSWemDTNAsHj3PThzd3r5r-u_WtnS40uM'

HASH = {
  'б' => 'b', 'Б' => 'B',
  'в' => 'v', 'В' => 'V',
  'г' => 'g', 'Г' => 'G',
  'ґ' => 'ĝ', 'Ґ' => 'Ĝ',
  'д' => 'd', 'Д' => 'D',
  'ж' => 'ž', 'Ж' => 'Ž',
  'з' => 'z', 'З' => 'Z',
  'к' => 'k', 'К' => 'K',
  'л' => 'l', 'Л' => 'L',
  'м' => 'm', 'М' => 'M',
  'н' => 'n', 'Н' => 'N',
  'п' => 'p', 'П' => 'P',
  'р' => 'r', 'Р' => 'R',
  'с' => 's', 'С' => 'S',
  'т' => 't', 'Т' => 'T',
  'ф' => 'f', 'Ф' => 'F',
  'х' => 'h', 'Х' => 'H',
  'ц' => 'c', 'Ц' => 'C',
  'ч' => 'č', 'Ч' => 'Č',
  'ш' => 'š', 'Ш' => 'Š',
  'а' => 'a', 'А' => 'A',
  'е' => 'e', 'Е' => 'E',
  'и' => 'y', 'И' => 'Y',
  'і' => 'i', 'І' => 'I',
  'о' => 'o', 'О' => 'O',
  'у' => 'u', 'У' => 'U',
  'й' => 'j', 'Й' => 'J',
  'ь' => "'", 'Ь' => "'",
  'щ' => 'šč', 'Щ' => 'ŠČ',
  'я' => 'ja', 'Я' => 'Ja',
  'ю' => 'ju', 'Ю' => 'Ju',
  'є' => 'je', 'Є' => 'Je',
  'ї' => 'ji', 'Ї' => 'Ji',
  'ьа' => 'ja',
  'ьу' => 'ju',
  'ье' => 'je',
  'ьі' => 'ji',
  'ьо' => 'jo'
}
SUBST = Regexp.union(HASH.keys)

def kyrylytsja_to_latynka(text)
  array = []
  array_of_chars = text.chars
  length_of_text = array_of_chars.length - 1
  skip_next_element = false
  array_of_chars.each_with_index do |char, index|
    if char.match?(/[а-яїєґ]/i) && !skip_next_element
      if char == 'ь' && index < length_of_text
        match = array_of_chars[index + 1].match(/[іеуао]/)
        if match
          aa = "ь#{match.string}"
          array << HASH[aa]
          skip_next_element = true
          next
        end
      end
      array << HASH[char]
      skip_next_element = false
    elsif !skip_next_element
      array << char
    else
      skip_next_element = false
    end
  end
  array.join('')
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    else
      bot.api.send_message(chat_id: message.chat.id, text: kyrylytsja_to_latynka(message.text))
    end
  end
end
