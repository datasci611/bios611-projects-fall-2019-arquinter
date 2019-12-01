build-docker: Dockerfile

	docker build -t docker . -f Dockerfile && touch $@

pull-pandas:

	docker pull amancevice/pandas:0.25.2-slim && touch $@

scripts/proj3_wrangling.py: pull-pandas \ script/project3_wrangling.ipynb

	jupyter nbconvert --to python script/proj3_wrangling.ipynb

results/project3_report.html: scripts/project3_report.Rmd

	docker run -it --rm \

	-v $(shell pwd):/workdir \

	-w /workdir rocker/tidyverse \

	Rscript -e "library(rmarkdown); rmarkdown::render('scripts/project3_report.Rmd', 'html_document')"