################################### Q2################################
Q2_train=X_train[(X_train$act_month==4 | X_train$act_month==5 |X_train$act_month==6),]

##Q2_weenend##
Q2_weekend_train=Q2_train[(Q2_train$week_date==1 | Q2_train$week_date==7),]
Y=Q2_weekend_train$outcome
Q2_weekend_train$outcome=NULL
Q2_weekend=rbind(Q2_weekend_train,X_test)
Q2_weekend$i=1:dim(Q2_weekend)[1]

Q2_weekend.sparse=
  cBind(sparseMatrix(Q2_weekend$i,Q2_weekend$activity_category),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_group_1),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_1),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_2),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_3),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_4),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_5),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_6),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_7),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_8),
        sparseMatrix(Q2_weekend$i,Q2_weekend$char_9),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_2),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_3),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_4),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_5),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_6),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_7),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_8),
        sparseMatrix(Q2_weekend$i,Q2_weekend$people_char_9)
  )

Q2_weekend.sparse= cBind(Q2_weekend.sparse,
                         Q2_weekend$people_char_10,
                         Q2_weekend$people_char_11,
                         Q2_weekend$people_char_12,
                         Q2_weekend$people_char_13,
                         Q2_weekend$people_char_14,
                         Q2_weekend$people_char_15,
                         Q2_weekend$people_char_16,
                         Q2_weekend$people_char_17,
                         Q2_weekend$people_char_18,
                         Q2_weekend$people_char_19,
                         Q2_weekend$people_char_20,
                         Q2_weekend$people_char_21,
                         Q2_weekend$people_char_22,
                         Q2_weekend$people_char_23,
                         Q2_weekend$people_char_24,
                         Q2_weekend$people_char_25,
                         Q2_weekend$people_char_26,
                         Q2_weekend$people_char_27,
                         Q2_weekend$people_char_28,
                         Q2_weekend$people_char_29,
                         Q2_weekend$people_char_30,
                         Q2_weekend$people_char_31,
                         Q2_weekend$people_char_32,
                         Q2_weekend$people_char_33,
                         Q2_weekend$people_char_34,
                         Q2_weekend$people_char_35,
                         Q2_weekend$people_char_36,
                         Q2_weekend$people_char_37,
                         Q2_weekend$people_char_38,
                         Q2_weekend$act_week,
                         Q2_weekend$people_week,
                         Q2_weekend$people_month,
                         Q2_weekend$act_month
)

train.sparse=Q2_weekend.sparse[1:nrow(Q2_weekend_train),]
test.sparse=Q2_weekend.sparse[(nrow(Q2_weekend_train)+1):nrow(Q2_weekend.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s3 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q2_weekend,Q2_weekend_train,Q2_weekend.sparse)
####Q2_weekdays####
Q2_week_train=Q2_train[(Q2_train$week_date!=1 & Q2_train$week_date!=7),]
Y=Q2_week_train$outcome
Q2_week_train$outcome=NULL
Q2_week=rbind(Q2_week_train,X_test)
Q2_week$i=1:dim(Q2_week)[1]

Q2_week.sparse=
  cBind(sparseMatrix(Q2_week$i,Q2_week$activity_category),
        sparseMatrix(Q2_week$i,Q2_week$people_group_1),
        sparseMatrix(Q2_week$i,Q2_week$char_1),
        sparseMatrix(Q2_week$i,Q2_week$char_2),
        sparseMatrix(Q2_week$i,Q2_week$char_3),
        sparseMatrix(Q2_week$i,Q2_week$char_4),
        sparseMatrix(Q2_week$i,Q2_week$char_5),
        sparseMatrix(Q2_week$i,Q2_week$char_6),
        sparseMatrix(Q2_week$i,Q2_week$char_7),
        sparseMatrix(Q2_week$i,Q2_week$char_8),
        sparseMatrix(Q2_week$i,Q2_week$char_9),
        sparseMatrix(Q2_week$i,Q2_week$people_char_2),
        sparseMatrix(Q2_week$i,Q2_week$people_char_3),
        sparseMatrix(Q2_week$i,Q2_week$people_char_4),
        sparseMatrix(Q2_week$i,Q2_week$people_char_5),
        sparseMatrix(Q2_week$i,Q2_week$people_char_6),
        sparseMatrix(Q2_week$i,Q2_week$people_char_7),
        sparseMatrix(Q2_week$i,Q2_week$people_char_8),
        sparseMatrix(Q2_week$i,Q2_week$people_char_9)
  )

Q2_week.sparse= cBind(Q2_week.sparse,
                      Q2_week$people_char_10,
                      Q2_week$people_char_11,
                      Q2_week$people_char_12,
                      Q2_week$people_char_13,
                      Q2_week$people_char_14,
                      Q2_week$people_char_15,
                      Q2_week$people_char_16,
                      Q2_week$people_char_17,
                      Q2_week$people_char_18,
                      Q2_week$people_char_19,
                      Q2_week$people_char_20,
                      Q2_week$people_char_21,
                      Q2_week$people_char_22,
                      Q2_week$people_char_23,
                      Q2_week$people_char_24,
                      Q2_week$people_char_25,
                      Q2_week$people_char_26,
                      Q2_week$people_char_27,
                      Q2_week$people_char_28,
                      Q2_week$people_char_29,
                      Q2_week$people_char_30,
                      Q2_week$people_char_31,
                      Q2_week$people_char_32,
                      Q2_week$people_char_33,
                      Q2_week$people_char_34,
                      Q2_week$people_char_35,
                      Q2_week$people_char_36,
                      Q2_week$people_char_37,
                      Q2_week$people_char_38,
                      Q2_week$act_week,
                      Q2_week$people_week,
                      Q2_week$people_month,
                      Q2_week$act_month
)

train.sparse=Q2_week.sparse[1:nrow(Q2_week_train),]
test.sparse=Q2_week.sparse[(nrow(Q2_week_train)+1):nrow(Q2_week.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s4 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q2_week_train,Q2_week.sparse,Q2_week,Q2_train)
