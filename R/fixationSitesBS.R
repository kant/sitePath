#' @rdname sitePath-deprecated
#' @name sitePath-deprecated
#' @title Deprecated functions in package \sQuote{sitePath}
#' @description These functions are provided for compatibility with older versions
#' of \sQuote{sitePath} only, and will be defunct at the next release.
#' @param paths a \code{lineagePath} object returned from
#'   \code{\link{lineagePath}} function or a \code{phylo} object after
#'   \code{\link{addMSA}}
#' @param minEffectiveSize A vector of two integers to specifiy minimum tree
#'   tips involved before/after mutation. Otherwise the mutation will not be
#'   counted into the return. If more than one number is given, the ancestral
#'   takes the first and descendant takes the second as the minimum. If only
#'   given one number, it's the minimum for both ancestral and descendant.
#' @param searchDepth The function uses heuristic search but the termination of
#'   the search cannot be intrinsically decided. \code{searchDepth} is needed to
#'   tell the search when to stop.
#' @param method The strategy for predicting the fixation. The basic approach is
#'   entropy minimization and can be achieved by adding or removing fixation
#'   point, or by comparing the two.
#' @param ... further arguments passed to or from other methods.
#' @param samplingSize The number of tips sampled for each round of resampling.
#'   It shoud be at least 10th and at most nine 10ths of the tree tips.
#' @param samplingTimes The total times of random sampling to do. It should be
#'   greater than 100.
#' @return Sites with multiple fixations.
#' @aliases multiFixationSites
#' @importFrom ape drop.tip
#' @importFrom utils flush.console
#' @importFrom utils txtProgressBar
#' @importFrom utils setTxtProgressBar
#' @export
#' @examples
#' data(zikv_tree_reduced)
#' data(zikv_align_reduced)
#' tree <- addMSA(zikv_tree_reduced, alignment = zikv_align_reduced)
#' fixationSites(lineagePath(tree))
multiFixationSites.lineagePath <- function(paths,
                                           samplingSize = NULL,
                                           samplingTimes = 100,
                                           minEffectiveSize = 0,
                                           searchDepth = 1,
                                           method = c("compare", "insert", "delete"),
                                           ...) {
    .Deprecated("fixationSites")
    res <- fixationSites(
        paths = paths,
        minEffectiveSize = minEffectiveSize,
        searchDepth = searchDepth,
        method = method,
        ...
    )
    return(res)
    # # Get the tree and aligned sequences
    # tree <- attr(paths, "tree")
    # nTips <- length(tree[["tip.label"]])
    # align <- attr(paths, "align")
    # # Check the parameters for resampling
    # if (is.null(samplingSize)) {
    #     samplingSize <- nTips / 2
    # } else if (!is.numeric(samplingSize)) {
    #     stop("\"samplingSize\" only accept numeric")
    # } else if (samplingSize > 9 * nTips / 10 ||
    #            samplingSize < nTips / 10) {
    #     stop("\"samplingSize\" should be within",
    #          " one 10th and nine 10ths of tree size")
    # } else {
    #     samplingSize <- as.integer(samplingSize)
    # }
    # if (samplingTimes < 100) {
    #     warning("\"samplingTimes\" is preferably over 100.")
    # }
    # if (!is.numeric(minEffectiveSize)) {
    #     stop("\"minEffectiveSize\" only accepts numeric")
    # } else {
    #     minEffectiveSize <- ceiling(minEffectiveSize)
    # }
    # # Get the 'searchDepth' for heuristic search
    # if (searchDepth < 1) {
    #     stop("\"searchDepth\" should be at least 1")
    # } else {
    #     searchDepth <- ceiling(searchDepth)
    # }
    # # Decide which miniminzing strategy
    # minimizeEntropy <- switch(
    #     match.arg(method),
    #     "compare" = minEntropyByComparing,
    #     "insert" = minEntropyByInserting,
    #     "delete" = minEntropyByDeleting
    # )
    # # Generate the site mapping from reference
    # reference <- attr(paths, "reference")
    # # Find all crossing nodes
    # divNodes <- divergentNode(paths)
    # # Get the name and sequence of the children tips that
    # # are descendant of the nodes.
    # nodeAlign <- .tipSeqsAlongPathNodes(
    #     paths = paths,
    #     divNodes = divNodes,
    #     tree = tree,
    #     align = align
    # )
    # cat("\nResampling...\n")
    # flush.console()
    # # The resampling process
    # pb <- txtProgressBar(min = 0,
    #                      max = samplingTimes,
    #                      style = 3)
    # allMutations <- lapply(seq_len(samplingTimes), function(iter) {
    #     # Sampled tree
    #     sampledTree <-
    #         drop.tip(tree, sample(seq_len(nTips), nTips - samplingSize))
    #     # The matching between original and sampled tips
    #     original2sampled <-
    #         match(sampledTree[["tip.label"]], tree[["tip.label"]])
    #     # Sampled aligned sequence
    #     sampledAlign <- align[original2sampled]
    #     # The corresponding path on the sampled tree subject to
    #     # path on original tree
    #     sampledPaths <- .originalPath2sampled(
    #         nodeAlign = nodeAlign,
    #         original2sampled = original2sampled,
    #         sampledTree = sampledTree
    #     )
    #     # Find the fixation site for the sampled tree
    #     sampledDivNodes <- divergentNode(sampledPaths)
    #     sampledNodeAlign <- attr(sampledPaths, "nodeAlign")
    #     res <- .findFixationSite(
    #         paths = sampledPaths,
    #         tree = sampledTree,
    #         align = sampledAlign,
    #         nodeAlign = sampledNodeAlign,
    #         divNodes = sampledDivNodes,
    #         reference = reference,
    #         minimizeEntropy = minimizeEntropy,
    #         minEffectiveSize = minEffectiveSize,
    #         searchDepth = searchDepth
    #     )
    #     attr(sampledPaths, "tree") <- sampledTree
    #     attr(res, "paths") <- sampledPaths
    #     setTxtProgressBar(pb, iter)
    #     return(res)
    # })
    # close(pb)
    # # Summarize the fixed amino acid for tips from resampling
    # sampleSummary <- .sampleSummarize(allMutations, nodeAlign, tree)
    # # Rebuild the fixation path
    # res <- .assembleFixation(
    #     x = sampleSummary,
    #     tree = tree,
    #     align = align,
    #     paths = paths,
    #     divNodes = divNodes
    # )
    # attr(res, "paths") <- paths
    # attr(res, "reference") <- reference
    # class(res) <- "multiFixationSites"
    # return(res)
}

