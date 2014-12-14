pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    filename.list<-list.files(path=directory,"*.csv",full.names=T)
    content.list<-lapply(filename.list,read.csv)  
    library("data.table")
    data.matrix<-rbindlist(content.list)    
    filtered.matrix<-data.matrix[ID %in% id]
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    mean(filtered.matrix[,get(pollutant)],na.rm=T)
}
