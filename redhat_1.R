##############leak data##############
setwd("/home/febbatchdata")
# load requied libraries --------------------------------------------------
library(data.table)

# load and transform people data ------------------------------------------
ppl <- fread("people.csv")

### Recode logic to numeric
p_logi <- names(ppl)[which(sapply(ppl, is.logical))]

for (col in p_logi) {
  set(ppl, j = col, value = as.numeric(ppl[[col]]))
}
rm(p_logi)

### transform date
ppl[,date := as.Date(as.character(date), format = "%Y-%m-%d")]

# load activities ---------------------------------------------------------

# read and combine
activs <- fread("act_train.csv")
TestActivs <- fread("act_test.csv")
TestActivs$outcome <- NA
activs <- rbind(activs,TestActivs)
rm(TestActivs)

# Extract only required variables
activs <- activs[, c("people_id","outcome","activity_id","date"), with = F]

# Merge people data into actvitities
d1 <- merge(activs, ppl, by = "people_id", all.x = T)

# Remember, remember the 5th of November and which is test
testset <- which(ppl$people_id %in% d1$people_id[is.na(d1$outcome)])
d1[, activdate := as.Date(as.character(date.x), format = "%Y-%m-%d")]

rm(activs)

# prepare grid for prediction ---------------------------------------------

# Create all group_1/day grid
minactivdate <- min(d1$activdate)
maxactivdate <- max(d1$activdate)
alldays <- seq(minactivdate, maxactivdate, "day")
allCompaniesAndDays <- data.table(
  expand.grid(unique(
    d1$group_1[!d1$people_id %in% ppl$people_id[testset]]), alldays
  )
)


## Nicer names
colnames(allCompaniesAndDays) <- c("group_1","date.p")

## sort it
setkey(allCompaniesAndDays,"group_1","date.p")

## What are values on days where we have data?
meanbycomdate <- d1[
  !d1$people_id %in% ppl$people_id[testset],
  mean(outcome),
  by = c("group_1","activdate")
  ]

## Add them to full data grid
allCompaniesAndDays <- merge(
  allCompaniesAndDays,
  meanbycomdate,
  by.x = c("group_1","date.p"), by.y = c("group_1","activdate"),
  all.x = T
)


# design function to interpolate unknown values ---------------------------

interpolateFun <- function(x){
  
  # Find all non-NA indexes, combine them with outside borders
  borders <- c(1, which(!is.na(x)), length(x) + 1)
  # establish forward and backward - looking indexes
  forward_border <- borders[2:length(borders)]
  backward_border <- borders[1:(length(borders) - 1)]
  
  # prepare vectors for filling
  forward_border_x <- x[forward_border]
  forward_border_x[length(forward_border_x)] <- abs(
    forward_border_x[length(forward_border_x) - 1] - 0.1
  ) 
  backward_border_x <- x[backward_border]
  backward_border_x[1] <- abs(forward_border_x[1] - 0.1)
  
  # generate fill vectors
  forward_x_fill <- rep(forward_border_x, forward_border - backward_border)
  backward_x_fill <- rep(backward_border_x, forward_border - backward_border)
  forward_x_fill_2 <- rep(forward_border, forward_border - backward_border) - 
    1:length(forward_x_fill)
  backward_x_fill_2 <- 1:length(forward_x_fill) -
    rep(backward_border, forward_border - backward_border)
  
  #linear interpolation
  vec <- (forward_x_fill + backward_x_fill)/2
  
  x[is.na(x)] <- vec[is.na(x)]
  return(x)
}


# apply and submit --------------------------------------------------------

allCompaniesAndDays[, filled := interpolateFun(V1), by = "group_1"]

d1 <- merge(
  d1,
  allCompaniesAndDays,
  all.x = T,all.y = F,
  by.x = c("group_1","activdate"),
  by.y = c("group_1","date.p")
)


## Create prediction file and write
testsetdt <- d1[
  d1$people_id %in% ppl$people_id[testset],
  c("activity_id","filled"), with = F
  ]

X=testsetdt[is.na(testsetdt$filled),]
testsetdt=testsetdt[!is.na(testsetdt$filled),]
abc=unique(X$activity_id)
test=fread('act_test.csv', verbose = FALSE) %>% as.data.frame() #added verbose for silent
test_new=test[test$activity_id %in% abc,]

setwd("~/")
write.csv(test_new,"test_69k.csv",row.names=F)


######################without leak data###################

library(data.table)
library(FeatureHashing)
library(xgboost)
library(dplyr)
library(Matrix)

setwd("~/")
test=fread('test_69k.csv', verbose = FALSE) %>% as.data.frame() #added verbose for silent
setwd("/home/febbatchdata")
train=fread('act_train.csv', verbose = FALSE) %>% as.data.frame() #added verbose for silent

#people data frame
people=fread('people.csv') %>% as.data.frame()

people$char_1<-NULL #unnecessary duplicate to char_2
names(people)[2:length(names(people))]=paste0('people_',names(people)[2:length(names(people))])

p_logi <- names(people)[which(sapply(people, is.logical))]
for (col in p_logi) set(people, j = col, value = as.numeric(people[[col]]))

#reducing group_1 dimension
people$people_group_1[people$people_group_1 %in% names(which(table(people$people_group_1)==1))]='group unique'

d1 <- merge(train, people, by = "people_id", all.x = T)
d2 <- merge(test, people, by = "people_id", all.x = T)
d2$outcome <- NA
row.train=nrow(train)
D=rbind(d1,d2)

rm(d1,d2)
D$date=lubridate::ymd(D$date)
D$week_date=lubridate::wday(D$date)
D$act_month=lubridate::month(D$date)
D$people_date=lubridate::ymd(D$people_date)
D$people_week_date=lubridate::wday(D$people_date)
D$people_month=lubridate::month(D$people_date)


test_activity_id=test$activity_id
char.cols=c('activity_category','people_group_1',
            'char_1','char_2','char_3','char_4','char_5','char_6','char_7','char_8','char_9','char_10',
            'people_char_2','people_char_3','people_char_4','people_char_5','people_char_6','people_char_7','people_char_8','people_char_9')
for (f in char.cols) {
  if (class(D[[f]])=="character") {
    levels <- unique(c(D[[f]]))
    D[[f]] <- as.numeric(factor(D[[f]], levels=levels))
  }
}


X_train=D[1:row.train,]
X_test=D[-(1:row.train),]
X_test$outcome=NULL

param <- list(objective = "binary:logistic", 
              eval_metric = "auc",
              booster = "gblinear", 
              eta = 0.046,
              subsample = 0.85,
              colsample_bytree = 0.95,
              colsample_bylevel = 0.9,
              min_child_weight = 0,
              max_depth = 11)
set.seed(99999)
model <- xgb.cv(data = dtrain, 
                param, nrounds = 450,nfold=5,
                watchlist = list(train = dtrain),
                print_every_n = 101)

model1 <- xgb.train(data = dtrain, 
                    param, nrounds = 450,
                    watchlist = list(train = dtrain),
                    print_every_n = 101)

out <- predict(model1, dtest)

sub_1<- data.frame(activity_id=s1$activity_id,outcome=sub)
setwd("~/")
interpol=read.csv("interpol.csv")
submit=rbind(sub_1,interpol)
write.csv(submit, file = "submit_geo.csv", row.names = F)
sub<- (s2$outcome*s4$outcome*s6$outcome*s8$outcome*s1$outcome*s3$outcome*s5$outcome*s7$outcome)^0.125

