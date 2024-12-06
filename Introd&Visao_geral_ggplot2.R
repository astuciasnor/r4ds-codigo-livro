#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#
#         CÓDIGOS PARA ESTUDAR O LIVRO "R PARA CIÊNCIAS DE DADOS"
#
#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# INTRODUÇÃO ------------------------------------------------------------

# Instalação do pacote principal : O Tidyverse

install.packages("tidyverse")
library(tidyverse)

# Outros pacotes complementares

install.packages(
      c("arrow", "curl", "remotes", "duckdb",
        "ggrepel", "ggridges", "ggthemes", "hexbin", "janitor",  
        "leaflet", "maps", "openxlsx", 
        "repurrrsive", "tidymodels", "writexl")
    )

# Instalar o pacote de dados
    
remotes::install_github("cienciadedatos/dados")





# VISÃO GERAL ----------------------------------------------------------

# 1.1. Introdução e Carregamento de pacote e de dados -------------------

library(tidyverse)
library(dados)
library(ggthemes)

# 1.2 Primeiros passos ----------------------------------------------------

# Os dados de oinguins
pinguins
glimpse(pinguins)

# 1.2.3 Criando um gráfico ggplot

# Primeira camada:
ggplot(data = pinguins)

# Segunda camada: a estética e os dados
ggplot(data = pinguins,
       mapping = aes(x = comprimento_nadadeira, 
                     y = massa_corporal)
       )


# Terceira camada: a "geometria"

ggplot(
  data = pinguins,
  mapping = aes(x = comprimento_nadadeira, y = massa_corporal)
  ) +
  geom_point()

# 1.2.4 Adicionando atributos estéticos e camdas
ggplot(data = pinguins,
       mapping = aes(x = comprimento_nadadeira, 
                     y = massa_corporal, 
                     color = especie)) +
  geom_point()

# Adicionando uma curva
ggplot(data = pinguins,
       mapping = aes(x = comprimento_nadadeira, 
                     y = massa_corporal, 
                     color = especie)) +
  geom_point() +
  geom_smooth(method = "lm")

# Especificando cor apenas para camada geom_point()
# É uma especificação Local da geom e não Global(dentro da função ggplot())

ggplot( data = pinguins,
        mapping = aes(x = comprimento_nadadeira, 
                      y = massa_corporal)) +
  geom_point(mapping = aes(color = especie)) +
  geom_smooth(method = "lm")

# Mapeando so pontos para a estética shape (forma)

ggplot(data = pinguins,
       mapping = aes(x = comprimento_nadadeira, 
                     y = massa_corporal)) +
  geom_point(mapping = aes(color = especie, shape = especie)) +
  geom_smooth(method = "lm")

# Incluindo rotulos dos eixos e rótulo da legenda e mudando a cor para
# pessoas daltônicas

ggplot(pinguins, aes(x = comprimento_nadadeira, 
                     y = massa_corporal)) +
  geom_point(aes(color = especie, shape = especie)) +
  geom_smooth(method = "lm") +
  labs(title = "Massa corporal e comprimento da nadadeira",
       subtitle = "Medidas para Pinguim-de-adélia, Pinguim-de-barbicha e Pinguim-gentoo",
       x = "Comprimento da nadadeira (mm)",
       y = "Massa corporal (g)",
       color = "Espécie",
       shape = "Espécie") +
  scale_color_colorblind()

# 1.2.5 Resolução do exercícios --------------------------------------------

# 1. Linhas e colunas
glimpse(pinguins)

# 2. O que é bico profundiade_bico
?pinguins

# 3. Grafico de dispersão
pinguins |> 
  ggplot(aes(x = comprimento_bico, y = profundidade_bico)) +
  geom_point()
      # Não existe relação clara. Tlavez incluir a espécie
pinguins |> 
  ggplot(aes(x = comprimento_bico, y = profundidade_bico, colour = especie)) +
  geom_point() +
  geom_smooth( method = 'lm')
     # Incluindo cor por especie, há uma certa relação linear

