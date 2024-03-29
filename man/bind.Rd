% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/repgrid-basicops.r
\name{bind}
\alias{bind}
\title{Concatenate the constructs of two grids.}
\usage{
bind(x, y, match = TRUE, index = TRUE)
}
\arguments{
\item{x}{\code{repgrid} object}

\item{y}{\code{repgrid} object}

\item{match}{If the elements do not have the same order they
are reordered to match the element order of the first grid 'x'
(if \code{test=TRUE}, default). If set to FALSE an error occurs
if the element order is not identical in both grids.}

\item{index}{TODO. Logical (default \code{TRUE}). Whether to add an index at the end
of each construct name so it remains clear from which grid each 
construct came.}
}
\value{
\code{repgrid} object
}
\description{
I.e. the constructs are combined to form one long grid.
This function can be used in order to analyze multiple grids
as one 'big grid' (eg. Slater, 1977, chap. 11).
}
\examples{
\dontrun{

   a <- randomGrid()
   b <- randomGrid()
   b@elements <- rev(a@elements)   # reverse elements
   bindConstructs(a, b)
 
   bindConstructs(a, b, m=F)       # no binding
}

}
\references{
Slater, P. (1977). \emph{The measurement of intrapersonal space 
             by grid technique}. London: Wiley.
}
\keyword{internal}
