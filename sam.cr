require "sam"
require "./config/initializers/database"
require "./db/migrations/*"
require "./src/models/*"

load_dependencies "jennifer"

# NOTA: É muito importante carregar tarefas personalizadas
# depois que outras mais importantes são carregadas
require "./db/seed"

# Here you can define your tasks
# desc "with description to be used by help command"
# task "test" do
#   puts "ping"
# end

Sam.help
