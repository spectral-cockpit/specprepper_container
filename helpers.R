

cran_version <- function(package) {
  if (is.null(getOption("repos")) || getOption("repos") == "@CRAN@") {
    options(repos = c(CRAN = "https://cloud.r-project.org/"))
  }
  available <- as.data.frame(available.packages())
  filtered <- available[available$Package == package, ]
  if (nrow(filtered) != 1) {
    stop(package, " is not available on CRAN")
  }
  filtered$Version
}

cran_source_url <- function(package, version = NULL) {
  if (is.null(version)) {
    version <- cran_version(package)
    latest_version <- TRUE
  } else {
    latest_version <- (version == cran_version(package))
  }
  bundle <- paste0(package, "_", version, ".tar.gz")
  if (latest_version) {
    paste0("https://cran.r-project.org/src/contrib/", bundle)
  } else {
    paste0("https://cran.r-project.org/src/contrib/Archive/", package, "/", bundle)
  }
}
