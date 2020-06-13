FROM augustohassel/r_ubuntu

RUN R -e "install.packages(c('shiny', 'rmkarkdown', 'tidyverse'), repos='https://cran.rstudio.com/')"

RUN apt-get update -qq && apt-get upgrade -y \
	sudo \	
	gdebi-core \
	wget \
	&& apt-get clean all

RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment


