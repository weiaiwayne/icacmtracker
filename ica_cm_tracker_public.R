library(rtweet)
library(glue)

mytoken <- create_token(
  app = "",
  consumer_key = "",
  consumer_secret = "",
  access_token = "",
  access_secret = "")

friends <- get_friends("ica_cm")

#timeline1 <- get_timelines(friends$user_id, n = 10, token = mytoken,check = TRUE)

#loop over to get each friend's recent tweets
get_timeline_unlimited <- function(users, n){
  if (length(users) ==0){
    return(NULL)
  }
  
  rl <- rate_limit(query = "get_timeline")
  
  if (length(users) <= rl$remaining){
    print(glue("Getting data for {length(users)} users"))
    tweets <- get_timeline(users, n, check = FALSE)  
  }else{
    
    if (rl$remaining > 0){
      users_first <- users[1:rl$remaining]
      users_rest <- users[-(1:rl$remaining)]
      print(glue("Getting data for {length(users_first)} users"))
      tweets_first <- get_timeline(users_first, n, check = FALSE)
      rl <- rate_limit(query = "get_timeline")
    }else{
      tweets_first <- NULL
      users_rest <- users
    }
    wait <- rl$reset + 0.1
    print(glue("Waiting for {round(wait,2)} minutes"))
    Sys.sleep(wait * 60)
    
    tweets_rest <- get_timeline_unlimited(users_rest, n)  
    tweets <- bind_rows(tweets_first, tweets_rest)
  }
  return(tweets)
}

timeline <- get_timeline_unlimited(friends$user_id,10)

#timeline_plusrt <- get_timeline_unlimited(friends$user_id,10)

save(timeline, file="file.rda")


#### 
link <- timeline[!is.na(timeline$urls_expanded_url),]
link$urls_expanded_url <- gsub(".*facebook.com.*", "", link$urls_expanded_url)
link$urls_expanded_url <- gsub(".*twitter.com.*", "", link$urls_expanded_url)
link <- link[!is.na(link$urls_expanded_url),]
link <- link[link$urls_expanded_url !="",]
colnames(link)


link <- link[,c("urls_expanded_url","text","retweet_count","favorite_count")]
link1 <- link[order(link$favorite_count,decreasing =TRUE),]
link1 <- link1[1:100,]
link2 <- link[order(link$retweet_count,decreasing =TRUE),]
link2 <- link2[1:100,]
link <- rbind(link1,link2)
link <- link[!duplicated(link$urls_expanded_url),]

save(link, file="link.rda")
##

rmarkdown::render("ICA_CM_Tracker.Rmd", "html_document")
