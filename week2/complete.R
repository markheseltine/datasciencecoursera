complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    filename.list<-list.files(path=directory,"*.csv",full.names=T)
    content.list<-lapply(filename.list,read.csv)  
    library("data.table")
    data.matrix<-rbindlist(content.list)    
    filtered.matrix<-data.matrix[ID %in% id]
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    data.frame(setNames(filtered.matrix[,sum(!is.na(sulfate+nitrate)),by=ID],c("id","nobs")))
}