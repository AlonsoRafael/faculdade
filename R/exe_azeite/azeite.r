azeite <- read.table(file = "olive.txt",header = TRUE,sep = ",")
str(azeite)

indices <- sample(1:nrow(azeite),size = nrow(azeite),replace = FALSE)

n <- round(nrow(azeite)*0.8)
treinamento<-azeite[1:n,]
teste <-azeite[(n+1):nrow(azeite),]
summary(treinamento)
summary(teste)

table(treinamento$region)
barplot(table(treinamento$region))

table(teste$region)
barplot(table(teste$region))

norte <-treinamento[treinamento$region == "Northern Italy",]
sardinia <-treinamento[treinamento$region == "Sardinia",]
sul <-treinamento[treinamento$region == "Southern Italy",]

par(mfrow = c(1,1))
plot(x=treinamento$linoleic,y = treinamento$eicosenoic,pch=16,cex=0.8,type = "n")
points(x=norte$linoleic,y = norte$eicosenoic,pch=16,cex=0.8,col ="blue")
points(x=sardinia$linoleic,y = sardinia$eicosenoic,pch=16,cex=0.8,col ="yellow")
points(x=sul$linoleic,y = sul$eicosenoic,pch=16,cex=0.8,col ="red")

abline(v=10.5)


previsao <-c()
for(j in 1:114){
  if(teste$linoleic[j]<10.5 && teste$eicosenoic[j]<0.1){
    previsao[j] <- "Northern Italy"
  }else if(teste$linoleic[j]>10.5 && teste$eicosenoic[j]<0.1){
      previsao[j]<-"Sardinia"
  }else if(teste$linoleic[j]>0 && teste$eicosenoic[j]>0.1){
    previsao[j]<- "Southern Italy"
  }
}

previsao
mean(previsao==teste$region)
