% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mb_get_markets.R
\name{mb_get_markets}
\alias{mb_get_markets}
\title{Get List of Available Markets for a given Event}
\usage{
mb_get_markets(session_data, event_id, market_states = c("open", "suspended"),
  market_types = c("multirunner", "binary"), grading_types = NULL,
  include_runners = FALSE, include_prices = FALSE)
}
\arguments{
\item{session_data}{A session object returned from a successful mb_login attempt. It contains details about your user preferences and security details.}

\item{event_id}{The event_id integer for which a list of associated markets is required.}

\item{market_states}{A vector of string containing the market states to return. Defaults to 'open' or 'suspended' market types.}

\item{market_types}{A vector of strings containing the required market types. Valid market types are either 'multirunner' or 'binary'. Both are returned by default.}

\item{grading_types}{An optional vector of strings containing the required grading types. Valid grading types are 'one_x_two','asian-handicap','high-score-wins','low-score-wins','point-spread','point-total','single-winner-wins'. All are returned by default.}

\item{include_runners}{A boolean parameter indicating if the runner names and id should be returned or not. Defaults to FALSE.}

\item{include_prices}{A boolean parameter indicating if the runner prices should be returned or not. Defaults to FALSE.}
}
\value{
If successful, a dataframe with first 500 markets and associated information. Only 500 markets are permitted at one time. Pagination is possible but not implemented here.
The data frame has the following fields:
 \describe{
  \item{name}{Market name}
  \item{start}{The start date of the market}
  \item{status}{If betting is still available on this market it will have status='open'}
  \item{type}{Market name}
  \item{event-id}{Event id}
  \item{id}{Market id}
  \item{runner-ids}{The ids of runners in this market}
  \item{grading-type}{The type of grading}
  \item{in-running-flag}{Is the market currently in-running}
  \item{allow-live-betting}{Is it possible for this market to go in running}
  \item{handicap}{The handicap associated with this market, if any}
}
If include_runners=TRUE, then additional runner information is returned. Also if include_prices=TRUE then price data for the associated runner is returned nested within the data frame.
}
\description{
List the Markets Available on Matchbook.com for a given Event
}
\examples{
\dontrun{my_session <- mb_login("my_user_name","my_password"); 
mb_get_markets(event_id=309912)}

}
\seealso{
\code{\link{mb_get_sports},\link{mb_get_events},\link{mb_get_runners}}
}

