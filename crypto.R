crypto<-read.csv("crypto-markets.csv")

summary(crypto)
cryptoBITS<-dta.frame()
for (i in 1:nrow(crypto)){
  if (crypto$symbol=="BITS")
    cryptoBITS[i,]<-crypto[i,]
 }
