#############
out_1<- read.csv("people_geo_quarter.csv")
out_2<- read.csv("test_subm.csv")
table(is.na(out_2))
out_2_1<- out_2[!(is.na(out_2$outcome)),]
out_1_1<- out_1[1:69073,]
out_7<- rbind(out_1_1,out_2_1)
write.csv(out_2_0,'c.csv',row.names = F)
out<- read.csv("mod3108Kaggle_01.csv")
out_2_0<- merge(out_1,out,by="activity_id")
out_2_0$outcome<- (out_2_0$outcome.x*0.25+0.75*out_2_0$outcome.y)
out_2_0<- out_2_0[,-c(2,3)]
