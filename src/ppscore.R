library(tidyverse)
outcomes <- c(1,0,0,1,0,0,0,1,0,0,0,0,0,1,0,1,0,0)
workers <- read_csv('../data/workers.csv')
wid <- workers$WorkerId

BrierAcc <- function(x)
{
  res <- outcomes[x[2]]
  if(res == 1)
    return(2*(1-x[1])^2)
  else
    return(2*x[1]^2)
}

CatQuestions <- function(x)
{
  if(x >= 1 && x <= 6)
    return('Sports')
  else if(x >= 7 && x <= 12)
    return('Politics')
  else if(x >= 13 && x <= 18)
    return('Entertainment')
}

CatTreatment <- function(x)
{
  if(x == 1)
    return('Scoring Rule')
  else if(x == 2)
    return('Peer Prediction')
  else if(x == 3)
    return('Scoring + PP (Rank)')
  else if(x == 4)
    return('Scoring + PP')
}

answers.oct8 <- read_csv('../data/answers-oct8.csv')
answers.oct9 <- read_csv('../data/answers-oct9.csv')
answers.oct10 <- read_csv('../data/answers-oct10.csv')
answers.oct11 <- read_csv('../data/answers-oct11.csv')
answers.oct12 <- read_csv('../data/answers-oct12.csv')
answers.oct13 <- read_csv('../data/answers-oct13.csv')


#oct 8 
one.answers.oct8 <- answers.oct8 %>% group_by(workerId, taskID) %>% filter(timestamp == max(timestamp) ) %>% ungroup()
workers.oct8 <- unique(one.answers.oct8$workerId)
#add aditional columns
one.answers.oct8$Category <- apply(one.answers.oct8[,c('taskID')],1, CatQuestions)
one.answers.oct8$BrierScore <- apply(one.answers.oct8[,c('forecast','taskID')],1,BrierAcc)

#oct 9 
one.answers.oct9 <- answers.oct9 %>% group_by(workerId, taskID) %>% filter(timestamp == max(timestamp) ) %>% ungroup()
workers.oct9 <- unique(one.answers.oct9$workerId)
#add aditional columns
one.answers.oct9$Category <- apply(one.answers.oct9[,c('taskID')],1, CatQuestions)
one.answers.oct9$BrierScore <- apply(one.answers.oct9[,c('forecast','taskID')],1,BrierAcc)

#oct 10
one.answers.oct10 <- answers.oct10 %>% group_by(workerId, taskID) %>% filter(timestamp == max(timestamp) ) %>% ungroup()
workers.oct10 <- unique(one.answers.oct10$workerId)
#add aditional columns
one.answers.oct10$Category <- apply(one.answers.oct10[,c('taskID')],1, CatQuestions)
one.answers.oct10$BrierScore <- apply(one.answers.oct10[,c('forecast','taskID')],1,BrierAcc)

#oct 11
one.answers.oct11 <- answers.oct11 %>% group_by(workerId, taskID) %>% filter(timestamp == max(timestamp) ) %>% ungroup()
workers.oct11 <- unique(one.answers.oct11$workerId)
#add aditional columns
one.answers.oct11$Category <- apply(one.answers.oct11[,c('taskID')],1, CatQuestions)
one.answers.oct11$BrierScore <- apply(one.answers.oct11[,c('forecast','taskID')],1,BrierAcc)

#oct 12
one.answers.oct12 <- answers.oct12 %>% group_by(workerId, taskID) %>% filter(timestamp == max(timestamp) ) %>% ungroup()
workers.oct12 <- unique(one.answers.oct12$workerId)
#add aditional columns
one.answers.oct12$Category <- apply(one.answers.oct12[,c('taskID')],1, CatQuestions)
one.answers.oct12$BrierScore <- apply(one.answers.oct12[,c('forecast','taskID')],1,BrierAcc)

#oct 13
one.answers.oct13 <- answers.oct13 %>% group_by(workerId, taskID) %>% filter(timestamp == max(timestamp) ) %>% ungroup()
workers.oct13 <- unique(one.answers.oct13$workerId)
#add aditional columns
one.answers.oct13$Category <- apply(one.answers.oct13[,c('taskID')],1, CatQuestions)
one.answers.oct13$BrierScore <- apply(one.answers.oct13[,c('forecast','taskID')],1,BrierAcc)




