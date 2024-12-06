# 2  Fluxo de Trabalho: básico --------------------------------------------------

# Antes de irmos mais longe no aprendizado de R, vamos garantir que você tenha uma 
# base sólida na execução de código em R e que conheça alguns dos recursos mais 
# úteis do RStudio.


# 2.1 Princípios básicos de programação ------------------------------------------

# R com cálculos básicos
1 / 200 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

# Atribuição: Você pode criar novos objetos com o operador de atribuição <-:

x <- 3 * 4
   # É atribuido mas não é impresso é preciso digitar
x

# Você pode combinar vários elementos em um vetor com c():
primos <- c(2, 3, 5, 7, 11, 13)
primos

# A aritmética básica em vetores é aplicada a cada elemento do vetor:
primos*4

primos - 1

# comandos de atribuição
nome_objeto <- valor

  # Quando ler esse código, diga “nome do objeto recebe valor” na sua cabeça.
  # Digite Alt + "-" para o comando de atribuição, atalho do Rstudio
  # Já deixa espaço antes e depois

x <- 23

# 2.2 Comentários -------------------------------------------------------

# O R ignorará qualquer texto após "#" em uma linha.

# Comentários podem ser úteis para descrever brevemente o que o código a seguir faz:
    
    # cria um vetor de números primos
    primos <- c(2, 3, 5, 7, 11, 13)
    
    # multiplica primos por 2
    primos * 2

# Use comentários para explicar o PORQUÊ do seu código, não o como ou o o quê. 
# O o quê e o como do seu código são sempre possíveis de descobrir lendo-os 
# cuidadosamente

# Descobrir por que algo foi feito é muito mais difícil, senão impossível. 
# Por exemplo, geom_smooth(span = 0,90), o padrão é de 0.75. O valor maior
# poruz maior suavidade. Por que vc fez isso, então?
    
# Use comentários para explicar sua abordagem estratégica e registrar informações
# importantes à media que as encontrar.
    

# 2.3 A importância dos nomes -----------------------------------------------
    
# Nomes de objetos devem começar com uma letra e só podem conter letras, números, _ e .. 
    
# Recomenda-se usar a escrita de conome snake_cases
    eu_uso_snake_case
    outrasPessoasUsamCamelCase
    algumas.pessoas.usam.pontos
    E_aLgumas.Pessoas_nAoUsamConvencao
    
# Fazendo outra atribuição:
    esse_e_um_nome_bem_longo <- 2.5
# Use recurso de autocompletar do RStudio, digitando as 3 primeiras letras do nome e TAB
 
# Fazendo mais uma atribuição e veja alguns problemas:
r_rocks <- 2^3
r_rock
R_rocks

# O R é chato nisso, mas é importante

# 2.4 Chamando funções -----------------------------------------------------

# O R tem uma grande coleção de funções embutidas que são chamadas assim:
nome_da_funcao(argumento1 = valor1, argumento2 = valor2, ...)

# Teste digitando as 2 lettras de seq, depois tab, depois q e então F1.
se
# Quando vc selecionar a função, pressione TAB novamente para completar os ()
# Digite o nome do 1º argumento, depois o do 2º
seq(from = 1, to = 10)

# Podemos omitir os nomes dos argumentos
seq(1,10)


# Digite o código a seguir e veja que o RStudio fornece assistência semelhante 
# com as aspas em pares:
x <- "Olá, Mundo"

# Se esquecer uma aspa " ou um parentese, aparecerá uma sinal de + no console.
# Pressione ESC no console e complete a linha de código.

# Observe que no painela Enviorment, aparece todos os objetos que vc criou

# 2.5 Exercícios

# 1. Por que esse código ão funciona?
minha_variavel <- 10
minha_varıavel
      # Resp: foi digitado um 1 e não a letra i em variavel

# 2. Altere cada um dos seguintes comandos R para que eles sejam executados corretamente:
libary(todyverse)
libary(dados)
# Corrigindo ....
library(tidyverse)
library(dados)

ggplot(dTa = milhas) + 
  geom_point(maping = aes(x = cilindrada y = rodovia)) +
  geom_smooth(method = "lm")
# Corrigindo  .... 
ggplot(data = milhas) + 
  geom_point(mapping = aes(x = cilindrada, y = rodovia)) +
  geom_smooth(aes(x = cilindrada, y = rodovia), method = "lm")


# 3. Verifique o que faz: Alt + Shift + K
# Podemos chegar ao mesmo lugar indo em: Help --> Keyboard Shortcuts

# 4. Vamos revisitar um exercício da Seção 1.6. Rode as seguintes linhas de código. 
# Qual dos dois gráficos é salvo como mpg-plot.png? Por quê?
meu_grafico_de_barras <- ggplot(milhas, aes(x = classe)) +
  geom_bar()

meu_grafico_de_dispersao <- ggplot(milhas, aes(x = cidade, y = rodovia)) +
  geom_point()

ggsave(filename = "milhas-plot.png", plot = meu_grafico_de_barras)

        # Será salvo o primeiro grafico, pois esse objeto gráfico foi salvo com o
        # nome meu_grafico_de_barras e foi colocado como argumento de plot = da
        # função ggsave








