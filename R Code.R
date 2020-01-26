if(!require("rtweet")) install.packages("rtweet"); library("rtweet")
if(!require("tidyverse")) install.packages("tidyverse"); library("tidyverse")
if(!require("dplyr")) install.packages("dplyr");library("dplyr")


app = 'SM_Analytics2'
consumer_key = 'Q7ZImLaSbzEvmVqaOKOmDhBFa'
consumer_secret = 'sZKq1n0kYkBxXKLKIJxBUVIwovr27cYQTdoPQILOtyWAdQyFN5'
access_token = '3389686869-nmPa3uUD0qtESMaKEkdq1E8Cep66d9f5Y0LZ6YB'
access_secret = 'l1Wg2gzzAxgxXMWCL12K7sZndEehg7kfnKiwA6kD04aZm'

twitter_token <- create_token(
  app = app,
  consumer_key = consumer_key,
  consumer_secret = consumer_secret,
  access_token = access_token,
  access_secret = access_secret,
  set_renv=FALSE)


#Searching tweets by users from the company T-Mobile
tm_mobile_company<-get_timeline(user=c('TMobileTruckPHM','TMobile','T_Labs','TMobileHelp','JohnLegere','SievertMike',
                                'MetroByTMobile','TMobileArena','TMobilePark','tmobilecareers','TMobileBusiness',
                                'TMobileIR','TMobileNews'), n = 5000, include_rts=FALSE)

save(tm_mobile_company, file = "C:/Users/azambranollano/OneDrive - IESEG/Alejandra/Social Media Analytics/Group Project/userscompany.RData")

#Searching tweets by keywords
t_mobile2<- search_fullarchive(q = "#AreYouWithUs", n = 10000,env_name="Class1",fromDate="201911010000",toDate="202001200000")
load('C:/Users/azambranollano/OneDrive - IESEG/Alejandra/Social Media Analytics/Group Project/t_mobile2.RData')
tm_mobile3<-search_30day(q='#AreYouWithUs', n=5000,env_name = 'tweets30')
tm_mobile4<-search_30day(q='#TmobileTruck', n=5000,env_name = 'tweets30')
tm_mobile5<-search_30day(q='#BeMagenta', n=5000,env_name = 'tweets30')

#Joining tweets
tm_mobile=rbind.data.frame(t_mobile2,tm_mobile3,tm_mobile4,tm_mobile5)

#removing duplicated tweets
tm_mobile=tm_mobile[!duplicated(tm_mobile$status_id),]

#Keeping tweets differents from users of the company
tm_mobile=anti_join(tm_mobile, tm_mobile_company, by="status_id")

save(tm_mobile, file = "C:/Users/azambranollano/OneDrive - IESEG/Alejandra/Social Media Analytics/Group Project/tmhashtags.RData")


# '#TmobileTruck','#BeMagenta','#IamMagenta','#TeamMagenta',
#                         '#TeamMetro','#TMobileBusiness','#TMUS','#TMobileTuesdays',n=6000,env_name = 'tweets30')


