# redhat_kaggle
First kaggle project


This is my first kaggle project organised by Red Hat , where 2302 teams
participated to classify the potential costumer based on the attributes
which were maseked , i e people charcteristics and other business
characteristics that are know as activity characteristics .
During the early phase of the competition it was identified that it had
a leakage ( where the train data set is used to predict test outcome ,
by laiso and his team mates ) , so this competition sticks to only rows
of 69k which was not covered by the leakage .
According to the business point of view i divided the people data into
- Weekdays
- Weekends
- Quater 1
- Q2
- Q3
- Q4



to over come the overfiting i predict this 8 train with the test and
scured a score of 0.991533(by taking the geometric mean of the predicted
value)(public leaderboard) , and this all thing was done in the sparse matrix , and then i
took the weighted average with earlier script which was giving 0.991647
, and secured a rank of 198 (~top 10%) and a score of 0.991750 and hopefully my first bronze
medal out of 2302 teams.
I must say this one month i learnt alot and want to learn from the
fellow kagglers / master / grandmaster .
Regards
Aman Kapoor
