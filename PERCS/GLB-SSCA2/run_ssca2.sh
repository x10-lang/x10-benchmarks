## some numbers that can play around: 
# -i interval default is 8 it means process 8 vertices in a batch, i is [1,2,4,8,...2^n], the larger this number is, the better locality is, however the less flexibility we have
# -l base of the lifeline, default is 2, which gives the largest possible number of lifelinebuddies, in a embarassingly parallel program, u want your lifeline buddies to be many, so that you can deal out your workload fast.
./MySSCA2 -n 12
