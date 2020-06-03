crypto<-read.csv("crypto-markets.csv")

summary(crypto)

cryptoBITS<-crypto[(crypto$symbol=="BITS"),]
cryptoPXC<-crypto[(crypto$symbol=="PXC"),]
cryptoBTB<-crypto[(crypto$symbol=="BTB"),]
cryptoBTM<-crypto[(crypto$symbol=="BTM"),]
cryptoBTC<-crypto[(crypto$symbol=="BTC"),]
cryptoLTC<-crypto[(crypto$symbol=="LTC"),]

