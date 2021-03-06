% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotSingleSite.R
\name{plotSingleSite}
\alias{plotSingleSite}
\alias{plotSingleSite.lineagePath}
\alias{plot.sitePath}
\alias{plotSingleSite.fixationSites}
\alias{plotSingleSite.multiFixationSites}
\title{Color the tree by a single site}
\usage{
\method{plotSingleSite}{lineagePath}(x, site, showPath = FALSE, showTips = FALSE, ...)

\method{plot}{sitePath}(x, y = NULL, showTips = FALSE, ...)

\method{plotSingleSite}{fixationSites}(x, site, select = NULL, ...)

\method{plotSingleSite}{multiFixationSites}(x, site, select = NULL, ...)
}
\arguments{
\item{x}{A \code{fixationSites} object from \code{\link{fixationSites}} or
the return from \code{\link{lineagePath}} function.}

\item{site}{For \code{lineagePath}, it can be any site within sequence
length. For \code{fixationSites}, it is restrained to a predicted fixation
site. The numbering is consistent with \code{reference} defined in the
object.}

\item{showPath}{If plot the lineage result from lineagePath.}

\item{showTips}{Whether to plot the tip labels. The default is \code{FALSE}.}

\item{...}{Arguments in \code{plot.phylo} functions and other arguments.}

\item{y}{For a \code{sitePath} object, it can have more than one fixation
path. This is to select which path to plot. The default is \code{NULL}
which will plot all the paths. It is the same as \code{select} in
\code{plotSingleSite}}

\item{select}{Select which fixation path in to plot. The default is NULL
which will plot all the fixations.}
}
\value{
The function only makes plot and returns no value (It behaviors like
  the generic \code{\link{plot}} function).
}
\description{
For \code{lineagePath}, the tree will be colored according to
  the amino acid of the site. The color scheme tries to assign
  distinguishable color for each amino acid.

Visualize the \code{sitePath} object which can be extracted by
  using \code{\link{extractSite}} on the return of
  \code{\link{fixationSites}}.

For \code{\link{fixationSites}}, it will color the ancestral
  tips in red, descendant tips in blue and excluded tips in grey.
}
\examples{
data(zikv_tree)
data(zikv_align)
tree <- addMSA(zikv_tree, alignment = zikv_align)
paths <- lineagePath(tree)
plotSingleSite(paths, 139)
fixations <- fixationSites(paths)
sp <- extractSite(fixations, 139)
plot(sp)
plotSingleSite(fixations, 139)
}
\seealso{
\code{\link{plot.sitePath}}

\code{\link{plotSingleSite}}, \code{\link{extractSite}}
}
