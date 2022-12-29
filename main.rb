require 'telegram/bot'

TOKEN = '5852461356:AAFzUSlr3Rnk8O2ETfcBGQ1NT7z_ZixsYCs'

# Telegram::Bot::Client.run(TOKEN) do |bot|
#   bot.listen do |message|
#     case message.text
#     when '/start', '/start start'
#       bot.api.send_message(
#         chat_id: message.chat.id,
#         text: "3ApaBCTByü, #{message.from.first_name}"
#       )
#     else
#       bot.api.send_message(
#         chat_id: message.chat.id,
#         text: 'test'
#       )
#     end
#   end
# end

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end

# Telegram::Bot::Client.run(TOKEN) do |bot|
#   bot.listen do |message|
#     case message.text
#     when '/start'
#       bot.api.send_message(chat_id: message.chat_id, text: 'hello')
#     end
#   end
# end
