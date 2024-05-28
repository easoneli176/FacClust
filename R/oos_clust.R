#' assigns clusters to out of sample data
#'
#' @param x the object to have a cluster assigned
#' @return a cluster
#' @examples
#' km must already be a named kmeans object
#' mock_data <- data.frame(fac = c(rep("A",10),rep("B",10),rep("C",10),rep("D",10),rep("E",10),rep("F",10)),grp=c(rep("G1",15),rep("G2",15),rep("G3",15),rep("G4",15)))
#' df<-PropRollup(mock_data$fac,mock_data$grp)
#' set.seed(278613)
#' km<-kmeans(x=df[,-1],centers=2)
#' oos_clust(df[1,-1])
#' clusters<-apply(df[,-1], 1, oos_clust)

oos_clust<-function(x){
  cluster.dist <- apply(km$centers, 1, function(y) sqrt(sum((x-y)^2)))
  return(which.min(cluster.dist)[1])
}
