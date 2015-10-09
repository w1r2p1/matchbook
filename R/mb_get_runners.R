#' Get List of Available Runners for a given Market
#' @name mb_get_runners
#' @description List the Runners Available on Matchbook.com for a given Market
#' @param session_data A session object returned from a successful mb_login attempt. It contains details about your user preferences and security details.
#' @param event_id The event_id integer for the associated market.
#' @param market_id The market_id integer for which a list of associated runners is required.
#' @param runner_id If you only require details for a single runner, specify this optional runner_id integer. 
#' @param side A filter to allow selection of either 'back' or 'lay' bets. The default is to return 'back' bets.
#' @param runner_states A vector of string containing the runner states to return. Defaults to 'open' or 'suspended' market types.
#' @param include_prices A boolean parameter indicating if the runner prices should be returned or not. Defaults to FALSE.
#' @return If successful, a dataframe with associated runner information. 
#' @seealso \code{\link{mb_get_sports},\link{mb_get_events},\link{mb_get_markets}}
#' @export 
#' @examples
#' \dontrun{my_session <- mb_login("my_user_name","my_password"); 
#' mb_get_runners(session_data=my_session,event_id=123456,market_id=1234567)}
#' 

mb_get_runners <- function(session_data,event_id,market_id,runner_id=NULL,side=c("back","lay"),runner_states = c("open","suspended"),include_prices=FALSE)
{
  #event_id <- 309912;market_states = c("open","suspended");market_types=c("multirunner","binary");grading_types=c('asian-handicap','high-score-wins','low-score-wins','point-spread','point-total','single-winner-wins');language="en";include_runners=TRUE;include_prices=TRUE
  valid_runner_states<- c("suspended","open")
  valid_sides        <- c("back","lay")
  
  content            <- NULL
  if(is.null(session_data)){
    print(paste("You have not provided data about your session in the session_data parameter. Please execute mb_login('my_user_name','verysafepassword') and save the resulting object in a variable e.g. my_session <- mb_login(username,pwd); and pass session_data=my_session as a parameter in this function."));return(content)
  }
  if(event_id%%1>0){
    print(paste("The event_id must be an integer. Please amend and try again."));return(content)
  }
  if(length(event_id)>1){
    print(paste("The event_id must be a single integer. Please amend and try again."));return(content)
  }
  if(market_id%%1>0){
    print(paste("The market_id must be an integer. Please amend and try again."));return(content)
  }
  if(length(market_id)>1){
    print(paste("The market_id must be a single integer. Please amend and try again."));return(content)
  }
  if(sum(!is.element(side,valid_sides))>0){
    print(paste("All sides values must be one of",paste(valid_sides,collapse=","),". Please amend and try again."));return(content)
  }
  if(sum(!is.element(runner_states,valid_market_states))>0){
    print(paste("All runner_states values must be one of",paste(valid_runner_states,collapse=","),". Please amend and try again."));return(content)
  }
  if(sum(runner_id%%1)>0) {print(paste("The runner_id values must be in integer format. Please amend and try again."));return(content)}
  if(length(runner_id)>1){
    print(paste("The runner_id must be a single integer. Please amend and try again."));return(content)
  }
  
  param_list         <- list('exchange-type'='back-lay','odds-type'=session_data$odds_type,currency=session_data$currency,'states'=paste(runner_states,collapse=","),side=paste(side,collapse=","))
  if(include_prices){
    param_list <- c(param_list,'include-prices'='true')
  }
  runner_url_comp    <- ""
  if(!is.null(runner_id)){
    runner_url_comp    <- paste("/",runner_id,sep="")
  }
  get_runners_resp    <- GET(paste("https://www.matchbook.com/bpapi/rest/events/",event_id,"/markets/",market_id,"/runners",runner_url_comp,sep=""),query=param_list,set_cookies('session-token'=session_data$session_token),add_headers('User-Agent'='rlibnf'))
  status_code        <- get_runners_resp$status_code  
  if(status_code==200)
  {
    content <- fromJSON(content(get_runners_resp, "text", "application/json"))$runners
  } else
  {
    print(paste("Warning/Error in communicating with https://www.matchbook.com/bpapi/rest/events/",event_id,"/markets",sep=""))
  }
  return(content)
}