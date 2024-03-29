% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_CNSR.R
\name{add_CNSR}
\alias{add_CNSR}
\alias{add_CNSR.ggsurvfit}
\alias{add_CNSR.ggtidycuminc}
\title{Add censoring symbols to a visR object}
\usage{
add_CNSR(gg, ...)

\method{add_CNSR}{ggsurvfit}(gg, shape = 3, size = 2, ...)

\method{add_CNSR}{ggtidycuminc}(gg, shape = 3, size = 2, ...)
}
\arguments{
\item{gg}{A ggplot created with visR}

\item{...}{other arguments passed on to the method to modify \code{\link[ggplot2]{geom_point}}}

\item{shape}{aesthetic of ggplot2 \code{\link[ggplot2]{geom_point}}. Default is 3.}

\item{size}{aesthetic of ggplot2 \code{\link[ggplot2]{geom_point}}. Default is 2.}
}
\value{
Censoring symbols overlayed on a visR ggplot
}
\description{
Add censoring symbols to a visR ggplot through an S3 method.
The S3 method is for adding censoring symbols to a visR ggplot.
The method is set up to use the pipe \verb{\%>\%}.

No default method is available at the moment.
}
\examples{

library(visR)

# Estimate KM curves by treatment group
survfit_object <- survival::survfit(data = adtte, survival::Surv(AVAL, 1 - CNSR) ~ TRTP)

## plot without confidence intervals
p <- visR::visr(survfit_object)
p

# add censoring to plot
p \%>\% visR::add_CNSR()

# change censor symbol shape
p \%>\% visR::add_CNSR(shape = 1)

# change size and shape
p \%>\% visR::add_CNSR(size = 4, shape = 2)

}