# 4. Grafico de especie em função de profundiade
ggplot(pinguins, aes(y = profundidade_bico, x = especie)) +
  geom_boxplot(width = 0.2) +
  geom_jitter(aes(colour = especie), show.legend = F, width = 0.1)
  
# 5. Por que o seguinte erro ocorre e como você poderia corrigi-lo?
ggplot(data = pinguins) + 
  geom_point()
   # Resposta: porque falta as variaveis x e y dos dois eixos

# 6. O que o argumento na.rm faz em geom_point()? 
     # resp: remove valores faltantes, evitando o aviso
pinguins |> 
  ggplot(aes(x = comprimento_bico, y = profundidade_bico, colour = especie)) +
  geom_point(na.rm = T) 

# 7. Adicionando a fonte: “Os dados são provenientes do pacote dados”
pinguins |> 
  ggplot(aes(x = comprimento_bico, y = profundidade_bico, colour = especie)) +
  geom_point(na.rm = T) +
  labs(caption = "Os dados são provenientes do pacote dados", tag = "A")
  
# 8. Recrie a visualização a seguir.
  # A profundiade deve ser mapeada para colour =
ggplot(data = pinguins, aes(x = comprimento_nadadeira, 
                            y = massa_corporal,
                            colour = profundidade_bico)) + 
  geom_point() +
  geom_smooth()

# 9. Execute esse código em sua mente e preveja como será o resultado
ggplot(data = pinguins,
       mapping = aes(x = comprimento_nadadeira, 
                     y = massa_corporal, 
                     color = ilha)) +
  geom_point() +
  geom_smooth(se = FALSE)

# 10. Esses dois gráficos serão diferentes? Por que sim ou por que não?
ggplot(data = pinguins,
  mapping = aes(x = comprimento_nadadeira, 
                y = massa_corporal)) +
  geom_point() +
  geom_smooth()


ggplot() +
  geom_point(data = pinguins,
             mapping = aes(x = comprimento_nadadeira, 
                           y = massa_corporal)) +
  geom_smooth(data = pinguins,
              mapping = aes(x = comprimento_nadadeira, 
                            y = massa_corporal))

  # Nos dois casos, o gráfico gerado será idêntico.
  # são os mesmos quando defindidos localmente. A 1ª forma acima seria mais enxuta,
  # pois os mapeamentos são globais, não precisando neste caso defini-los localmente,
  # ou seja, nas geoms específicas

# 1.3 Camadas ggplot2 ----------------------------------------------------------

# Formas de escrita de códigos no ggplot2:

