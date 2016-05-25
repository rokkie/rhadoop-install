#!/usr/bin/env Rscript

# load libraries
library(rmr2)
library(rhdfs)
library(dplyr)
library(magrittr)

# initiate rhdfs package
hdfs.init()

# define map function
map <- function(k, lines) {
  words.list <- strsplit(lines, '\\s')
  words <- unlist(words.list)
  return( keyval(words, 1) )
}

# define reduce function 
reduce <- function(word, counts) {
  keyval(word, sum(counts))
}

# define wordcount function as wrapper for mapreduce
wordcount <- function (input, output=NULL) {
  mapreduce(input=input, output=output, input.format="text", map=map, reduce=reduce)
}

# path to shakespeare text on local filesystem
path.to.shakespeare.txt <- file.path(normalizePath('.'), 'shakespeare.txt')
path.to.results <- file.path(normalizePath('.'), 'wordcount-shakespeare-results.csv')

# read text files from folder example/wordcount/data
hdfs.root <- '/example/wordcount'
hdfs.data <- file.path(hdfs.root, 'data')

# save result in folder example/wordcount/out
hdfs.out <- file.path(hdfs.root, paste('out', as.numeric(Sys.time()), sep='-'))

# put shakespeare on the hdfs
hdfs.put(path.to.shakespeare.txt, hdfs.data)

# submit job, fetch results from HDFS, load into data frame
df <- wordcount(hdfs.data, hdfs.out) %>%
  from.dfs %>%
  as.data.frame(stringsAsFactors=F)

# set column names and sort 
colnames(df) <- c('word', 'count')
tbl <- tbl_df(df) %>%
  select(word, count) %>%
  arrange(desc(count))

# print table
print(tbl)

# save to file
write.table(tbl, path.to.results, sep=",")

# remove data and output from hdfs
hdfs.rm(hdfs.data)
hdfs.rm(hdfs.out)
