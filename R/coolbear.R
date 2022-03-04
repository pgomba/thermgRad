#' Obtain T50 values
#'
#' Obtain T50 values using Coolbear et al. (1984) formula modified by Farooq et al.(2005). Vector containing scoring days must have same lenght than vector containing cumulative germination data
#'
#' @param day A vector containing scoring days
#' @param cumulative A vector containing the cumulative germination for each day
#' @param n Number of viable seeds in the Petri dish (Total sown seeds - empty seeds)
#'
#' @return t50 value in days
#' @export
#'
#' @examples
#' coolbear(seq(1,10,1),c(0,0,0,0,0,6,12,15,18,20),20)
#'
#'
coolbear <- function(day,cumulative,n) {
  if (max(cumulative)<n/2){ #If germination is under 50%, is not possible to calculate T50
    t50<-"NA"
    return(t50)
  }
  if (max(cumulative)==n/2){ #If maximum germination is 50% of viable seeds, T50 is time to reach maximum germination
    t50<-day[min(which(cumulative==n/2))]
    return(t50)
  }
  if (any(n/2==cumulative)){ #If exactly 50% germination is reached in a day, T50 is that day. Same formula than before... merge eventually
    t50<-day[min(which(cumulative==n/2))]
    return(t50)
  }
  else{
    ni<-cumulative[sum(cumulative<=n/2)]
    nj<-cumulative[sum(cumulative<=n/2)+1]
    ti<-day[sum(cumulative<=n/2)]
    tj<-day[sum(cumulative<=n/2)+1]
    t50<- ti+(((n/2-ni)*(ti-tj))/(ni-nj))
    return(t50)
  }
}
