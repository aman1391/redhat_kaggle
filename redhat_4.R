################################### Q3################################
Q3_train=X_train[(X_train$act_month==7 | X_train$act_month==8 |X_train$act_month==9),]

##Q3_weenend##
Q3_weekend_train=Q3_train[(Q3_train$week_date==1 | Q3_train$week_date==7),]
Y=Q3_weekend_train$outcome
Q3_weekend_train$outcome=NULL
Q3_weekend=rbind(Q3_weekend_train,X_test)
Q3_weekend$i=1:dim(Q3_weekend)[1]

Q3_weekend.sparse=
  cBind(sparseMatrix(Q3_weekend$i,Q3_weekend$activity_category),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_group_1),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_1),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_2),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_3),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_4),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_5),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_6),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_7),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_8),
        sparseMatrix(Q3_weekend$i,Q3_weekend$char_9),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_2),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_3),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_4),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_5),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_6),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_7),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_8),
        sparseMatrix(Q3_weekend$i,Q3_weekend$people_char_9)
  )

Q3_weekend.sparse= cBind(Q3_weekend.sparse,
                         Q3_weekend$people_char_10,
                         Q3_weekend$people_char_11,
                         Q3_weekend$people_char_12,
                         Q3_weekend$people_char_13,
                         Q3_weekend$people_char_14,
                         Q3_weekend$people_char_15,
                         Q3_weekend$people_char_16,
                         Q3_weekend$people_char_17,
                         Q3_weekend$people_char_18,
                         Q3_weekend$people_char_19,
                         Q3_weekend$people_char_20,
                         Q3_weekend$people_char_21,
                         Q3_weekend$people_char_22,
                         Q3_weekend$people_char_23,
                         Q3_weekend$people_char_24,
                         Q3_weekend$people_char_25,
                         Q3_weekend$people_char_26,
                         Q3_weekend$people_char_27,
                         Q3_weekend$people_char_28,
                         Q3_weekend$people_char_29,
                         Q3_weekend$people_char_30,
                         Q3_weekend$people_char_31,
                         Q3_weekend$people_char_32,
                         Q3_weekend$people_char_33,
                         Q3_weekend$people_char_34,
                         Q3_weekend$people_char_35,
                         Q3_weekend$people_char_36,
                         Q3_weekend$people_char_37,
                         Q3_weekend$people_char_38,
                         Q3_weekend$act_week,
                         Q3_weekend$people_week,
                         Q3_weekend$people_month,
                         Q3_weekend$act_month
)

train.sparse=Q3_weekend.sparse[1:nrow(Q3_weekend_train),]
test.sparse=Q3_weekend.sparse[(nrow(Q3_weekend_train)+1):nrow(Q3_weekend.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s5 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q3_weekend,Q3_weekend_train,Q3_weekend.sparse)
####Q3_weekdays####
Q3_week_train=Q3_train[(Q3_train$week_date!=1 & Q3_train$week_date!=7),]
Y=Q3_week_train$outcome
Q3_week_train$outcome=NULL
Q3_week=rbind(Q3_week_train,X_test)
Q3_week$i=1:dim(Q3_week)[1]


Q3_week.sparse=
  cBind(sparseMatrix(Q3_week$i,Q3_week$activity_category),
        sparseMatrix(Q3_week$i,Q3_week$people_group_1),
        sparseMatrix(Q3_week$i,Q3_week$char_1),
        sparseMatrix(Q3_week$i,Q3_week$char_2),
        sparseMatrix(Q3_week$i,Q3_week$char_3),
        sparseMatrix(Q3_week$i,Q3_week$char_4),
        sparseMatrix(Q3_week$i,Q3_week$char_5),
        sparseMatrix(Q3_week$i,Q3_week$char_6),
        sparseMatrix(Q3_week$i,Q3_week$char_7),
        sparseMatrix(Q3_week$i,Q3_week$char_8),
        sparseMatrix(Q3_week$i,Q3_week$char_9),
        sparseMatrix(Q3_week$i,Q3_week$people_char_2),
        sparseMatrix(Q3_week$i,Q3_week$people_char_3),
        sparseMatrix(Q3_week$i,Q3_week$people_char_4),
        sparseMatrix(Q3_week$i,Q3_week$people_char_5),
        sparseMatrix(Q3_week$i,Q3_week$people_char_6),
        sparseMatrix(Q3_week$i,Q3_week$people_char_7),
        sparseMatrix(Q3_week$i,Q3_week$people_char_8),
        sparseMatrix(Q3_week$i,Q3_week$people_char_9)
  )

Q3_week.sparse= cBind(Q3_week.sparse,
                      Q3_week$people_char_10,
                      Q3_week$people_char_11,
                      Q3_week$people_char_12,
                      Q3_week$people_char_13,
                      Q3_week$people_char_14,
                      Q3_week$people_char_15,
                      Q3_week$people_char_16,
                      Q3_week$people_char_17,
                      Q3_week$people_char_18,
                      Q3_week$people_char_19,
                      Q3_week$people_char_20,
                      Q3_week$people_char_21,
                      Q3_week$people_char_22,
                      Q3_week$people_char_23,
                      Q3_week$people_char_24,
                      Q3_week$people_char_25,
                      Q3_week$people_char_26,
                      Q3_week$people_char_27,
                      Q3_week$people_char_28,
                      Q3_week$people_char_29,
                      Q3_week$people_char_30,
                      Q3_week$people_char_31,
                      Q3_week$people_char_32,
                      Q3_week$people_char_33,
                      Q3_week$people_char_34,
                      Q3_week$people_char_35,
                      Q3_week$people_char_36,
                      Q3_week$people_char_37,
                      Q3_week$people_char_38,
                      Q3_week$act_week,
                      Q3_week$people_week,
                      Q3_week$people_month,
                      Q3_week$act_month
)

train.sparse=Q3_week.sparse[1:nrow(Q3_week_train),]
test.sparse=Q3_week.sparse[(nrow(Q3_week_train)+1):nrow(Q3_week.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s6 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q3_week_train,Q3_week.sparse,Q3_week,Q3_train)
