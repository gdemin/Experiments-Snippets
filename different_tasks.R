# Гмурман глава 1, задача 3
res2 = replicate(1000,{
  rnd = sample(10:99,1)
  res = replicate(1000,{
    guess1 = sample(10:99,1)
    
    guess2_1 = sample(1:9,1)
    guess2_2 = sample(setdiff(0:9,guess2_1),1)
    guess2 = guess2_1*10+guess2_2
    
    c(guess1==rnd, guess2==rnd)
  })
  

  rowMeans(res) # 1/90
})

1/90
rowMeans(res2)  # вроде похоже, что в обоих случаях одинаковый ответ, но на самом деле во втором случае должна быть 1/81


######################

for (i in 1:100){
    if (i %% 3==0) cat("fizz")
    if (i %% 5==0) cat("buzz")
    if (i %% 3!=0 & i%% 5!=0) cat(i)
    cat("\n") # перевести на другую строчку курсор
    
}



p1 = .1
p2 = .2
p3 = .3
p4 = .4
q1 = 1 - p1
q2 = 1 - p2
q3 = 1 - p3
q4 = 1 - p4

pa = p1*p2*q3*q4 + p1*q2*p3*q4 + p1*q2*q3*p4 + q1*p2*q3*p4 + q1*q2*p3*p4 + q1*p2*p3*q4 


p1*p2*q3*q4/pa

############

pop = sample(0:1, 1000000, replace = TRUE,prob = c(0.99,.01)) # 0 - здоров, 1 - болен

healthy = sample(0:1,length(pop),replace = TRUE, prob = c(.99,.01))
ill = sample(0:1,length(pop),replace = TRUE, prob = c(.01,.99))


test = ifelse(pop ==0, healthy, ill)

# ожидаем 0.5
mean(pop[test==1])


###########
# gmurman 115
p = 0.51
q = 1 - p

dbinom(2,5,p) # a 0.306005
pbinom(2,5,p) # b 0.481255
1 - pbinom(2,5,p) # c 0.51874

dbinom(2,5,p) + dbinom(3,5,p) # d 0.6245001



# gmurman 116
p = 1/3

dbinom(2,4,p) # 0.2962963

# gmurman 118
p = 1/4

dbinom(2,8,1/4)*dbinom(2,6,1/3)*dbinom(2,4,1/2) # 0.03845215


if(!require(excel.link)) {
    .libPaths('C:/Users/gregory/AppData/Local/Temp/RLibrary') 
    if(!require(excel.link)) {
        library(tcltk); 
        res = tkmessageBox(message = 'Package \'excel.link\' not found. Would you like to install it?', title = 'R',type='okcancel'); 
        if (tclvalue(res) == 'ok') {
            install.packages('excel.link', repos = c('http://cran.at.r-project.org/', 'http://www.stats.ox.ac.uk/pub/RWin'),dependencies = c('Depends', 'Imports', 'LinkingTo', 'Suggests','Enhances')); 
            if(!require(excel.link)) {tkmessageBox(message = 'Something going wrong. Quitting.', title = 'R'); q(); }} 
        else {q()} 
    }}




###########

########### gmurman

p = 0.2
q = 1 - p
eps = .04


f = function(N) eps*sqrt(N/p/q)

N = 664
pnorm(f(N)) - pnorm(-f(N)) 

##### 138

p = 0.8
q = 1 - p
eps = .01


f = function(N) eps*sqrt(N/p/q)


optim(par = 100, fn = function(N) abs(pnorm(f(N)) - pnorm(-f(N)) - 0.95), lower = 2, upper = 1e6, method = "L-BFGS-B") 

### 139 

N = 400
p = 0.8
q = 1 - p

dev = sqrt(p*q/N)
prob = .99

eps2 = qnorm(c((1-prob)/2,(1+prob)/2))[2]
eps2*dev

### 140 

N = 900
p = 0.5
q = 1 - p

dev = sqrt(p*q/N)
prob = .77

eps2 = qnorm(c((1-prob)/2,(1+prob)/2))[2]
eps2*dev

### 141 

N = 10000
p = 0.75
q = 1 - p

dev = sqrt(p*q/N)
prob = .98

eps2 = qnorm(c((1-prob)/2,(1+prob)/2))[2]
eps2*dev

### 142 

N = 900
p = 0.9
q = 1 - p

dev = sqrt(p*q/N)
prob = .95

eps2 = qnorm(c((1-prob)/2,(1+prob)/2))[2]
eps = eps2*dev


cat((p-eps)*N,(p+eps)*N,"\n")


### 143 

N = 475
p = 0.05
q = 1 - p

dev = sqrt(p*q/N)
prob = .95

eps2 = qnorm(c((1-prob)/2,(1+prob)/2))[2]
eps = eps2*dev


cat((p-eps)*N,(p+eps)*N,"\n")

### 144 

N = 80
p = 1/6
q = 1 - p

dev = sqrt(p*q/N)
prob = .99

eps2 = qnorm(c((1-prob)/2,(1+prob)/2))[2]
eps = eps2*dev


cat((p-eps)*N,(p+eps)*N,"\n")


####  

library(dplyr)

x = data.frame(dat = rnorm(500))

x  %>% mutate(groups = cut(dat,c(-Inf,-1,0,1,Inf)))  %>% group_by(groups)  %>% summarize(med_dat = median(dat), count = n())




######### manipulate

library(manipulate)
f = function(t,a=6,b=2,d=4,e=14) { exp(1i*t)+exp(a*1i*t)/b+1i/d*exp(-1i*e*t)}
manipulate(plot(Re(f(seq(0,maxt,0.01),a,b,d,e)),Im(f(seq(0,maxt,0.01),a,b,d,e)),type="l"),
           maxt = slider(0,100,step=0.1, initial = 5),
           a = slider(.1,20,step=0.5, initial = 6),
           b = slider(.1,20,step=0.5, initial = 2),
           d = slider(.1,20,step=0.5, initial = 4),
           e = slider(.1,20,step=0.5, initial = 14)
           )


########## gmurman #######

######## s4 classes ############

setGeneric("my_method", function(a_number, a_string) {
    standardGeneric("my_method")
})

setMethod("my_method", signature(a_number = "numeric", a_string = "character"), 
          function(a_number, a_string) {
                paste0(a_string, a_number)
})


my_method(1, "fsdfds")
my_method("fsdfds", 1)


setOldClass("superclass")
setOldClass("fsd6fds")

setMethod("my_method", signature(a_number = "superclass", a_string = "character"), 
          function(a_number, a_string) {
              paste0(a_string, a_number)
          })



a = "sfsdf"
class(a) = "superclass"

my_method(a, "fsd6fds")

b = a
class(b) = union("sfvsfv",class(b))

my_method(b, "fsd6fds")
my_method(1L, "fsd6fds")


