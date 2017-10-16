#---- function
ConfidenceIntervalMedian <- function(d){
  median <- median(d);
  dj <- floor(0.5*length(d)-0.98*sqrt(length(d))) #lower
  dk <- ceiling(0.5*length(d)+1+0.98*sqrt(length(d))) #upper
  
  d <- d[order(d)]
  median.Bound <- c(d[dj],d[dk])
  
  return(median.Bound)
}

PlotFileTypeCompressionRatio <- function(method, random, bin, wiki){
  random$OriginalSize <- random$OriginalSize/1048576
  bin$OriginalSize <- bin$OriginalSize/1048576
  wiki$OriginalSize <- wiki$OriginalSize/1048576
  
  plot(random$CompressionRatio ~ random$OriginalSize,type="l", lwd=2, xlab="", ylab="", ylim=c(0.9,1.5),col="red")
  par(new=T)
  plot(bin$CompressionRatio ~ bin$OriginalSize, type="l",xlab="", lwd=2, ylab="", ylim=c(0.9,1.5), col="blue")
  par(new=T)
  plot(wiki$CompressionRatio ~ wiki$OriginalSize, type="l", lwd=2, main=method, xlab="File Size (MB)", ylab="Compression Ratio", ylim=c(0.9,3), col="forestgreen")
}

PlotMethodCompressionRatio <- function(filetype, m1, m2, m3, m4, m5){
  scal <- 1048576 #MB
  m1$OriginalSize <- m1$OriginalSize/scal
  m2$OriginalSize <- m2$OriginalSize/scal
  m3$OriginalSize <- m3$OriginalSize/scal
  m4$OriginalSize <- m4$OriginalSize/scal
  m5$OriginalSize <- m5$OriginalSize/scal
  
  MaxY_list <- c(max(m1$CompressionRatio),
                 max(m2$CompressionRatio),
                 max(m3$CompressionRatio),
                 max(m4$CompressionRatio),
                 max(m5$CompressionRatio))
  
  MaxY <- max(MaxY_list)
  
  MinY_list <- c(min(m1$CompressionRatio),
                 min(m2$CompressionRatio),
                 min(m3$CompressionRatio),
                 min(m4$CompressionRatio),
                 min(m5$CompressionRatio))
  
  MinY <- min(MinY_list)
  
  plot(m1$CompressionRatio ~ m1$OriginalSize, type="l", lwd=2, xlab="", ylab="", ylim=c(MinY,MaxY),col="red")
  par(new=T)
  plot(m2$CompressionRatio ~ m2$OriginalSize, type="l", lwd=2, xlab="", ylab="", ylim=c(MinY,MaxY), col="blue")
  par(new=T)
  plot(m3$CompressionRatio ~ m3$OriginalSize, type="l", lwd=2, xlab="", ylab="", ylim=c(MinY,MaxY), col="gold")
  par(new=T)
  plot(m4$CompressionRatio ~ m4$OriginalSize, type="l", lwd=2, xlab="", ylab="", ylim=c(MinY,MaxY), col="darkviolet")
  par(new=T)
  plot(m5$CompressionRatio ~ m5$OriginalSize, type="l", lwd=2, main=filetype, xlab="Original File Size (MB)", ylab="Compression Ratio", ylim=c(MinY,MaxY), col="gray0")
}

