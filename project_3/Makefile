build-docker: Dockerfile

	docker build -t docker . -f Dockerfile && \

	touch $@

script/proj3_wrangling.py: script/project3_wrangling.ipynb

	jupyter nbconvert --to python script/proj3_wrangling.ipynb

results/project3_report.html: results/project3_report.Rmd

	docker run -it --rm \

	-v $(shell pwd):/workdir \

	-w /workdir rocker/tidyverse \

	Rscript -e "library(rmarkdown); rmarkdown::render('scripts/project3_report.Rmd', 'html_document')"