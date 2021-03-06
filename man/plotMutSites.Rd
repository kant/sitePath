% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SNPsites.R
\name{plotMutSites}
\alias{plotMutSites}
\alias{plotMutSites.SNPsites}
\title{Plot tree and mutation sites}
\usage{
\method{plotMutSites}{SNPsites}(x, showTips = FALSE, ...)
}
\arguments{
\item{x}{An \code{\link{SNPsites}} object.}

\item{showTips}{Whether to plot the tip labels. The default is \code{FALSE}.}

\item{...}{Other arguments}
}
\value{
A tree plot with SNP as dots for each tip.
}
\description{
The mutated sites for each tip in a phylogenetic tree will be
  represented as colored dots positioned by their site number.
}
\examples{
data(zikv_tree_reduced)
data(zikv_align_reduced)
tree <- addMSA(zikv_tree_reduced, alignment = zikv_align_reduced)
plotMutSites(SNPsites(tree))
}
