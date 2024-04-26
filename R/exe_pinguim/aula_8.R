pinguim <- read.table(file = "pinguim.txt", header = TRUE, sep = ',') #lendo o conjunto
str(pinguim) #estrutura do conjunto
pinguim <- na.omit(pinguim) #retirando as observacaoes que possuem dados faltantes
str(pinguim) #o número de linhas diminuiu após a remoçao das observacoes com dados faltantes

table(pinguim$sex) #observe que há uma observacao com um ponto (.) na coluna sex; vamos remover esta observacao 
which(pinguim$sex == ".")
pinguim <- pinguim[-which(pinguim$sex == "."),]

pinguim$species <- as.factor(pinguim$species) #transformando a coluna species para factor
pinguim$sex <- as.factor(pinguim$sex) #transformando a coluna sex para factor
levels(pinguim$sex) #categorias da coluna sex

adelie <- pinguim[pinguim$species == "Adelie",]
gentoo <- pinguim[pinguim$species == 'Gentoo',]

chinstrap <- pinguim[pinguim$species == "Chinstrap",]

var(adelie$body_mass_g) #variancia do peso dos pinguins da especie adelie
sd(adelie$body_mass_g)#desvio padrao do peso dos pinguins da especie adelie

var(gentoo$body_mass_g) #variancia do peso dos pinguins da especie gentoo
sd(gentoo$body_mass_g) #desvio padrao do peso dos pinguins da especie gentoo

var(chinstrap$body_mass_g) #variancia do peso dos pinguins da especie chinstrap
sd(chinstrap$body_mass_g) #desvio padrao do peso dos pinguins da especie chinstrap

#a seguir, o calculo do coeficiente de variacao de cada especie em relacao ao peso; é possivel notar que adelie possui a maior variacao e gentoo a menor.
100*sd(adelie$body_mass_g)/mean(adelie$body_mass_g)

100*sd(gentoo$body_mass_g)/mean(gentoo$body_mass_g)

100*sd(chinstrap$body_mass_g)/mean(chinstrap$body_mass_g) #coeficiente de variacao

#separando o conjunto em treino e teste; a divisao será 80% para treino e 20% para teste
pinguim <- pinguim[sample(nrow(pinguim)),]
n <- round(nrow(pinguim)*0.8)
treinamento <- pinguim[1:n,]
teste <- pinguim[(n+1):nrow(pinguim),]

#a partir do treinamento, separamos as especies
adelie <- treinamento[treinamento$species == "Adelie",]
gentoo <- treinamento[treinamento$species == 'Gentoo',]
chinstrap <- treinamento[treinamento$species == "Chinstrap",]

#grafico de dispersao do tamanho do bico versus a profundidade do bico
plot(x = treinamento$culmen_length_mm, y = treinamento$culmen_depth_mm, type = "n")

points(x = adelie$culmen_length_mm, y = adelie$culmen_depth_mm, pch = 16, col = "red")

points(x = gentoo$culmen_length_mm, y = gentoo$culmen_depth_mm, pch = 16, col = "green")

points(x = chinstrap$culmen_length_mm, y = chinstrap$culmen_depth_mm, pch = 16, col = "blue")

#vamos adicionar a primeira observacao do teste no grafico construido anteriormente; a partir dessa inclusao, qual deve ser a classificacao dessa observacao?
points(x = teste$culmen_length_mm[1], y = teste$culmen_depth_mm[1], pch = 16, cex = 2)

#criando uma funcao que calcula a distancia entre dois vetores
distancia <- function(x,y){
  return(sqrt(sum((x-y)**2)))
}

#exemplo de aplicacao
x <- c(1,2)
y <- c(3,4)
distancia(x,y)


#criando o modelo
#1. para cada observacao do teste, calcule a distancia desta observacao para todas as observacoes do treinamento (logo, só serao utilizadas as variaveis numericas)
#2. encontre a menor distancia
#3. encontre a especie da observacao mais proxima que foi encontrada em 2.
#classifique a observacao do teste com a especie encontrada em 3.
previsao <- c()
for (k in 1:nrow(teste)) {
  distancias <- c()
  for (j in 1:nrow(treinamento)) {
    distancias[j] <- distancia(teste[k,3:6],treinamento[j,3:6])
  }
  previsao[k] <- as.character(treinamento$species[order(distancias)[1]])
}
previsao
mean(previsao == teste$species)

#vamos refazer o modelo desconsiderando a variavel peso; a taxa de acerto será maior neste caso.
previsao <- c()
for (k in 1:nrow(teste)) {
  distancias <- c()
  for (j in 1:nrow(treinamento)) {
    distancias[j] <- distancia(teste[k,3:5],treinamento[j,3:5])
  }
  previsao[k] <- as.character(treinamento$species[order(distancias)[1]])
}
previsao
mean(previsao == teste$species)

#vamos agora construir o modelo knn desconsiderando a asa e incluindo o peso.

previsao <- c()
for (k in 1:nrow(teste)) {
  distancias <- c()
  for (j in 1:nrow(treinamento)) {
    distancias[j] <- distancia(teste[k,c(3,4,6)],treinamento[j,c(3,4,6)])
  }
  previsao[k] <- as.character(treinamento$species[order(distancias)[1]])
}
previsao
mean(previsao == teste$species)

#dos três modelos construídos, aquele que considera as informacoes sobre o bico e sobre a asa se mostrou o melhor modelo de previsao tomando como criterio de escolha a taxa de acerto.