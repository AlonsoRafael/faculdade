dados <- read.table(file = "treino_baleias.txt", header = TRUE,sep = ",")
dados2 <- read.table(file = "teste_baleias.txt", header = TRUE, sep = ",") 

str(dados)
summary(dados) 

str(dados2)
summary(dados2) 

dados$especie
table(dados$especie)
barplot(table(dados$especie))

azul<-dados[dados$especie == "Baleia Azul",]
fin <-dados[dados$especie == "Baleia Fin",]
cachalote <-dados[dados$especie == "Cachalote",]
jubarte <-dados[dados$especie == "Jubarte",]

######### B
azul$peso
mean(azul$peso)
sd(azul$peso)
var(azul$peso)
100*sd(azul$peso)/mean(azul$peso)


fin$peso
mean(fin$peso)
sd(fin$peso)
var(fin$peso)
100*sd(fin$peso)/mean(fin$peso)


cachalote$peso
mean(cachalote$peso)
sd(cachalote$peso)
var(cachalote$peso)
100*sd(cachalote$peso)/mean(cachalote$peso)


jubarte$peso
mean(jubarte$peso)
sd(jubarte$peso)
var(jubarte$peso)
100*sd(jubarte$peso)/mean(jubarte$peso)

#em media o menor e a jubarte e o maior a baleia azul

# em sd o menor e a baleia jubarte e o maior e a azul

# em var o menor e a jubarte e o maior a azul

# no coeficiente de  variancia a menor e a azul e o maior a jubarte



##### C
median(azul$volume_cranio)
# esta calculando valor medio do volume cranianio da baleia azul



##### D
hist(azul$peso)
# podemos ver q a media de peso da baleia azul e entre 19 mil e 22 mil e tem uma com o peso maior q 24 mil



####### E 
boxplot(azul$comprimento,fin$comprimento,cachalote$comprimento,jubarte$comprimento)
# vemos q a azul e maior e a menor e a jubarte

######### F
boxplot(azul$peso,fin$peso,cachalote$peso,jubarte$peso)
#azul a mais pesada e a jubarte a mais leve
boxplot(azul$profundidade_maxima,fin$profundidade_maxima,cachalote$profundidade_maxima,jubarte$profundidade_maxima)
#azul q vai mais fundo e a cachole e a q menos vai fundo
boxplot(azul$volume_cranio,fin$volume_cranio,cachalote$volume_cranio,jubarte$volume_cranio)
#azul maior cranio e jubarte menos




####### G
plot(x=dados$comprimento,y = dados$profundidade_maxima,pch=16,cex=0.8,type = "n")
points(x=azul$comprimento,y = azul$profundidade_maxima,pch=16,cex=0.8,col ="blue")
points(x=fin$comprimento,y = fin$profundidade_maxima,pch=16,cex=0.8,col ="yellow")
points(x=cachalote$comprimento,y = cachalote$profundidade_maxima,pch=16,cex=0.8,col ="red")
points(x=jubarte$comprimento,y = jubarte$profundidade_maxima,pch=16,cex=0.8,col ="black")



####### I
abline(v=26.9)
abline(h=250) # baleia azul

abline(v=27.5)
abline(h=210) # baleia fin

abline(v=23.1) # baleia cachalote e jubarte
abline(h=168.5)



######### H

previsao <-c()
for(j in 1:50){
  if(dados2$comprimento[j]>26.9 && dados2$profundidade_maxima[j]>250){
    previsao[j] <- "Baleia Azul"
  }else if(dados2$comprimento[j]<27.5 && dados2$profundidade_maxima[j]>210){
    previsao[j]<-"Baleia fin"
  }else if(dados2$comprimento[j]<23 && dados2$profundidade_maxima[j]<170){
    previsao[j]<- "Cachalote"
  }else{
    previsao[j] <- "Jubarte"
  }
}

previsao
mean(previsao==dados2$especie)


############################## 2 #################################
seq_steven <- c(0, 1, 0)
seq_garnit <- c(0, 0, 1)

jogar <- function(seq_steven, seq_garnit) {
  lancamentos <- sample(c(0, 1), size = 5, replace = TRUE)
  for (i in 1:(length(lancamentos) - 2)) {
    if (all(lancamentos[i:(i+2)] == seq_steven)) {
      return("steven")
    }
    if (all(lancamentos[i:(i+2)] == seq_garnit)) {
      return("garnit")
    }
  }
  return(jogar(seq_steven, seq_garnit))
}

n_partidas <- 10000
vitorias_garnit <- replicate(n_partidas, jogar(seq_steven, seq_garnit))
mean(vitorias_garnit == "garnit")

#################### 3 #######################################

dados4 <- read.table(file = "dados.txt", header = TRUE,sep = ";")
str(dados4)
summary(dados4)

### A
dados4$sexo
table(dados4$sexo)
barplot(table(dados4$sexo))
# vemos que a maioria das vitimas eram mulheres

### B
hist(dados4$idade,breaks =  6)
#Vemos que tem um grande numero de mortos entre 50 a 70 anos

### C
boxplot(dados4$idade)
# A media de idade das vitimas eram de 60 anos, 
#porem tem um concentracao de mortes entre 50 a 70 anos

### D
hist(dados4$hora)

#notamos que a maioria das vitimas sao mortas no periodo da tarde,
#entre 12 a 15 horas

### E
#De acordo com as analises a cima podem perceber que 
#A maioria das vitimas eram mulheres,
#A maioria das vitimas eram maiores de idade
#E a maioria era morta entra 13 a 15 horas
