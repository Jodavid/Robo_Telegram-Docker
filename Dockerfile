FROM rocker/r-ver:4.1.2
RUN apt-get update && apt-get install -y  libcurl4-openssl-dev libpng-dev libproj-dev libssl-dev libxml2-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("telegram.bot",upgrade="never")'
RUN Rscript -e 'remotes::install_version("devtools",upgrade="never")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
CMD R -e "source('script.R')"
