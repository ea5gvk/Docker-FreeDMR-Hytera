FROM python:3.10-alpine



ENTRYPOINT [ "/entrypoint" ]

RUN useradd -u 54000 radio && \
	apk add --update python3 py-pip && \
	install pip wheel setuptools --upgrade && \
	install hytera-homebrew-bridge --upgrade && \
	git clone https://github.com/g4klx/DMRGateway.git && \
	cd DMRGateway && \
	git reset --hard 6e89e4922f8c5eb7ec3797729a82137d70bc8940 && \
	make && \
	apt-get remove -y  gcc g++ make git wget && \
	apt-get -y autoremove && \
	apt-get -y purge && \
	rm -rvf /var/cache/apt/archives/*  && \
	chown 54000 /opt/* -R && \
	chmod 777 /opt/ -R 

COPY entrypoint /entrypoint
COPY config /opt/
RUN chmod 777 /opt/ -R

USER radio
