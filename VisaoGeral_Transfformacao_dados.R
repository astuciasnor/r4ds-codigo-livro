#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#
#         CÓDIGOS PARA ESTUDAR O LIVRO "R PARA CIÊNCIAS DE DADOS"
#
#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# 3  Transformação de dados -------------------------------------------------
# 3.1. Introdução

# Nesse capítulo focaremos no pacote dplyr para transformar dados

# 3.1.1 Pré-requisitos
library(dados)
library(tidyverse)

# Preste bastante atenção às mensagens de conflito exibidas quando você carregar 
# o tidyverse. Elas te indicam que o dplyr sobrescreve algumas funções do R base.

# se quiser usar as funções de abse do R, utilize os nomes completos:
stats::filter() e stats::lag()
# Use sempre o comando abaixo para especificar a função de qual pacote nos referimos
nomedopacote::nomedafuncao()

# 3.1.2 Voos (nycflights13)

# Para explorar os verbos básicos do dplyr iremos utilizar a base de dados dados::voos. 
# Essa base contém todos os 336.776 vôos que saíram da cidade de Nova Iorque em 2013.

voos
# Voos é um tibble, um tipo especial de dtaframe usado para evitar umas "pegadinhas"
# Só mostra um que cabe na tela. Você usar também o View() ou a aba de ambientes
# ou use a função glimpse
glimpse(voos)

# Observe os tipos de dados: double (numeros reais) e dttm (date-time, data e hora)
# Saber o tipo é importante para as análises

# 3.1.3 Básico do dplyr -----------------------------------------------------

# O primeiro argumento é sempre um data frame.
# Os demais argumentos geralmente descrevem sobre quais colunas a operação 
#    será executada, utilizando o nome das variáveis (sem aspas).
# A saída é sempre um novo data frame.

# As funções individuais são facilmente encadeados com o operador pipe |> 
                 x |> f(y) equivale a f(x,y)
#Exemplo de uso do pipe |>:
voos |>
  filter(destino == "IAH") |> 
  group_by(ano, mes, dia) |> 
  summarize(
    atraso_chegada = mean(atraso_chegada, na.rm = TRUE)
  )

# Verbos do dplyr são organizados em quatro grupos baseados na estrutura sobre a qual
# operam: linhas (rows), colunas (columns), grupos (groups) ou tabelas (tables)


# 3.2 Linhas (rows) ---------------------------------------------------------

# Os verbos mais importantes que operam nas linhas de um conjunto de dados são:
#     filter(), arrange() e distinct()

# 3.2.1 filter() 
# Permite manter linhas com base nos valores das colunas. O primeiro argumento 
# é o data frame. O segundo e demais argumentos são as condições que devem ser 
# verdadeiras para manter a linha

# Achar as linhas do df voos cujos tempos de atraso sejam superiores a 120 min
voos |> 
  filter(atraso_saida > 40)

# Podemos usr várias condições lógicas. As linhas que atendem essa condições (TRUE)
# Serão mantidos no novo dataframe
# Condições: > , >= , <, <=, ==, !=, aplicar combinações de condicções com &, |

# Voos que partiram no dia 1 de Janeiro
voos |> 
  filter(mes == 1 & dia == 1)

# Voos que partiram em janeiro ou fevereiro
voos |> 
  filter(mes == 1 | mes == 2)

# Combinação de == e |, podemos usar o operador %in%
# Ele vai manter as linhas cujas variáveis são iguais a um dos valores à direita:

# Uma forma mais curta de selecionar vôos que decolaram em janeiro ou fevereiro
voos |> 
  filter(mes %in% c(1, 2))

# Para salvar o resultado, você precisa utilizar o operador de atribuição <-:
jan1 <- voos |> 
  filter(mes == 1 & dia == 1)

# 3.2.2 Erros comuns

# Trocar == por =
voos |> 
  filter(mes = 1)

voos |> 
  filter(mes == 1|2)  # Veja como se faz acima

# 3.2.3 arrange()

# Ordena os voos segundo os anos mais antigos e depois os primeiros meses dentro de cada ano, etc
voos |> 
  arrange(ano, mes, dia, horario_saida)

# Ordenando em ordem decrescente, dos voos com mais atraso para os menso atradasados
voos |> 
  arrange(desc(ano))

# 3.2.4 distinct() 

# Remove linhas duplicadas, se existirem 
voos |> 
  distinct()

# Acha todos os pares únicos de origens e destinos
voos |> 
  distinct(origem, destino)
# Quiser manter as outras colunas qunado estiver filtrando
voos |> 
  distinct(origem, destino, .keep_all = TRUE)

# Se, em vez disso, você quiser achar o número de ocorrências, é melhor trocar 
# distinct() por count(), e com o argumento sort = TRUE

voos |> 
  count(origem, destino, sort = T)

# 3.2.5 Exercícios -----------------------------------------------------------

# 1 Utilizando umunico pipeline, ache os voos que cumpram cada condição:
# a) Teve um atraso na chegada de duas mou mais horas
voos |> 
  filter(atraso_chegada > 120)
# b) Voou para Houston (IAH ou HOU)
voos |> 
  filter(destino == "IAH" | destino == "HOU")

voos |> 
  filter(destino %in% c("IAH", "HOU"))

# c) Foi operado pela United, American ou Delta
voos |> 
  filter(companhia_aerea %in% c("UA","AA","DL"))

# d) Decolou no verão3 (julho, agosto e setembro)
voos |> 
  filter(mes %in% c(7,8,9))
# e) Chegou com mais de duas horas de atraso, mas não teve atraso na decolagem
voos |> 
  filter(atraso_chegada > 120 & atraso_saida <= 0) |> 
  print(n = 29)
# f) Atrasou pelo menos uma hora, mas recuperou mais de 30 minutos em vôo.
voos |> 
  filter(atraso_saida >= 60 & (atraso_saida - atraso_chegada) > 30)

# 2. Ordene voos para achar os vôos com os maiores atrasos na decolagem. 
# Ache os vôos que saíram o mais cedo pela manhã.
voos |> 
  arrange(desc(atraso_saida))

voos |> 
  arrange(hora, minuto)

# 3. Ordene voos para achar os vôos mais rápidos. 
# (Dica: tente incluir algum cálculo matemático dentro da sua função.)
voos |> 
  arrange(tempo_voo) |> select(tempo_voo)

# 4. Houve pelo menos um vôo em cada dia de 2013?
voos |> 
  distinct(mes, dia)
    # Sim, houve pelo menos um voo em cada dia 2013

# 5. Quais vôos percorream as maiores distâncias? 
#    Quais percorreram as menores?

voos |> 
  arrange(desc(distancia)) |> select(distancia)

voos |> 
  arrange(distancia) |> select(distancia)

# 6. Resp: faz diferença sim. 

# 3.3 Colunas (columns) ----------------------------------------------

# 