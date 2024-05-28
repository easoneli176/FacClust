#' creates a dataframe of one hot encoding for a factor variable
#'
#' @param facvar a categorical vector
#' @return a dataframe
#' @examples
#' mock_data <- data.frame(fac = c(rep("A",10),rep("B",10),rep("C",10)))
#' onehot(mock_data$fac)

onehot<-function(facvar){
  #could use levels function if it's a factor,
  #but this allows for characters to work too
  lvls<-names(table(facvar))

  df<-as.data.frame(matrix(0,ncol = length(lvls),nrow = length(facvar)))

  colnames(df)<-lvls

  for (i in 1:length(facvar)){
    updt<-which(colnames(df) == facvar[i])
    df[i,updt]<-1
  }

  df
}
