# install.packages("telegram.bot")
library(telegram.bot)
library(devtools)

Token_do_Bot <- Bot(token = "1778236079:AAGV2ojus21kRQQc78nQESy51LjaN-0YBNY")
updater <- Updater(token = "1778236079:AAGV2ojus21kRQQc78nQESy51LjaN-0YBNY")
print(Token_do_Bot$get_me())
updates <- Token_do_Bot$getUpdates()

#Funcao start
start <- function(bot, update)
{
  bot$sendMessage(chat_id = update$message$chat_id,
                  text = sprintf("Olá %s, se estiver recebendo está mensagem, significa que eu existo e estou aqui!",
                                 update$message$from$first_name))
}
start_handler <- CommandHandler("start", start)
updater <- updater + start_handler

#Funcao hoje
hoje <- function(bot, update)
{
  bot$sendMessage(chat_id = update$message$chat_id,
                  text = sprintf("A data de hoje é %s",
                                 format(Sys.Date(), "%d-%b-%Y")))
}
hoje_handler <- CommandHandler("hoje", hoje)
updater <- updater + hoje_handler

#Funcao echo
echo <- function(bot, update){
  bot$sendMessage(chat_id = update$message$chat_id, text = update$message$text)
}

updater <- updater + MessageHandler(echo, MessageFilters$text)

#Funcao histograma de uma normal
historama_normal <- function(bot, update)
{
  png("my_plot.png")
  hist(rnorm(1000))
  dev.off()
  bot$sendPhoto(chat_id = update$message$chat_id, photo = 'my_plot.png')
}

hist_norm_handler <- CommandHandler("hist_norm", historama_normal)
updater <- updater + hist_norm_handler

updater$start_polling()
