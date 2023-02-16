FROM rocker/r-ver:4.2.2

RUN apt-get update && apt-get install -y curl

RUN Rscript -e 'install.packages("remotes")'

ENV R_VERSION=4.2.2
RUN mkdir -p /packages/R-${R_VERSION}
RUN mkdir /scripts

ADD helpers.R /scripts/helpers.R
ADD build-R-package.sh /scripts/build-R-package.sh
RUN chmod +x /scripts/build-R-package.sh

ENTRYPOINT ["/scripts/build-R-package.sh"]
