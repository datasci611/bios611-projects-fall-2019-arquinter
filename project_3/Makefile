build-docker: Dockerfile

	docker build -t docker . -f Dockerfile && touch $@

scripts/proj3_wrangling.py: script/project3_wrangling.ipynb

	jupyter nbconvert --to python script/proj3_wrangling.ipynb

results/project3_report.html:

	Rscript -e "library(rmarkdown); rmarkdown::render('scripts/project3_report.Rmd', 'html_document')"