.originalPath2sampled <- function(nodeAlign,
                                  original2sampled,
                                  sampledTree) {
    rootNode <- getMRCA(sampledTree, sampledTree[["tip.label"]])
    sampledEdge <- sampledTree[["edge"]]
    # To translate the path of original tree, first we need to find the
    # ancestral node on the sampled tree of the remaining tips in each
    # node of the original path.
    sampledNodeAlign <- list()
    for (nd in nodeAlign) {
        isTerminal <- attr(nd, "isTerminal")
        # Keep the sampled tips/sequences for each node
        nd <-
            nd[which(as.integer(names(nd)) %in% original2sampled)]
        # Remove the node if all the tips are gone during the sampling
        if (length(nd) == 0) {
            next
        }
        # Translate the tips in the original tree to the sampled tree
        tips <- match(as.integer(names(nd)), original2sampled)
        names(nd) <- as.character(tips)
        if (length(tips) == 1) {
            # A lineage path can disappear due to the sampling
            sampledNode <-
                sampledEdge[which(sampledEdge[, 2] == tips), 1]
        } else {
            sampledNode <- getMRCA(sampledTree, tips)
            if (!isTerminal && sampledNode != rootNode) {
                sampledNode <-
                    sampledEdge[which(sampledEdge[, 2] == sampledNode), 1]
            }
        }
        sampledNode <- as.character(sampledNode)
        # Combine the tips with the same ancestral node
        sampledNodeAlign[[sampledNode]] <-
            c(sampledNodeAlign[[sampledNode]], nd)
    }
    sampledNodes <- as.integer(names(sampledNodeAlign))
    # Node path on the sampled tree for each translated node.
    # Tranlate the paths on to the sampled tree
    sampledPaths <- list(nodepath(
        phy = sampledTree,
        from = rootNode,
        to = sampledNodes[1]
    ))
    for (n in sampledNodes[-1]) {
        nodePath <- nodepath(sampledTree, from = rootNode, to = n)
        # Descide if the current node path is a sub-path of existing paths
        # or any existing path is a sub-path to it.
        #
        # 0L: it's a new node path to add.
        #
        # 1L: the current node path is a sub-path and won't be added.
        #
        # 2L: one existing path is a sub-path and needs replacing
        qualified <- vapply(sampledPaths, function(p) {
            if (all(nodePath %in% p)) {
                return(1L)
            } else if (all(p %in% nodePath)) {
                return(2L)
            }
            return(0L)
        }, FUN.VALUE = integer(1))
        r <- qualified == 2L
        if (any(r)) {
            sampledPaths <- sampledPaths[-which(r)]
            sampledPaths <- c(sampledPaths, list(nodePath))
        } else if (all(qualified == 0L)) {
            sampledPaths <- c(sampledPaths, list(nodePath))
        }
    }
    attr(sampledPaths, "nodeAlign") <- sampledNodeAlign
    attr(sampledPaths, "rootNode") <- rootNode
    return(sampledPaths)
}