PlotMethodCompressTime <- function(filetype, m1, m2, m3, m4, m5){
 scal.time <- 1000 #1 microsecon = 1000 ms
 m1$MedianCompressTime <- m1$MedianCompressTime/scal.time
 m2$MedianCompressTime <- m2$MedianCompressTime/scal.time
 m3$MedianCompressTime <- m3$MedianCompressTime/scal.time
 m4$MedianCompressTime <- m4$MedianCompressTime/scal.time
 m5$MedianCompressTime <- m5$MedianCompressTime/scal.time
 
 m1$MedianCICompressTime.lower <- m1$MedianCICompressTime.lower/scal.time
 m2$MedianCICompressTime.lower <- m2$MedianCICompressTime.lower/scal.time
 m3$MedianCICompressTime.lower <- m3$MedianCICompressTime.lower/scal.time
 m4$MedianCICompressTime.lower <- m4$MedianCICompressTime.lower/scal.time
 m5$MedianCICompressTime.lower <- m5$MedianCICompressTime.lower/scal.time
 
 m1$MedianCICompressTime.upper <- m1$MedianCICompressTime.upper/scal.time
 m2$MedianCICompressTime.upper <- m2$MedianCICompressTime.upper/scal.time
 m3$MedianCICompressTime.upper <- m3$MedianCICompressTime.upper/scal.time
 m4$MedianCICompressTime.upper <- m4$MedianCICompressTime.upper/scal.time
 m5$MedianCICompressTime.upper <- m5$MedianCICompressTime.upper/scal.time
 
 scal <- 1048576 #MB
 m1$OriginalSize <- m1$OriginalSize/scal
 m2$OriginalSize <- m2$OriginalSize/scal
 m3$OriginalSize <- m3$OriginalSize/scal
 m4$OriginalSize <- m4$OriginalSize/scal
 m5$OriginalSize <- m5$OriginalSize/scal
 
 MaxY_list <- c(max(m1$MedianCICompressTime.upper),
                max(m2$MedianCICompressTime.upper),
                max(m3$MedianCICompressTime.upper),
                max(m4$MedianCICompressTime.upper),
                max(m5$MedianCICompressTime.upper)
                )
 
 MaxY <- max(MaxY_list)
 
 PlotMedianAndConfiInterval(m1$MedianCompressTime,m1$MedianCICompressTime.upper,m1$MedianCICompressTime.lower,m1$OriginalSize,MaxY,"red","red","red","","","")
 par(new=T)
 PlotMedianAndConfiInterval(m2$MedianCompressTime,m2$MedianCICompressTime.upper,m2$MedianCICompressTime.lower,m2$OriginalSize,MaxY,"blue","blue","blue","","","")
 par(new=T)
 PlotMedianAndConfiInterval(m3$MedianCompressTime,m3$MedianCICompressTime.upper,m3$MedianCICompressTime.lower,m3$OriginalSize,MaxY,"gold","gold","gold","","","")
 par(new=T)
 PlotMedianAndConfiInterval(m4$MedianCompressTime,m4$MedianCICompressTime.upper,m4$MedianCICompressTime.lower,m4$OriginalSize,MaxY,"darkviolet","darkviolet","darkviolet","","","")
 par(new=T)
 PlotMedianAndConfiInterval(m5$MedianCompressTime,m5$MedianCICompressTime.upper,m5$MedianCICompressTime.lower,m5$OriginalSize,MaxY,"gray0","gray0","gray0",filetype,"Original File Size (MB)","Compression Time (ms)")
}

PlotMethodDecompressTime <- function(filetype, m1, m2, m3, m4, m5){
  scal.time <- 1000 #1 microsecon = 1000 ms
  m1$MedianDecompressTime <- m1$MedianDecompressTime/scal.time
  m2$MedianDecompressTime <- m2$MedianDecompressTime/scal.time
  m3$MedianDecompressTime <- m3$MedianDecompressTime/scal.time
  m4$MedianDecompressTime <- m4$MedianDecompressTime/scal.time
  m5$MedianDecompressTime <- m5$MedianDecompressTime/scal.time
  
  m1$MedianCIDecompressTime.lower <- m1$MedianCIDecompressTime.lower/scal.time
  m2$MedianCIDecompressTime.lower <- m2$MedianCIDecompressTime.lower/scal.time
  m3$MedianCIDecompressTime.lower <- m3$MedianCIDecompressTime.lower/scal.time
  m4$MedianCIDecompressTime.lower <- m4$MedianCIDecompressTime.lower/scal.time
  m5$MedianCIDecompressTime.lower <- m5$MedianCIDecompressTime.lower/scal.time
  
  m1$MedianCIDecompressTime.upper <- m1$MedianCIDecompressTime.upper/scal.time
  m2$MedianCIDecompressTime.upper <- m2$MedianCIDecompressTime.upper/scal.time
  m3$MedianCIDecompressTime.upper <- m3$MedianCIDecompressTime.upper/scal.time
  m4$MedianCIDecompressTime.upper <- m4$MedianCIDecompressTime.upper/scal.time
  m5$MedianCIDecompressTime.upper <- m5$MedianCIDecompressTime.upper/scal.time
  
  scal <- 1048576 #MB
  m1$OriginalSize <- m1$OriginalSize/scal
  m2$OriginalSize <- m2$OriginalSize/scal
  m3$OriginalSize <- m3$OriginalSize/scal
  m4$OriginalSize <- m4$OriginalSize/scal
  m5$OriginalSize <- m5$OriginalSize/scal
  
  MaxY_list <- c(max(m1$MedianCIDecompressTime.upper),
                 max(m2$MedianCIDecompressTime.upper),
                 max(m3$MedianCIDecompressTime.upper),
                 max(m4$MedianCIDecompressTime.upper),
                 max(m5$MedianCIDecompressTime.upper))
  
  MaxY <- max(MaxY_list)
  
  PlotMedianAndConfiInterval(m1$MedianDecompressTime,m1$MedianCIDecompressTime.upper,m1$MedianCIDecompressTime.lower,m1$OriginalSize,MaxY,"red","red","red","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m2$MedianDecompressTime,m2$MedianCIDecompressTime.upper,m2$MedianCIDecompressTime.lower,m2$OriginalSize,MaxY,"blue","blue","blue","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m3$MedianDecompressTime,m3$MedianCIDecompressTime.upper,m3$MedianCIDecompressTime.lower,m3$OriginalSize,MaxY,"gold","gold","gold","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m4$MedianDecompressTime,m4$MedianCIDecompressTime.upper,m4$MedianCIDecompressTime.lower,m4$OriginalSize,MaxY,"darkviolet","darkviolet","darkviolet","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m5$MedianDecompressTime,m5$MedianCIDecompressTime.upper,m5$MedianCIDecompressTime.lower,m5$OriginalSize,MaxY,"gray0","gray0","gray0",filetype,"Original File Size (MB)","Decompression Time (ms)")
}

