
<!-- README.md is generated from README.Rmd. Please edit that file -->

# FactClust

<!-- badges: start -->
<!-- badges: end -->

The goal of FactClust is to simplify the clustering algorithm for factor
variables with many levels when the data needs to be rolled up.

## Installation

You can install the development version of FactClust from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("easoneli176/FactClust")
```

## Example

When we have a factor variable with many levels, and we need to rollup
the data by some grouping factor and calculate clusters, we begin by
one-hot encoding the factor variable using the onehot function:

``` r
library(FacClust)
#> Loading required package: plyr
#> Loading required package: dplyr
#> Warning: package 'dplyr' was built under R version 4.2.3
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:plyr':
#> 
#>     arrange, count, desc, failwith, id, mutate, rename, summarise,
#>     summarize
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
#> Warning: replacing previous import 'plyr::summarize' by 'dplyr::summarize' when
#> loading 'FacClust'
#> Warning: replacing previous import 'plyr::mutate' by 'dplyr::mutate' when
#> loading 'FacClust'
#> Warning: replacing previous import 'plyr::id' by 'dplyr::id' when loading
#> 'FacClust'
#> Warning: replacing previous import 'plyr::arrange' by 'dplyr::arrange' when
#> loading 'FacClust'
#> Warning: replacing previous import 'plyr::summarise' by 'dplyr::summarise' when
#> loading 'FacClust'
#> Warning: replacing previous import 'plyr::rename' by 'dplyr::rename' when
#> loading 'FacClust'
#> Warning: replacing previous import 'plyr::desc' by 'dplyr::desc' when loading
#> 'FacClust'
#> Warning: replacing previous import 'plyr::count' by 'dplyr::count' when loading
#> 'FacClust'
#> Warning: replacing previous import 'plyr::failwith' by 'dplyr::failwith' when
#> loading 'FacClust'

mock_data <- data.frame(fac = c(rep("A",10),rep("B",10),rep("C",10),rep("D",10),rep("E",10),rep("F",10)),grp=c(rep("G1",15),rep("G2",15),rep("G3",15),rep("G4",15)))

onehot(mock_data$fac)
#>    A B C D E F
#> 1  1 0 0 0 0 0
#> 2  1 0 0 0 0 0
#> 3  1 0 0 0 0 0
#> 4  1 0 0 0 0 0
#> 5  1 0 0 0 0 0
#> 6  1 0 0 0 0 0
#> 7  1 0 0 0 0 0
#> 8  1 0 0 0 0 0
#> 9  1 0 0 0 0 0
#> 10 1 0 0 0 0 0
#> 11 0 1 0 0 0 0
#> 12 0 1 0 0 0 0
#> 13 0 1 0 0 0 0
#> 14 0 1 0 0 0 0
#> 15 0 1 0 0 0 0
#> 16 0 1 0 0 0 0
#> 17 0 1 0 0 0 0
#> 18 0 1 0 0 0 0
#> 19 0 1 0 0 0 0
#> 20 0 1 0 0 0 0
#> 21 0 0 1 0 0 0
#> 22 0 0 1 0 0 0
#> 23 0 0 1 0 0 0
#> 24 0 0 1 0 0 0
#> 25 0 0 1 0 0 0
#> 26 0 0 1 0 0 0
#> 27 0 0 1 0 0 0
#> 28 0 0 1 0 0 0
#> 29 0 0 1 0 0 0
#> 30 0 0 1 0 0 0
#> 31 0 0 0 1 0 0
#> 32 0 0 0 1 0 0
#> 33 0 0 0 1 0 0
#> 34 0 0 0 1 0 0
#> 35 0 0 0 1 0 0
#> 36 0 0 0 1 0 0
#> 37 0 0 0 1 0 0
#> 38 0 0 0 1 0 0
#> 39 0 0 0 1 0 0
#> 40 0 0 0 1 0 0
#> 41 0 0 0 0 1 0
#> 42 0 0 0 0 1 0
#> 43 0 0 0 0 1 0
#> 44 0 0 0 0 1 0
#> 45 0 0 0 0 1 0
#> 46 0 0 0 0 1 0
#> 47 0 0 0 0 1 0
#> 48 0 0 0 0 1 0
#> 49 0 0 0 0 1 0
#> 50 0 0 0 0 1 0
#> 51 0 0 0 0 0 1
#> 52 0 0 0 0 0 1
#> 53 0 0 0 0 0 1
#> 54 0 0 0 0 0 1
#> 55 0 0 0 0 0 1
#> 56 0 0 0 0 0 1
#> 57 0 0 0 0 0 1
#> 58 0 0 0 0 0 1
#> 59 0 0 0 0 0 1
#> 60 0 0 0 0 0 1
```

Next, we calculate proportions of each factor level within each group.
We can optionally use a weighting variable here to make the proportions
weighted.

``` r
df<-PropRollup(mock_data$fac,mock_data$grp)
df
#>   ID         A         B         C         D         E         F
#> 1 G1 0.6666667 0.3333333 0.0000000 0.0000000 0.0000000 0.0000000
#> 2 G2 0.0000000 0.3333333 0.6666667 0.0000000 0.0000000 0.0000000
#> 3 G3 0.0000000 0.0000000 0.0000000 0.6666667 0.3333333 0.0000000
#> 4 G4 0.0000000 0.0000000 0.0000000 0.0000000 0.3333333 0.6666667
```

Next, we can calculate clusters on these proportions using kmeans from
the base R package. The number of clusters, k, should be determined
outside this package.

``` r
set.seed(278613)
km<-kmeans(x=df[,-1],centers=2)
km
#> K-means clustering with 2 clusters of sizes 2, 2
#> 
#> Cluster means:
#>           A         B         C         D         E         F
#> 1 0.0000000 0.0000000 0.0000000 0.3333333 0.3333333 0.3333333
#> 2 0.3333333 0.3333333 0.3333333 0.0000000 0.0000000 0.0000000
#> 
#> Clustering vector:
#> [1] 2 2 1 1
#> 
#> Within cluster sum of squares by cluster:
#> [1] 0.4444444 0.4444444
#>  (between_SS / total_SS =  42.9 %)
#> 
#> Available components:
#> 
#> [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
#> [6] "betweenss"    "size"         "iter"         "ifault"
```

Finally, as long as we have named our kmeans object km, we can assign
clusters to out of sample data using this function:

``` r
apply(df[,-1], 1, oos_clust)
#> [1] 2 2 1 1
```
