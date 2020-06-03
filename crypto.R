crypto<-read.csv("crypto-markets.csv")

summary(crypto)
cryptoBITS<-data.frame()
for (i in 1:nrow(crypto)){
  if (crypto$symbol[i]=="BITS"){
      cryptoBITS[i]<-data.frame(crypto[i,])
  }
}


warnings() 

cryptoBITS<-data.frame(which(crypto$symbol=="BITS"))

length(crypto)
