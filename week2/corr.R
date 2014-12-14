corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    complete.matrix=complete(directory)
    id=complete.matrix[nobs>threshold]$id
    
    filename.list<-list.files(path=directory,"*.csv",full.names=T)
    content.list<-lapply(filename.list,read.csv)  
    library("data.table")
    data.matrix<-rbindlist(content.list)    
    filtered.matrix<-data.matrix[ID %in% id]
    if (nrow(filtered.matrix)) {
        ## Return a numeric vector of correlations
        filtered.matrix[,cor(sulfate,nitrate,use="pairwise.complete.obs"),by=ID]$V1
    } else {
        numeric()
    }

}