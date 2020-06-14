FROM augustohassel/r_ubuntu

RUN apt-get update -qq && apt-get upgrade -y \
	sudo \	
	gdebi-core \
	wget \
	git \
	libcairo2-dev \
	libxml2-dev \
	libxt-dev \
	xtail \
	&& apt-get clean all

RUN R -e "install.packages('tidyverse', repos='https://cran.rstudio.com/')"

RUN R -e "install.packages('shiny', repos='https://cran.rstudio.com/')"

RUN R -e "install.packages('rmarkdown', repos='https://cran.rstudio.com/')"

RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
	VERSION=$(cat version.txt)  && \
	wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
	gdebi -n ss-latest.deb && \
	rm -f version.txt ss-latest.deb && \
	. /etc/environment && \
	chown shiny:shiny /var/lib/shiny-server
	


