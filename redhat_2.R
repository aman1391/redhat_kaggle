################################### Q1################################
Q1_train=X_train[(X_train$act_month==1 | X_train$act_month==2 |X_train$act_month==3),]

##Q1_weenend##
Q1_weekend_train=Q1_train[(Q1_train$week_date==1 | Q1_train$week_date==7),]
Y=Q1_weekend_train$outcome
Q1_weekend_train$outcome=NULL
Q1_weekend=rbind(Q1_weekend_train,X_test)
Q1_weekend$i=1:dim(Q1_weekend)[1]

Q1_weekend.sparse=
  cBind(sparseMatrix(Q1_weekend$i,Q1_weekend$activity_category),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_group_1),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_1),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_2),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_3),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_4),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_5),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_6),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_7),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_8),
        sparseMatrix(Q1_weekend$i,Q1_weekend$char_9),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_2),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_3),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_4),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_5),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_6),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_7),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_8),
        sparseMatrix(Q1_weekend$i,Q1_weekend$people_char_9)
  )

Q1_weekend.sparse= cBind(Q1_weekend.sparse,
                         Q1_weekend$people_char_10,
                         Q1_weekend$people_char_11,
                         Q1_weekend$people_char_12,
                         Q1_weekend$people_char_13,
                         Q1_weekend$people_char_14,
                         Q1_weekend$people_char_15,
                         Q1_weekend$people_char_16,
                         Q1_weekend$people_char_17,
                         Q1_weekend$people_char_18,
                         Q1_weekend$people_char_19,
                         Q1_weekend$people_char_20,
                         Q1_weekend$people_char_21,
                         Q1_weekend$people_char_22,
                         Q1_weekend$people_char_23,
                         Q1_weekend$people_char_24,
                         Q1_weekend$people_char_25,
                         Q1_weekend$people_char_26,
                         Q1_weekend$people_char_27,
                         Q1_weekend$people_char_28,
                         Q1_weekend$people_char_29,
                         Q1_weekend$people_char_30,
                         Q1_weekend$people_char_31,
                         Q1_weekend$people_char_32,
                         Q1_weekend$people_char_33,
                         Q1_weekend$people_char_34,
                         Q1_weekend$people_char_35,
                         Q1_weekend$people_char_36,
                         Q1_weekend$people_char_37,
                         Q1_weekend$people_char_38,
                         Q1_weekend$act_week,
                         Q1_weekend$people_week,
                         Q1_weekend$people_month,
                         Q1_weekend$act_month
)

train.sparse=Q1_weekend.sparse[1:nrow(Q1_weekend_train),]
test.sparse=Q1_weekend.sparse[(nrow(Q1_weekend_train)+1):nrow(Q1_weekend.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s1 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q1_weekend,Q1_weekend_train,Q1_weekend.sparse)
####Q1_weekdays####
Q1_week_train=Q1_train[(Q1_train$week_date!=1 & Q1_train$week_date!=7),]
Y=Q1_week_train$outcome
Q1_week_train$outcome=NULL
Q1_week=rbind(Q1_week_train,X_test)
Q1_week$i=1:dim(Q1_week)[1]


Q1_week.sparse=
  cBind(sparseMatrix(Q1_week$i,Q1_week$activity_category),
        sparseMatrix(Q1_week$i,Q1_week$people_group_1),
        sparseMatrix(Q1_week$i,Q1_week$char_1),
        sparseMatrix(Q1_week$i,Q1_week$char_2),
        sparseMatrix(Q1_week$i,Q1_week$char_3),
        sparseMatrix(Q1_week$i,Q1_week$char_4),
        sparseMatrix(Q1_week$i,Q1_week$char_5),
        sparseMatrix(Q1_week$i,Q1_week$char_6),
        sparseMatrix(Q1_week$i,Q1_week$char_7),
        sparseMatrix(Q1_week$i,Q1_week$char_8),
        sparseMatrix(Q1_week$i,Q1_week$char_9),
        sparseMatrix(Q1_week$i,Q1_week$people_char_2),
        sparseMatrix(Q1_week$i,Q1_week$people_char_3),
        sparseMatrix(Q1_week$i,Q1_week$people_char_4),
        sparseMatrix(Q1_week$i,Q1_week$people_char_5),
        sparseMatrix(Q1_week$i,Q1_week$people_char_6),
        sparseMatrix(Q1_week$i,Q1_week$people_char_7),
        sparseMatrix(Q1_week$i,Q1_week$people_char_8),
        sparseMatrix(Q1_week$i,Q1_week$people_char_9)
  )

Q1_week.sparse= cBind(Q1_week.sparse,
                      Q1_week$people_char_10,
                      Q1_week$people_char_11,
                      Q1_week$people_char_12,
                      Q1_week$people_char_13,
                      Q1_week$people_char_14,
                      Q1_week$people_char_15,
                      Q1_week$people_char_16,
                      Q1_week$people_char_17,
                      Q1_week$people_char_18,
                      Q1_week$people_char_19,
                      Q1_week$people_char_20,
                      Q1_week$people_char_21,
                      Q1_week$people_char_22,
                      Q1_week$people_char_23,
                      Q1_week$people_char_24,
                      Q1_week$people_char_25,
                      Q1_week$people_char_26,
                      Q1_week$people_char_27,
                      Q1_week$people_char_28,
                      Q1_week$people_char_29,
                      Q1_week$people_char_30,
                      Q1_week$people_char_31,
                      Q1_week$people_char_32,
                      Q1_week$people_char_33,
                      Q1_week$people_char_34,
                      Q1_week$people_char_35,
                      Q1_week$people_char_36,
                      Q1_week$people_char_37,
                      Q1_week$people_char_38,
                      Q1_week$act_week,
                      Q1_week$people_week,
                      Q1_week$people_month,
                      Q1_week$act_month
)
train.sparse=Q1_week.sparse[1:nrow(Q1_week_train),]
test.sparse=Q1_week.sparse[(nrow(Q1_week_train)+1):nrow(Q1_week.sparse),]
dtrain  <- xgb.DMatrix(train.sparse, label = Y)
dtest  <- xgb.DMatrix(test.sparse)

s2 <- data.frame(activity_id = X_test$activity_id, outcome = out)

rm(Q1_week_train,Q1_week.sparse,Q1_week,Q1_train)
