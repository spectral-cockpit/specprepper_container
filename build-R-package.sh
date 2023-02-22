#!/bin/bash
package=$1
version=$2
if [[ -z "$version" ]]; then
    version=$(Rscript -e "source('/scripts/helpers.R');cat(cran_version('$package'))")
fi
url=$(Rscript -e "source('/scripts/helpers.R');cat(cran_source_url('$package', '$version'))")
echo "Downloading $url"
curl -LO $url

Rscript -e "remotes::install_deps('/${package}_${version}.tar.gz')"

mkdir binary && cd binary
R CMD INSTALL --build /${package}_${version}.tar.gz
mv * /packages/R-${R_VERSION}