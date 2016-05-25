#!/usr/bin/env Rscript

# download over http
options(repos="http://cran.rstudio.com/")

# install rmr2
print("installing dependencies for rmr2")
install.packages("Rcpp")
install.packages("RJSONIO")
install.packages("digest")
install.packages("functional")
install.packages("reshape2")
install.packages("stringr")
install.packages("plyr")
install.packages("caTools")
print("installing rmr2")
install.packages("~/rmr2_3.3.1.tar.gz", repos = NULL, type = "source")

# install plyrmr
print("installing dependencies for plymr")
install.packages("dplyr")
install.packages("R.methodsS3")
install.packages("Hmisc")
install.packages("memoise")
install.packages("lazyeval")
install.packages("rjson")
print("installing plymer")
install.packages("~/plyrmr_0.6.0.tar.gz", repos = NULL, type = "source")

# install ravro
print("installing dependencies for ravro")
install.packages("bit64")
print("installing ravro")
install.packages("~/ravro_1.0.4.tar.gz", repos = NULL, type = "source")

# install rhdfs
print("installing dependencies for rhdfs")
install.packages("rJava")
print("installing rhdfs")
install.packages("~/rhdfs_1.0.8.tar.gz", repos = NULL, type = "source")

# install rhbase
print("installing hbase")
install.packages("~/rhbase_1.2.1.tar.gz", repos = NULL, type = "source")

# done
print("You can now do RHadoop")

