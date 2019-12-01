FROM continuumio/anaconda3
FROM rocker/tidyverse

RUN conda install -c conda-forge statsmodels
RUN Rscript -e "install.packages('data.table')"