PlotMethodCompressSpeed <- function(filetype,aspect,m1, m2, m3, m4, m5){
  if(aspect == "r"){
    Asp <- "(Reading Speed)"
    m1.speed <- m1$MedianCompressSpeedReading
    m2.speed <- m2$MedianCompressSpeedReading
    m3.speed <- m3$MedianCompressSpeedReading
    m4.speed <- m4$MedianCompressSpeedReading
    m5.speed <- m5$MedianCompressSpeedReading
    
    m1.speed.upper <- m1$MedianCICompressSpeedReading.upper
    m2.speed.upper <- m2$MedianCICompressSpeedReading.upper
    m3.speed.upper <- m3$MedianCICompressSpeedReading.upper
    m4.speed.upper <- m4$MedianCICompressSpeedReading.upper
    m5.speed.upper <- m5$MedianCICompressSpeedReading.upper
    
    m1.speed.lower <- m1$MedianCICompressSpeedReading.lower
    m2.speed.lower <- m2$MedianCICompressSpeedReading.lower
    m3.speed.lower <- m3$MedianCICompressSpeedReading.lower
    m4.speed.lower <- m4$MedianCICompressSpeedReading.lower
    m5.speed.lower <- m5$MedianCICompressSpeedReading.lower
  }
  else if(aspect == "w"){
    Asp <- "(Writing Speed)"
    m1.speed <- m1$MedianCompressSpeedWriting
    m2.speed <- m2$MedianCompressSpeedWriting
    m3.speed <- m3$MedianCompressSpeedWriting
    m4.speed <- m4$MedianCompressSpeedWriting
    m5.speed <- m5$MedianCompressSpeedWriting
    
    m1.speed.upper <- m1$MedianCICompressSpeedWriting.upper
    m2.speed.upper <- m2$MedianCICompressSpeedWriting.upper
    m3.speed.upper <- m3$MedianCICompressSpeedWriting.upper
    m4.speed.upper <- m4$MedianCICompressSpeedWriting.upper
    m5.speed.upper <- m5$MedianCICompressSpeedWriting.upper
    
    m1.speed.lower <- m1$MedianCICompressSpeedWriting.lower
    m2.speed.lower <- m2$MedianCICompressSpeedWriting.lower
    m3.speed.lower <- m3$MedianCICompressSpeedWriting.lower
    m4.speed.lower <- m4$MedianCICompressSpeedWriting.lower
    m5.speed.lower <- m5$MedianCICompressSpeedWriting.lower
  }
  
  MaxY_list <- c(max(m1.speed.upper),
                 max(m2.speed.upper),
                 max(m3.speed.upper),
                 max(m4.speed.upper),
                 max(m5.speed.upper))
  
  MaxY <- max(MaxY_list)
  scal <- 1048576 #MB
  
  PlotMedianAndConfiInterval(m1.speed,m1.speed.upper,m1.speed.lower,m1$OriginalSize/scal,MaxY,"red","red","red","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m2.speed,m2.speed.upper,m2.speed.lower,m2$OriginalSize/scal,MaxY,"blue","blue","blue","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m3.speed,m3.speed.upper,m3.speed.lower,m3$OriginalSize/scal,MaxY,"gold","gold","gold","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m4.speed,m4.speed.upper,m4.speed.lower,m4$OriginalSize/scal,MaxY,"darkviolet","darkviolet","darkviolet","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m5.speed,m5.speed.upper,m5.speed.lower,m5$OriginalSize/scal,MaxY,"gray0","gray0","gray0",paste0(filetype," ","Compression"),"Original File Size","Compress Speed (per microsecond)")
}