#compute peer prediction scores for the four different treatments
computeScore <- function(r11, r12, r21, r23)
{
  disc <- c(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
  delta <- matrix(NA, nrow = 10, ncol = 10)
  delta[1,] <- c(1,1,0,0,0,0,0,0,0,0)
  delta[2,] <- c(1,1,1,1,0,0,0,0,0,0)
  delta[3,] <- c(0,1,1,1,1,1,0,0,0,0)
  delta[4,] <- c(0,1,1,1,1,1,1,1,1,1)
  delta[5,] <- c(0,0,1,1,1,1,1,1,1,1)
  delta[6,] <- c(0,0,1,1,1,1,1,1,1,1)
  delta[7,] <- c(0,0,0,1,1,1,1,1,1,1)
  delta[8,] <- c(0,0,0,1,1,1,1,1,1,1)
  delta[9,] <- c(0,0,0,1,1,1,1,1,1,1)
  delta[10,] <- c(0,0,0,1,1,1,1,1,1,1)
  
  score <- CAScore(r11,r21, delta, disc) - CAScore(r12,r23,delta, disc)
  return(score)
}

CAScore <- function(p, q, delta, disc)
{
  i1 <- 1
  i2 <- 1
  
  for(i in 1:(length(disc) - 1) )
  {
    if(p >= disc[i] && p <= disc[i+1])
      i1 <- i
    if(q >= disc[i] && q <= disc[i+1])
      i2 <- i
  }
  return(delta[i1,i2])
}

dates <- c(8,9,10,11,12,13)

for(dt in dates)
{
  if(dt == 8)
    dfone <- one.answers.oct8
  else if(dt == 9)
    dfone <- one.answers.oct9
  else if(dt == 10)
    dfone <- one.answers.oct10
  else if(dt == 11)
    dfone <- one.answers.oct11
  else if(dt == 12)
    dfone <- one.answers.oct12
  else if(dt == 13)
    dfone <- one.answers.oct13
  
  # PP Score for Oct 8
  data1 <- subset(dfone, treatment == 1)
  data2 <- subset(dfone, treatment == 2)
  data3 <- subset(dfone, treatment == 3)
  data4 <- subset(dfone, treatment == 4)

  for(j in 1:4)
  {
    if(j == 1)
      ppdf <- data1
    else if(j == 2)
      ppdf <- data2
    else if(j == 3)
      ppdf <- data3
    else if(j == 4)
      ppdf <- data4
  
    for(i in 1:nrow(ppdf))
    {
      t1 <- ppdf[i,"taskID"]$taskID
      u1 <- ppdf[i,"workerId"]$workerId
    
      ntasks <- subset(ppdf, workerId == u1)$taskID
      score <- 0
      for(times in 1:100)
      {
        t2 <- sample(setdiff(ntasks,t1),1)
        t3 <- sample(setdiff(ntasks,c(t1,t2)),1)
        #find another user u.a.r who answered t1 and t3
        workers2t3 <- subset(ppdf, workerId != u1 & taskID == t3)$workerId
        workers2t1 <- subset(ppdf, workerId != u1 & taskID == t1)$workerId 
      
        wcap <- intersect(workers2t3, workers2t1)
        u2 <- sample(wcap, 1)
      
        r11 <- subset(ppdf, workerId == u1 & taskID == t1)$forecast
        r12 <- subset(ppdf, workerId == u1 & taskID == t2)$forecast
        r21 <- subset(ppdf, workerId == u2 & taskID == t1)$forecast
        r23 <- subset(ppdf, workerId == u2 & taskID == t3)$forecast
        score <- score + (1+computeScore(r11,r12,r21,r23))/2
      }
      score <- score / 100;
      ppdf[i,"PPPayment"] <- score
    
    }
    print(c('done', j))
    if(j == 1)
      data1$PPPayment <- ppdf$PPPayment
    else if(j == 2)
      data2$PPPayment <- ppdf$PPPayment
    else if(j == 3)
      data3$PPPayment <- ppdf$PPPayment
    else if(j == 4)
      data4$PPPayment <- ppdf$PPPayment
  }
  
  if(dt == 8)
    filename <- 'ppscore8.csv'
  else if(dt == 9)
    filename <- 'ppscore9.csv'
  else if(dt == 10)
    filename <- 'ppscore10.csv'
  else if(dt == 11)
    filename <- 'ppscore11.csv'
  else if(dt == 12)
    filename <- 'ppscore12.csv'
  else if(dt == 13)
    filename <- 'ppscore13.csv'

  PPScore <- rbind(data1, data2)
  PPScore <- rbind(PPScore, data3)
  PPScore <- rbind(PPScore, data4)

  write_csv(PPScore,filename)

}

