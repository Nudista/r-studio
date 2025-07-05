y = data.frame(a = 1,b = "a")
dput(y)

dput(y,file = "y.R")
new.y = dget("y.R")
new.y

x ="foo"
y = data.frame(a = 1,b = "a")


dump(c("x","y"),file = "data.R")
rm(x,y)


source("data.R")
str(y)

#dplyr
library(dplyr)

##筛选
###select
data("iris")
iris2 = tbl_df(iris)
select(iris,1:2)
select(iris,c(1,2))
select(iris,c("Sepal.Length","Sepal.Width"))
select(iris,-Species)
grep("Sepal",colnames(iris))
select(iris,grep("Sepal",colnames(iris)))


##辅助函数
select(iris,contains("."))
select(iris,starts_with("Sepal"))
select(iris,ends_with("Length"))
select(iris,everything())
select(iris,one_of("Species","uuuuuu"))
select(iris,matches(".t."))
select(iris,num_range("x",1:5))



##行选取函数
###filter
filter(iris,Sepal.Length>5)

###slice
slice(iris,1:5)

###distinct
distinct(iris)

###sample
sample_frac(iris,0.1,repalce =F)
sample_n(iris,10,replace = F)

###arrange
arrange(iris,Sepal.Length)
arrange(iris,desc(Sepal.Length))

##合并
通过相同列名(需要取名)
a =1:10
b = 7:20
df1 = cbind(a,a^2)
df2 = cbind(b,b^3)
colnames(df1) = c("x1","x2")
df1 = as_tibble(df1)
colnames(df2) = c("x1","x3")
df2 = as_tibble(df2)
left_join(df1,df2)

##生成
mutate(iris,Petal.size = Petal.Length + Petal.Width)
mutate(iris,lag(Petal.Length))
mutate(iris,cumsum(Sepal.Length))

##归纳
搭配group by
summarise(group_by(iris,Species),mean(Sepal.Length))

#tidyr
library("tidyr")
iris.dt = is.tibble(data.frame("id" = 1:nrow(iris),iris)) %>% 
    gather(measure,value,Sepal.Length:Petal.Width) %>% 
    arrange(id)
