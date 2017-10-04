FROM ubuntu

RUN 	apt-get install npm && \
	npm cache clean -f && \
	npm install -g n && \
	n stable && \
	apt-get install git && \
	cd ~ && \
	git clone https://aghigo:21ZsXdx@github.com/felippemauricio/osiris-web osiris-web-frontend && \
	cd osiris-web-frontend && \
	npm install

EXPOSE 3000

CMD ["npm", "install"]