# Forma explícita do código:
ggplot(data = pinguins,
       mapping = aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point()

# Forma mais concisa do código
ggplot(pinguins, 
       aes(x = comprimento_nadadeira, y = massa_corporal))+
  geom_point()

# Forma com o pipe (|> ) 
pinguins |> 
  ggplot(aes(x = comprimento_nadadeira, y = massa_corporal)) + 
  geom_point()

# 1.4 Visualizando distribuições ------------------------------------------------
# A forma como você visualiza a distribuição de uma variável depende do tipo de 
# variável: categórica ou numérica.

# 1.4.1 Uma variável categórica ---

pinguins |> 
  ggplot(aes(x = especie)) +
  geom_bar()
   # O eixo y representa quantas observações (count) ocorrem com cada valor de x


# Podemos reeordenar os níveis nos gráficos transformado a categprira em factor
 pinguins |> 
   ggplot(aes(x = fct_infreq(especie))) +
   geom_bar()
 

# 1.4.2 Uma variável numérica  ---

# As variáveis numéricas podem ser contínuas ou discretas.

# Uma visualização comumente usada para distribuições de variáveis 
# contínuas é um histograma.

pinguins |> 
  ggplot(aes(x = massa_corporal)) +
  geom_histogram(binwidth = 200)

# Tentes sempre encontrar uma largura de barra com que possa reelar padrões
pinguins |> 
  ggplot(aes(x = massa_corporal)) +
  geom_histogram(binwidth = 20)

pinguins |> 
  ggplot(aes(x = massa_corporal)) +
  geom_histogram(binwidth = 2000)

# Outa forma de representar é um gráfico de densidade
pinguins |> 
  ggplot(aes(x = massa_corporal)) +
  geom_density()

# 1.4.3 Exercícios -------------------------------------------------------------

# 1 - gráfico de barras de pinguins, especie ao aributo estético y

pinguins |> 
  ggplot(aes(y = fct_infreq(especie))) +
  geom_bar()

# 2 - Como os dois gráficos são diferentes 

ggplot(pinguins, aes(x = especie)) +
  geom_bar(color = "red")

ggplot(pinguins, aes(x = especie)) +
  geom_bar(fill = "red")
     # O atributo fill é mais útil para alterar a cor das barras

# 3 - O que o argumento bins em geom_histogram() faz?
pinguins |> 
  ggplot(aes(x = massa_corporal)) +
  geom_histogram(bins = 4)
    # bins define o número de barras

# 4 - Faça um histograma da variável quilate no conjunto de dados diamante
diamante |> 
  ggplot(aes(x = quilate)) +
  geom_histogram(binwidth = 1)

diamante |> 
  ggplot(aes(x = quilate)) +
  geom_histogram(binwidth = 0.05)

diamante |> 
  ggplot(aes(x = quilate)) +
  geom_histogram(binwidth = 0.2)

    # o binwidth de 0.2 é mehor para visualizar o tipo de distribuição

# 1.5 Visualizando relações --------------------------------------------------------

# 1.5.1 Uma variável numérica e uma variável categórica
# A melhor a forma de representar esse tipo de relação é através de boxplot

# Considerando especie (caegoria)  e a massa corporal (numerica), temsos
pinguins |> 
  ggplot(aes(x = especie, y = massa_corporal)) +
  geom_boxplot(width=0.3, aes(fill = especie), show.legend = F)

# outra forma, seria com gráficos de densidade
pinguins |> 
  ggplot(aes(x = massa_corporal, color = especie)) +
  geom_density(linewidth = 1.2) 

# MApeamento a cor e o prenchimento das curvas de densidade
pinguins |> 
  ggplot(aes(x = massa_corporal, 
             color = especie, 
             fill = especie)) +
  geom_density(alpha = 0.5)

# 1.5.2 Duas variáveis categóricas (ilha e especie)

# grafico de barras empilhadas (SEM percentual)
pinguins |> 
  ggplot(aes(x = ilha, fill = especie)) +
  geom_bar()

# grafico de barras empilhadas (COM percentual)

pinguins |> 
  ggplot(aes(x = ilha, fill = especie)) +
  geom_bar(position = 'fill')

# 1.5.3 Duas variáveis numéricas
# Graficos de dispersão são osmais usados neste caso
pinguins |> 
  ggplot(aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point() 

# 1.5.4 Três ou mais variáveis 
# incorporamis mais variáveis aos atributos estéticos adiconais (shape, color, fill,etc)
pinguins |> 
  ggplot(aes(x = comprimento_nadadeira, 
             y = massa_corporal)) +
  geom_point(aes(color = especie, shape = ilha)) +
  geom_smooth(method = "lm", aes(colour = especie))


# criando facetas para facilitar o entendimento dos gráficos
pinguins |> 
  ggplot(aes(x = comprimento_nadadeira, 
             y = massa_corporal)) +
  geom_point(aes(color = especie, shape = especie)) +
  facet_wrap(~ilha)

# 1.5.5 Exercícios -----------------------------------------------------------------

# 1. O descobrindo as variáveis categorics do data frame milhas
# Selecionando apenas as variáveis categóricas
glimpse(milhas)

nomes_categoricos <- milhas |>  
  select_if(~ is.factor(.) | is.character(.)) |>  
  names()

print(nomes_categoricos)

# 2. Faça um gráfico de dispersão de para o rodovia
milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point()
  
milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point(aes(color = cilindros))

milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point(aes(size = cilindros))

milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point(aes(colour = cilindros, size = cidade))
  
milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point(aes(shape = classe))

# 3. espessura da linha?
milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point(aes(linewidth = cidade)) 
   # Vai ignorar este mapeamento 

milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point() +
  geom_smooth(aes(linewidth = tracao))
# aqui funcionou porque temos uma linha

# 4. O que acontece se você mapear a mesma variável para várias atributos estéticos
milhas |> 
  ggplot(aes(x =rodovia, y = cilindrada)) +
  geom_point(aes(colour = classe, shape = classe))
  # Pode haver uma só legenda sobreposta se a variável for categórica

# 5. Grafico de disperão e cor e facetas
pinguins |> 
  ggplot(aes(x = profundidade_bico, 
             y = comprimento_bico,
             colour = especie)) +
  geom_point()
     # Revelou um certa relação linear, o que não era possivel antes

pinguins |> 
  ggplot(aes(x = profundidade_bico, 
             y = comprimento_bico)) +
  geom_point() +
  facet_wrap(~especie)
     # Também permitiu ver melhor relaçoes lineares

# 6. legendas separadas
pinguins |> 
  ggplot(aes(x = comprimento_bico, 
             y = profundidade_bico, 
             color = especie, 
             shape = especie)) +
  geom_point() +
  labs(color = "Especie")
# O problema está com a função las() cuja parametro para color está escrito
# "Especie". A solução seria de retirar esse rotulo ou mudar tanto para color
# quanto para shape, conforme abaixo
pinguins |> 
  ggplot(aes(x = comprimento_bico, 
             y = profundidade_bico, 
             color = especie, 
             shape = especie)) +
  geom_point() +
  labs(color = "Espécie", shape = "Espécie")

# 7. Criando gráfico de barras empilhadas
pinguins |> 
  ggplot(aes(x = ilha, fill = especie)) +
  geom_bar(position = "fill")
   # Este primeiro responde sobre a proporção de especies por ilha

pinguins |> 
  ggplot(aes(x = especie, fill = ilha)) +
  geom_bar(position = "fill")
   # Este segundo responde como uma especie se distribui através das ilhas  

# 1.6 Salvando seus gráficos -------------------------------
# Use o ggsave() para salavar seus gráficos e usar em outros lugares

pinguins |> 
  ggplot(aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(aes(colour = especie)) +
  theme_classic() +
  theme(legend.position = c(0.25, 0.9))

ggsave(filename = "images/penguin-plot.png")

# 1.6.1 Exercícios
# 1. Quais dos 2 gráficos será salvo?

ggplot(milhas, aes(x = classe)) +
  geom_bar()

ggplot(milhas, aes(x = cidade, y = rodovia)) +
  geom_point()

ggsave("grafico-milhas.png")

    # Será salvo o último gráfico

# 2. O que você precisa alterar no código acima para salvar o gráfico como PDF?
ggsave("images/grafico-milhas.pdf")

# 1.7 Problemas comuns ------------------------------

# Esquecer parênteses ( e  )
# Esquecer aspas "  e "
# Aparecendo um +, pressione ESC para interromper o processo
# O sinal + deve vir no final da linha no ggplot2
ggplot(data = milhas) 
+ geom_point(mapping = aes(x = cilindrada, y = rodovia))
# Selecione uma função no editor e pressione F1 para obter ajuda sobre ela
# Pule direto para um exemplo que correponda ao que você está tentanto fazer
# Mensagens de erro: a resposta pode estar escondida na mensagem de erro
# Procure ajuda no Google e nos fóruns
# Peça ajuda de uma IA, digitando o nome da função e o que pretende obter com ela