PlotMethodDecompressSpeed <- function(filetype,aspect,m1, m2, m3, m4, m5){
  if(aspect == "r"){
    Asp <- "(Reading Speed)"
    m1.speed <- m1$MedianDecompressSpeedReading
    m2.speed <- m2$MedianDecompressSpeedReading
    m3.speed <- m3$MedianDecompressSpeedReading
    m4.speed <- m4$MedianDecompressSpeedReading
    m5.speed <- m5$MedianDecompressSpeedReading
    
    m1.speed.upper <- m1$MedianCIDecompressSpeedReading.upper
    m2.speed.upper <- m2$MedianCIDecompressSpeedReading.upper
    m3.speed.upper <- m3$MedianCIDecompressSpeedReading.upper
    m4.speed.upper <- m4$MedianCIDecompressSpeedReading.upper
    m5.speed.upper <- m5$MedianCIDecompressSpeedReading.upper
    
    m1.speed.lower <- m1$MedianCIDecompressSpeedReading.lower
    m2.speed.lower <- m2$MedianCIDecompressSpeedReading.lower
    m3.speed.lower <- m3$MedianCIDecompressSpeedReading.lower
    m4.speed.lower <- m4$MedianCIDecompressSpeedReading.lower
    m5.speed.lower <- m5$MedianCIDecompressSpeedReading.lower
  }
  else if(aspect == "w"){
    Asp <- "(Writing Speed)"
    m1.speed <- m1$MedianDecompressSpeedWriting
    m2.speed <- m2$MedianDecompressSpeedWriting
    m3.speed <- m3$MedianDecompressSpeedWriting
    m4.speed <- m4$MedianDecompressSpeedWriting
    m5.speed <- m5$MedianDecompressSpeedWriting
    
    m1.speed.upper <- m1$MedianCIDecompressSpeedWriting.upper
    m2.speed.upper <- m2$MedianCIDecompressSpeedWriting.upper
    m3.speed.upper <- m3$MedianCIDecompressSpeedWriting.upper
    m4.speed.upper <- m4$MedianCIDecompressSpeedWriting.upper
    m5.speed.upper <- m5$MedianCIDecompressSpeedWriting.upper
    
    m1.speed.lower <- m1$MedianCIDecompressSpeedWriting.lower
    m2.speed.lower <- m2$MedianCIDecompressSpeedWriting.lower
    m3.speed.lower <- m3$MedianCIDecompressSpeedWriting.lower
    m4.speed.lower <- m4$MedianCIDecompressSpeedWriting.lower
    m5.speed.lower <- m5$MedianCIDecompressSpeedWriting.lower
  }
  
  MaxY_list <- c(max(m1.speed.upper),
                 max(m2.speed.upper),
                 max(m3.speed.upper),
                 max(m4.speed.upper),
                 max(m5.speed.upper))
  
  MaxY <- max(MaxY_list)
  scal <- 1048576 #MB
  
  PlotMedianAndConfiInterval(m1.speed,m1.speed.upper,m1.speed.lower,m1$OriginalSize/scal,MaxY,"red","red","red","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m2.speed,m2.speed.upper,m2.speed.lower,m2$OriginalSize/scal,MaxY,"blue","blue","blue","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m3.speed,m3.speed.upper,m3.speed.lower,m3$OriginalSize/scal,MaxY,"gold","gold","gold","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m4.speed,m4.speed.upper,m4.speed.lower,m4$OriginalSize/scal,MaxY,"darkviolet","darkviolet","darkviolet","","","")
  par(new=T)
  PlotMedianAndConfiInterval(m5.speed,m5.speed.upper,m5.speed.lower,m5$OriginalSize/scal,MaxY,"gray0","gray0","gray0",paste0(filetype," ","Decompression"),"Original File Size","Decompress Speed (per microsecond)")
}

PlotMedianAndConfiInterval <- function(m,upper,lower,fsz,Ymax,lineColorM,lineColorUp,lineColorLow,title,x,y){
  plot(m ~ fsz, type="l", lwd=2, xlab="", ylab="", ylim=c(0,Ymax), col=lineColorM)
  par(new=T)
  plot(upper ~ fsz, type="l", lwd=2, lty=3 ,xlab="", ylab="",ylim=c(0,Ymax),col=lineColorUp)
  par(new=T)
  plot(lower ~ fsz, type="l", lwd=2, lty=4 ,main=title, xlab=x, ylab=y,ylim=c(0,Ymax),col=lineColorLow)
}
#--- function end


# Data exploration
setwd("/Users/fuyincherng/Documents/EPFLCourse/2017spring/PerformanceEvaluation/miniproject_dataset")
jointTable <- read.csv("AllMethod_PerformanceMetric.csv")

#old generation
zlib.random <- read.csv("PerforMetric_aggregate/zlib_radom_agg.csv")
zlib.bin <- read.csv("PerforMetric_aggregate/zlib_bin_agg.csv")
zlib.wiki <- read.csv("PerforMetric_aggregate/zlib_wiki_agg.csv")

#new generation
snap.random <- read.csv("PerforMetric_aggregate/snap_radom_agg.csv")
snap.bin <- read.csv("PerforMetric_aggregate/snap_bin_agg.csv")
snap.wiki <- read.csv("PerforMetric_aggregate/snap_wiki_agg.csv")

zstd.random <- read.csv("PerforMetric_aggregate/zstd_radom_agg.csv")
zstd.bin <- read.csv("PerforMetric_aggregate/zstd_bin_agg.csv")
zstd.wiki <- read.csv("PerforMetric_aggregate/zstd_wiki_agg.csv")

lzfse.random <- read.csv("PerforMetric_aggregate/lzfse_radom_agg.csv")
lzfse.bin <- read.csv("PerforMetric_aggregate/lzfse_bin_agg.csv")
lzfse.wiki <- read.csv("PerforMetric_aggregate/lzfse_wiki_agg.csv")

brotli.random <- read.csv("PerforMetric_aggregate/brotli_radom_agg.csv")
brotli.bin <- read.csv("PerforMetric_aggregate/brotli_bin_agg.csv")
brotli.wiki <- read.csv("PerforMetric_aggregate/brotli_wiki_agg.csv")


#------ General comparison
#-- Influence of file size: File size increase, how the performance metric change for each method
PlotFileTypeCompressionRatio("zlib",zlib.random,zlib.bin,zlib.wiki)
PlotFileTypeCompressionRatio("snappy",snap.random,snap.bin,snap.wiki)
legend("topright",c("random","binary","wiki"),lty=c(1,1),lwd=c(2.5,2.5),col=c("red","blue","forestgreen"))
PlotFileTypeCompressionRatio("zstd",zstd.random,zstd.bin,zstd.wiki)
PlotFileTypeCompressionRatio("lzfse",lzfse.random,lzfse.bin,lzfse.wiki)
PlotFileTypeCompressionRatio("brotli",brotli.random,brotli.bin,brotli.wiki)

PlotMethodCompressionRatio("random",zlib.random,snap.random,zstd.random,lzfse.random,brotli.random)
legend("topright",c("zlib","snap","zstd","lzfse","brotli"),lty=c(1,1),lwd=c(2.5,2.5),col=c("red","blue","gold","darkviolet","gray0"))
PlotMethodCompressionRatio("binary",zlib.bin,snap.bin,zstd.bin,lzfse.bin,brotli.bin)
PlotMethodCompressionRatio("wiki",zlib.wiki,snap.wiki,zstd.wiki,lzfse.wiki,brotli.wiki)

#micro second for time measuring
#zlib
scal.file <- 1048576
scal.time <- 1000

PlotMethodCompressTime("random",zlib.random,snap.random,zstd.random,lzfse.random,brotli.random)
legend("topleft",c("zlib","snap","zstd","lzfse","brotli"),lty=c(1,1),lwd=c(2.5,2.5),col=c("red","blue","gold","darkviolet","gray0"))
PlotMethodCompressTime("binary",zlib.bin,snap.bin,zstd.bin,lzfse.bin,brotli.bin)
PlotMethodCompressTime("wiki",zlib.wiki,snap.wiki,zstd.wiki,lzfse.wiki,brotli.wiki)


#decompress time
PlotMethodDecompressTime("random",zlib.random,snap.random,zstd.random,lzfse.random,brotli.random)
legend("topleft",c("zlib","snap","zstd","lzfse","brotli"),lty=c(1,1),lwd=c(2.5,2.5),col=c("red","blue","gold","darkviolet","gray0"))
PlotMethodDecompressTime("binary",zlib.bin,snap.bin,zstd.bin,lzfse.bin,brotli.bin)
PlotMethodDecompressTime("wiki",zlib.wiki,snap.wiki,zstd.wiki,lzfse.wiki,brotli.wiki)

#compress speed function(filetype,aspect,m1, m2, m3, m4, m5){
PlotMethodCompressSpeed("random","r",zlib.random,snap.random,zstd.random,lzfse.random,brotli.random)
legend("topright",c("zlib","snap","zstd","lzfse","brotli"),lty=c(1,1),lwd=c(2.5,2.5),col=c("red","blue","gold","darkviolet","gray0"))
PlotMethodCompressSpeed("binary","r",zlib.bin,snap.bin,zstd.bin,lzfse.bin,brotli.bin)
PlotMethodCompressSpeed("wiki","r",zlib.wiki,snap.wiki,zstd.wiki,lzfse.wiki,brotli.wiki)

#Decompress speed
PlotMethodDecompressSpeed("random","w",zlib.random,snap.random,zstd.random,lzfse.random,brotli.random)
legend("topright",c("zlib","snap","zstd","lzfse","brotli"),lty=c(1,1),lwd=c(2.5,2.5),col=c("red","blue","gold","darkviolet","gray0"))
PlotMethodDecompressSpeed("random","w",zlib.random,snap.random,zstd.random,lzfse.random,brotli.random)
PlotMethodDecompressSpeed("binary","w",zlib.bin,snap.bin,zstd.bin,lzfse.bin,brotli.bin)
PlotMethodDecompressSpeed("wiki","w",zlib.wiki,snap.wiki,zstd.wiki,lzfse.wiki,brotli.wiki)

#-- plot bar chart 
# compression ratio
boxplot(jointTable$CompressionRatio[jointTable$FileType == "random"] ~ jointTable$Method[jointTable$FileType == "random"], notch=TRUE, 
        col=(c("gray0","darkviolet","blue","red","gold")),ylim=c(1.2,1.4),ylab="compression ratio", main="random")

boxplot(jointTable$CompressionRatio[jointTable$FileType == "wiki"] ~ jointTable$Method[jointTable$FileType == "wiki"], notch=TRUE, 
        col=(c("gray0","darkviolet","blue","red","gold")),ylim=c(2.5,3),ylab="compression ratio", main="wiki")

boxplot(jointTable$CompressionRatio[jointTable$FileType == "binary"] ~ jointTable$Method[jointTable$FileType == "binary"], notch=TRUE, 
        col=(c("gray0","darkviolet","blue","red","gold")),ylim=c(0.9,3),ylab="compression ratio", main="binary")
boxplot(jointTable$CompressionRatio ~ jointTable$Method*jointTable$FileType, notch=TRUE)

#for compression vs decompress speed
boxplot(jointTable$MedianCompressSpeedReading[jointTable$FileType == "binary"] ~ jointTable$Method[jointTable$FileType == "binary"], notch=TRUE,
        col=(c("gray0","darkviolet","blue","red","gold")),ylab="compression speed (bytes/microsecond)", main="compression speed: binary",ylim=c(0,150))
boxplot(jointTable$MedianDecompressSpeedReading[jointTable$FileType == "binary"] ~ jointTable$Method[jointTable$FileType == "binary"], notch=TRUE,
        col=(c("gray0","darkviolet","blue","red","gold")),ylab="decompression speed (bytes/microsecond)", main="decompression speed: binary",ylim=c(0,150))

boxplot(jointTable$MedianCompressSpeedReading[jointTable$FileType == "wiki"] ~ jointTable$Method[jointTable$FileType == "wiki"], notch=TRUE,
        col=(c("gray0","darkviolet","blue","red","gold")),ylab="compression speed (bytes/microsecond)", main="compression speed: wiki",ylim=c(0,110))
boxplot(jointTable$MedianDecompressSpeedReading[jointTable$FileType == "wiki"] ~ jointTable$Method[jointTable$FileType == "wiki"], notch=TRUE,
        col=(c("gray0","darkviolet","blue","red","gold")),ylab="decompression speed (bytes/microsecond)", main="decompression speed: wiki",ylim=c(0,110))

boxplot(jointTable$MedianCompressSpeedReading[jointTable$FileType == "random"] ~ jointTable$Method[jointTable$FileType == "random"], notch=TRUE,
        col=(c("gray0","darkviolet","blue","red","gold")),ylab="compression speed (bytes/microsecond)", main="compression speed: random",ylim=c(0,80))
boxplot(jointTable$MedianDecompressSpeedReading[jointTable$FileType == "random"] ~ jointTable$Method[jointTable$FileType == "random"], notch=TRUE,
        col=(c("gray0","darkviolet","blue","red","gold")),ylab="decompression speed (bytes/microsecond)", main="decompression speed: random", ylim=c(0,80))

#---- radar plot
# dimension: 
# method: zlib, snap, zstd, lzfse, brotli overlap on one plot
library(fmsb)
# radar random
radar.random <- read.csv("radar/radar_rand.csv")
rownames(radar.random) <- radar.random$Method
radar.random <- rbind(rep(5,1) , rep(0,1) , radar.random[-1])

colors_border=c( rgb(0.8,0.0,0.0,0.9), rgb(0.0,0.0,0.8,0.9) , rgb(0.8,0.8,0.0,0.9), rgb(0.8,0.0,0.8,0.9), rgb(0.2,0.2,0.2,0.9)  )
colors_in=c( rgb(0.8,0.0,0.0,0.4), rgb(0.0,0.0,0.8,0.4) , rgb(0.8,0.8,0.0,0.4), rgb(0.8,0.0,0.8,0.4), rgb(0.2,0.2,0.2,0.4) )
radarchart( radar.random  , axistype=1 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(1,5,1), cglwd=0.8,
            #custom labels
            vlcex=0.8
)
legend(x=0.95, y=1.3, legend = rownames(radar.random[-c(1,2),]), bty = "n", pch=20 , col=colors_border , cex=1.2, pt.cex=3)
title(main = "random input")

# wiki plot
radar.random <- read.csv("radar/radar_wiki.csv")
rownames(radar.random) <- radar.random$Method
radar.random <- rbind(rep(5,1) , rep(0,1) , radar.random[-1])

colors_border=c( rgb(0.8,0.0,0.0,0.9), rgb(0.0,0.0,0.8,0.9) , rgb(0.8,0.8,0.0,0.9), rgb(0.8,0.0,0.8,0.9), rgb(0.2,0.2,0.2,0.9)  )
colors_in=c( rgb(0.8,0.0,0.0,0.4), rgb(0.0,0.0,0.8,0.4) , rgb(0.8,0.8,0.0,0.4), rgb(0.8,0.0,0.8,0.4), rgb(0.2,0.2,0.2,0.4) )
radarchart( radar.random  , axistype=1 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(1,5,1), cglwd=0.8,
            #custom labels
            vlcex=0.8
)
legend(x=0.95, y=1.3, legend = rownames(radar.random[-c(1,2),]), bty = "n", pch=20 , col=colors_border , cex=1.2, pt.cex=3)
title(main = "wiki")

# bin plot
radar.random <- read.csv("radar/radar_bin.csv")
rownames(radar.random) <- radar.random$Method
radar.random <- rbind(rep(5,1) , rep(0,1) , radar.random[-1])

colors_border=c( rgb(0.8,0.0,0.0,0.9), rgb(0.0,0.0,0.8,0.9) , rgb(0.8,0.8,0.0,0.9), rgb(0.8,0.0,0.8,0.9), rgb(0.2,0.2,0.2,0.9)  )
colors_in=c( rgb(0.8,0.0,0.0,0.4), rgb(0.0,0.0,0.8,0.4) , rgb(0.8,0.8,0.0,0.4), rgb(0.8,0.0,0.8,0.4), rgb(0.2,0.2,0.2,0.4) )
radarchart( radar.random  , axistype=1 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(1,5,1), cglwd=0.8,
            #custom labels
            vlcex=0.8
)
legend(x=0.95, y=1.3, legend = rownames(radar.random[-c(1,2),]), bty = "n", pch=20 , col=colors_border , cex=1.2, pt.cex=3)
title(main = "binary")