.sampleSummarize <- function(allMutations, nodeAlign, tree) {
    allSampledTips <- lapply(allMutations, function(m) {
        sampledPaths <- attr(m, "paths")
        sampledTree <- attr(sampledPaths, "tree")
        sampledTree[["tip.label"]]
    })
    cat("Summarizing...\n")
    flush.console()
    pb <- txtProgressBar(min = 0,
                         max = length(allMutations),
                         style = 3)
    # The tip names grouped by ancestral node of the original tree
    originalNodeTips <- lapply(nodeAlign, function(nd) {
        tree[["tip.label"]][as.integer(names(nd))]
    })
    # Assign amino acid for each ancestral node from the sampling result
    assembled <- summarizeAA(
        allMutations = allMutations,
        allSampledTips = allSampledTips,
        originalNodeTips = originalNodeTips,
        setTxtProgressBar = setTxtProgressBar,
        pb = pb
    )
    close(pb)
    # Split the result by node and summarize fixed amino acid of all samples
    res <- lapply(names(assembled), function(site) {
        nodeAAdist <- assembled[[site]]
        site <- as.integer(site)
        siteSummary <- lapply(names(nodeAAdist), function(node) {
            nodeTips <- as.integer(names(nodeAlign[[node]]))
            attr(nodeTips, "samplingSummary") <- nodeAAdist[[node]]
            attr(nodeTips, "aaSummary") <-
                tableAA(nodeAlign[[node]], site - 1)
            return(nodeTips)
        })
        names(siteSummary) <- names(nodeAAdist)
        return(siteSummary)
    })
    names(res) <- names(assembled)
    return(res)
}

.summarizeSamplingAA <- function(nodeTips) {
    tipsAA <- attr(nodeTips, "aaSummary")
    samplingAA <- attr(nodeTips, "samplingSummary")
    if (length(tipsAA) == 1 &&
        names(tipsAA) %in% names(samplingAA)) {
        return(names(tipsAA))
    }
    overlappedAA <- intersect(names(tipsAA), names(samplingAA))
    if (length(overlappedAA) != 0) {
        tipsAA <- tipsAA[overlappedAA]
        return(names(tipsAA)[which.max(tipsAA)])
    } else {
        return(names(samplingAA)[which.max(samplingAA)])
    }
}

