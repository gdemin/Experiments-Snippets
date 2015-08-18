# Extending R's summary function (or creating a new function with similar
# output) to display factors as percent of total

# Is there a way to easily extend R's summary() function (or to create a new
# function with similar output) to display factors as a percent of the total?
# http://stackoverflow.com/questions/32080146/extending-rs-summary-function-or-creating-a-new-function-with-similar-output


# backup original summary.factor
original_summary_factor = base::summary.factor

# our new summary.factor
summary.factor = function(object,maxsum = 100, ...){
    res = original_summary_factor(object = object, maxsum = maxsum, ...)
    pct = round(res/length(object)*100)
    
    
    setNames(paste0(res, " ", pct, "%"),names(res))
}

# DANGEROUS CODE. USE IT AT YOUR OWN RISK.
# Here we replace original summary.factor with new one
unlockBinding("summary.factor", as.environment("package:base"))
assignInNamespace("summary.factor", summary.factor, ns="base", envir=as.environment("package:base"))
assign("summary.factor", summary.factor, as.environment("package:base"))
lockBinding("summary.factor", as.environment("package:base"))

summary(chickwts)
# weight             feed       
# Min.   :108.0   casein   :12 17%  
# 1st Qu.:204.5   horsebean:10 14%  
# Median :258.0   linseed  :12 17%  
# Mean   :261.3   meatmeal :11 15%  
# 3rd Qu.:323.5   soybean  :14 20%  
# Max.   :423.0   sunflower:12 17% 

summary(chickwts)
summary(chickwts$feed)
summary.factor(chickwts$feed)

chickwts[1:3,2] = NA

 