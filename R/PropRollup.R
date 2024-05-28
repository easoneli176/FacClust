#' creates a dataframe of proportions of each factor level within a group
#'
#' @param facvar a categorical vector
#' @param groupvar the variable to be grouped by
#' @param weightvar the variable to weight by if we desire a weighted mean for the calculation
#' @return a dataframe
#' @examples
#' mock_data <- data.frame(fac = c(rep("A",10),rep("B",10),rep("C",10)),grp=c(rep("G1",15),rep("G2",15)))
#' PropRollup(mock_data$fac,mock_data$grp)

PropRollup<-function(facvar,groupvar,weightvar=rep(1,length(facvar))){
  start<-onehot(facvar)
  lvls<-colnames(start)
  start$ID<-groupvar
  start$weight<-weightvar

  dflist<-list()

  for (i in 1:length(lvls)){
    dflist[[i]]<-ddply(start, .(ID),
                       function(x) data.frame(Prop = weighted.mean(x[,i],x$weight)))

  }

  Tot<-as.data.frame(dflist[[1]])
  colnames(Tot)[2]<-lvls[1]

  for (i in 2:length(lvls)){
    newdf<-as.data.frame(dflist[[i]])
    Tot<-Tot %>%
      left_join(newdf,by="ID")
    colnames(Tot)[i+1]<-lvls[i]
  }

  Tot
}