.assembleFixation <- function(x, tree, align, paths, divNodes) {
    # Divergent nodes are not included anywhere in the result
    noDivNodesPaths <- lapply(paths, function(p) {
        as.character(setdiff(p, divNodes))
    })
    res <- list()
    for (site in names(x)) {
        summarized <- x[[site]]
        for (path in noDivNodesPaths) {
            # Only when all nodes in a path is covered will it be considered
            if (all(path %in% names(summarized))) {
                seg <- list()
                # Initiate aggregating the nodes with the same amino acids
                # fixed
                previousNode <- path[1]
                nodeTips <- summarized[[previousNode]]
                previousAA <- .summarizeSamplingAA(nodeTips)
                attr(nodeTips, "AA") <- previousAA
                attr(nodeTips, "node") <- previousNode
                seg[[previousNode]] <- nodeTips
                # Iterate through the remaining nodes
                for (node in path[-1]) {
                    nodeTips <- summarized[[node]]
                    currentAA <- .summarizeSamplingAA(nodeTips)
                    # Aggregate the tips if the current fixed amino acid
                    # is the same as the previous
                    if (currentAA == previousAA) {
                        node <- previousNode
                        nodeTips <- c(seg[[node]], nodeTips)
                        attr(nodeTips, "AA") <- currentAA
                    } else {
                        attr(nodeTips, "AA") <- currentAA
                    }
                    seg[[node]] <- nodeTips
                    attr(seg[[node]], "node") <- node
                    previousAA <- currentAA
                    previousNode <- node
                }
                targetIndex <- NULL
                if (length(seg) < 2) {
                    next
                } else if (!site %in% names(res)) {
                    targetIndex <- 1
                } else {
                    # Assume a new fixation path is to add.
                    targetIndex <- length(res[[site]]) + 1
                    # The index to extract the terminal tips of the fixation.
                    endIndex <- length(seg)
                    # Some site may have multiple fixation on multiple
                    # lineages. The following is for deciding at which
                    # index should it be assigned in the 'res[[site]]'
                    # Retrieve the existing mutation path of the site
                    existPath <- res[[site]]
                    # Which mutaiton path has the same mutations as 'seg'
                    toCombine <- vapply(
                        X = existPath,
                        FUN = function(ep) {
                            identical(lapply(seg, c)[-endIndex],
                                      lapply(ep, c)[-endIndex]) &&
                                currentAA == attr(ep[[endIndex]], "AA")
                        },
                        FUN.VALUE = logical(1)
                    )
                    if (any(toCombine)) {
                        existIndex <- which(toCombine)
                        # These are the candidates to combine. The additional
                        # condition be all the descendant tips are included.
                        toCombine <- unlist(lapply(
                            X = c(res[[site]][existIndex], list(seg)),
                            FUN = "[[",
                            ... = endIndex
                        ))
                        allTips <-
                            .childrenTips(tree, getMRCA(tree, toCombine))
                        if (all(allTips %in% toCombine)) {
                            seg[[endIndex]] <- toCombine
                            attr(seg[[endIndex]], "AA") <- currentAA
                            res[[site]] <- res[[site]][-existIndex]
                            targetIndex <- length(res[[site]]) + 1
                        } else {
                            # Add new fixation for the site if no existing
                            # mutation path can be combined with
                            targetIndex <- length(existPath) + 1
                        }
                    }
                }
                if (is.null(targetIndex)) {
                    next
                }
                i <- as.integer(site)
                seg <- lapply(seg, function(tips) {
                    attr(tips, "tipsAA") <- substr(x = align[tips],
                                                   start = i,
                                                   stop = i)
                    return(tips)
                })
                res[[site]][[targetIndex]] <- seg
                attr(res[[site]], "site") <- i
                attr(res[[site]], "tree") <- tree
                class(res[[site]]) <- "sitePath"
            }
        }
    }
    return(res)
}

#' @export
multiFixationSites <- function(paths, ...)
    UseMethod("multiFixationSites")

#' @export
print.multiFixationSites <- function(x, ...) {
    cat("Result for", length(attr(x, "paths")), "paths:\n\n")
    if (length(x) == 0) {
        cat("No multi-fixation found\n")
    } else {
        cat(paste(names(x), collapse = " "), "\n")
        refSeqName <- attr(attr(x, "reference"), "refSeqName")
        if (is.null(refSeqName)) {
            cat("No reference sequence specified.",
                "Using alignment numbering\n")
        } else {
            cat("Reference sequence: ", refSeqName, "\n", sep = "")
        }
    }
}
