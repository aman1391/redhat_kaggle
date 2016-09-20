################################### Q4################################
Q4_train=X_train[(X_train$act_month==10 | X_train$act_month==11 |X_train$act_month==12),]

##Q4_weenend##
Q4_weekend_train=Q4_train[(Q4_train$week_date==1 | Q4_train$week_date==7),]
Y=Q4_weekend_train$outcome
Q4_weekend_train$outcome=NULL
Q4_weekend=rbind(Q4_weekend_train,X_test)
Q4_weekend$i=1:dim(Q4_weekend)[1]

Q4_weekend.sparse=
  cBind(sparseMatrix(Q4_weekend$i,Q4_weekend$activity_category),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_group_1),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_1),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_2),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_3),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_4),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_5),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_6),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_7),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_8),
        sparseMatrix(Q4_weekend$i,Q4_weekend$char_9),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_2),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_3),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_4),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_5),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_6),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_7),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_8),
        sparseMatrix(Q4_weekend$i,Q4_weekend$people_char_9)
  )

Q4_weekend.sparse= cBind(Q4_weekend.sparse,
                         Q4_weekend$people_char_10,
                         Q4_weekend$people_char_11,
                         Q4_weekend$people_char_12,
                         Q4_weekend$people_char_13,
                         Q4_weekend$people_char_14,
                         Q4_weekend$people_char_15,
                         Q4_weekend$people_char_16,
                         Q4_weekend$people_char_17,
                         Q4_weekend$people_char_18,
                         Q4_weekend$people_char_19,
                         Q4_weekend$people_char_20,
                         Q4_weekend$people_char_21,
                         Q4_weekend$people_char_22,
                         Q4_weekend$people_char_23,
                         Q4_weekend$people_char_24,
                         Q4_weekend$people_char_25,
                         Q4_weekend$people_char_26,
                         Q4_weekend$people_char_27,
                         Q4_weekend$people_char_28,
                         Q4_weekend$people_char_29,
                         Q4_weekend$people_char_30,
                         Q4_weekend$people_char_31,
                         Q4_weekend$people_char_32,
                         Q4_weekend$people_char_33,
                         Q4_weekend$people_char_34,
                         Q4_weekend$people_char_35,
                         Q4_weekend$people_char_36,
                         Q4_weekend$people_char_37,
                         Q4_weekend$people_char_38,
                         Q4_weekend$act_week,
                         Q4_weekend$people_week,
                         Q4_weekend$people_month,
                         Q4_weekend$act_month
)

train.sparse=Q4_weekend.sparse[1:nrow(Q4_weekend_train),]
test.sparse=Q4_weekend.sparse[(nrow(Q4_weekend_train)+1):nrow(Q4_weekend.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s7 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q4_weekend,Q4_weekend_train,Q4_weekend.sparse)
####Q4_weekdays####
Q4_week_train=Q4_train[(Q4_train$week_date!=1 & Q4_train$week_date!=7),]
Y=Q4_week_train$outcome
Q4_week_train$outcome=NULL
Q4_week=rbind(Q4_week_train,X_test)
Q4_week$i=1:dim(Q4_week)[1]


Q4_week.sparse=
  cBind(sparseMatrix(Q4_week$i,Q4_week$activity_category),
        sparseMatrix(Q4_week$i,Q4_week$people_group_1),
        sparseMatrix(Q4_week$i,Q4_week$char_1),
        sparseMatrix(Q4_week$i,Q4_week$char_2),
        sparseMatrix(Q4_week$i,Q4_week$char_3),
        sparseMatrix(Q4_week$i,Q4_week$char_4),
        sparseMatrix(Q4_week$i,Q4_week$char_5),
        sparseMatrix(Q4_week$i,Q4_week$char_6),
        sparseMatrix(Q4_week$i,Q4_week$char_7),
        sparseMatrix(Q4_week$i,Q4_week$char_8),
        sparseMatrix(Q4_week$i,Q4_week$char_9),
        sparseMatrix(Q4_week$i,Q4_week$people_char_2),
        sparseMatrix(Q4_week$i,Q4_week$people_char_3),
        sparseMatrix(Q4_week$i,Q4_week$people_char_4),
        sparseMatrix(Q4_week$i,Q4_week$people_char_5),
        sparseMatrix(Q4_week$i,Q4_week$people_char_6),
        sparseMatrix(Q4_week$i,Q4_week$people_char_7),
        sparseMatrix(Q4_week$i,Q4_week$people_char_8),
        sparseMatrix(Q4_week$i,Q4_week$people_char_9)
  )

Q4_week.sparse= cBind(Q4_week.sparse,
                      Q4_week$people_char_10,
                      Q4_week$people_char_11,
                      Q4_week$people_char_12,
                      Q4_week$people_char_13,
                      Q4_week$people_char_14,
                      Q4_week$people_char_15,
                      Q4_week$people_char_16,
                      Q4_week$people_char_17,
                      Q4_week$people_char_18,
                      Q4_week$people_char_19,
                      Q4_week$people_char_20,
                      Q4_week$people_char_21,
                      Q4_week$people_char_22,
                      Q4_week$people_char_23,
                      Q4_week$people_char_24,
                      Q4_week$people_char_25,
                      Q4_week$people_char_26,
                      Q4_week$people_char_27,
                      Q4_week$people_char_28,
                      Q4_week$people_char_29,
                      Q4_week$people_char_30,
                      Q4_week$people_char_31,
                      Q4_week$people_char_32,
                      Q4_week$people_char_33,
                      Q4_week$people_char_34,
                      Q4_week$people_char_35,
                      Q4_week$people_char_36,
                      Q4_week$people_char_37,
                      Q4_week$people_char_38,
                      Q4_week$act_week,
                      Q4_week$people_week,
                      Q4_week$people_month,
                      Q4_week$act_month
)

train.sparse=Q4_week.sparse[1:nrow(Q4_week_train),]
test.sparse=Q4_week.sparse[(nrow(Q4_week_train)+1):nrow(Q4_week.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s8 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q4_week_train,Q4_week.sparse,Q4_week,Q4_train)
