#--- function
ConfidenceIntervalMean <- function(d){
  #compute confidence interval of mean at 95%
 
  sigma <- sd(d)
  meanError <- sigma/sqrt(length(d))
  meanDelta <- 1.96*meanError
  
  return(meanDelta)
}

ConfidenceIntervalMedian <- function(d){
  median <- median(d);
  dj <- floor(0.5*length(d)-0.98*sqrt(length(d))) #lower
  dk <- ceiling(0.5*length(d)+1+0.98*sqrt(length(d))) #upper
  
  d <- d[order(d)]
  median.Bound <- c(d[dj],d[dk])
  
  return(median.Bound)
}

SampleAggregate <- function(m,f,n,input,fsL){
  # method | quality level | uncompre size | compres size | compre ratio 
  # for compre time, decompre time, compre speed read, compre speed write, decompre speed read, decompre speed write 
  # report: mean | median | mean CI | media CI
  report <- data.frame(OriginalSize=numeric(n), 
                       CompressedSize=numeric(n), 
                       CompressionRatio=numeric(n),
                       #
                       MeanCompressTime=numeric(n),
                       MeanDecompressTime=numeric(n),
                       MeanCompressSpeedReading=numeric(n),
                       MeanCompressSpeedWriting=numeric(n),
                       MeanDecompressSpeedReading=numeric(n),
                       MeanDecompressSpeedWriting=numeric(n),
                       #
                       MeanCICompressTime=numeric(n),
                       MeanCIDecompressTime=numeric(n),
                       MeanCICompressSpeedReading=numeric(n),
                       MeanCICompressSpeedWriting=numeric(n),
                       MeanCIDecompressSpeedReading=numeric(n),
                       MeanCIDecompressSpeedWriting=numeric(n),
                       #
                       MedianCompressTime=numeric(n),
                       MedianDecompressTime=numeric(n),
                       MedianCompressSpeedReading=numeric(n),
                       MedianCompressSpeedWriting=numeric(n),
                       MedianDecompressSpeedReading=numeric(n),
                       MedianDecompressSpeedWriting=numeric(n),
                       #
                       MedianCICompressTime.lower=numeric(n),
                       MedianCIDecompressTime.lower=numeric(n),
                       MedianCICompressSpeedReading.lower=numeric(n),
                       MedianCICompressSpeedWriting.lower=numeric(n),
                       MedianCIDecompressSpeedReading.lower=numeric(n),
                       MedianCIDecompressSpeedWriting.lower=numeric(n),
                       #
                       MedianCICompressTime.upper=numeric(n),
                       MedianCIDecompressTime.upper=numeric(n),
                       MedianCICompressSpeedReading.upper=numeric(n),
                       MedianCICompressSpeedWriting.upper=numeric(n),
                       MedianCIDecompressSpeedReading.upper=numeric(n),
                       MedianCIDecompressSpeedWriting.upper=numeric(n),
                       #
                       stringsAsFactors = FALSE
  )
  report$Method <- m
  report$FileType <- f 
  
  for(i in 1:n){
    report$OriginalSize[i] <- fsL[i]
    report$CompressedSize[i] <- input$CompressedSize[input$OriginalSize == fsL[i]][1]
    report$CompressionRatio[i] <- input$CompressionRatio[input$OriginalSize == fsL[i]][1]
    #mean
    report$MeanCompressTime[i] <- mean(input$CompressTime[input$OriginalSize == fsL[i]])
    report$MeanDecompressTime[i] <- mean(input$DecompressTime[input$OriginalSize == fsL[i]])
    report$MeanCompressSpeedReading[i] <- mean(input$CompressSpeedReading[input$OriginalSize == fsL[i]])
    report$MeanCompressSpeedWriting[i] <- mean(input$CompressSpeedWriting[input$OriginalSize == fsL[i]])
    report$MeanDecompressSpeedReading[i] <- mean(input$DecompressSpeedReading[input$OriginalSize == fsL[i]])
    report$MeanDecompressSpeedWriting[i] <- mean(input$DecompressSpeedWriting[input$OriginalSize == fsL[i]])
    #CI of mean
    report$MeanCICompressTime[i] <- ConfidenceIntervalMean(input$CompressTime[input$OriginalSize == fsL[i]])
    report$MeanCIDecompressTime[i] <- ConfidenceIntervalMean(input$DecompressTime[input$OriginalSize == fsL[i]])
    report$MeanCICompressSpeedReading[i] <- ConfidenceIntervalMean(input$CompressSpeedReading[input$OriginalSize == fsL[i]])
    report$MeanCICompressSpeedWriting[i] <- ConfidenceIntervalMean(input$CompressSpeedWriting[input$OriginalSize == fsL[i]])
    report$MeanCIDecompressSpeedReading[i] <- ConfidenceIntervalMean(input$DecompressSpeedReading[input$OriginalSize == fsL[i]])
    report$MeanCIDecompressSpeedWriting[i] <- ConfidenceIntervalMean(input$DecompressSpeedWriting[input$OriginalSize == fsL[i]])
    
    #median
    report$MedianCompressTime[i] <- median(input$CompressTime[input$OriginalSize == fsL[i]])
    report$MedianDecompressTime[i] <- median(input$DecompressTime[input$OriginalSize == fsL[i]])
    report$MedianCompressSpeedReading[i] <- median(input$CompressSpeedReading[input$OriginalSize == fsL[i]])
    report$MedianCompressSpeedWriting[i] <- median(input$CompressSpeedWriting[input$OriginalSize == fsL[i]])
    report$MedianDecompressSpeedReading[i] <- median(input$DecompressSpeedReading[input$OriginalSize == fsL[i]])
    report$MedianDecompressSpeedWriting[i] <- median(input$DecompressSpeedWriting[input$OriginalSize == fsL[i]])
    
    #CI of median
    report$MedianCICompressTime.lower[i] <- ConfidenceIntervalMedian(input$CompressTime[input$OriginalSize == fsL[i]])[1]
    report$MedianCICompressTime.upper[i] <- ConfidenceIntervalMedian(input$CompressTime[input$OriginalSize == fsL[i]])[2]
    
    report$MedianCIDecompressTime.lower[i] <- ConfidenceIntervalMedian(input$DecompressTime[input$OriginalSize == fsL[i]])[1]
    report$MedianCIDecompressTime.upper[i] <- ConfidenceIntervalMedian(input$DecompressTime[input$OriginalSize == fsL[i]])[2]
    
    report$MedianCICompressSpeedReading.lower[i] <- ConfidenceIntervalMedian(input$CompressSpeedReading[input$OriginalSize == fsL[i]])[1]
    report$MedianCICompressSpeedReading.upper[i] <- ConfidenceIntervalMedian(input$CompressSpeedReading[input$OriginalSize == fsL[i]])[2]
    
    report$MedianCICompressSpeedWriting.lower[i] <- ConfidenceIntervalMedian(input$CompressSpeedWriting[input$OriginalSize == fsL[i]])[1]
    report$MedianCICompressSpeedWriting.upper[i] <- ConfidenceIntervalMedian(input$CompressSpeedWriting[input$OriginalSize == fsL[i]])[2]
    
    report$MedianCIDecompressSpeedReading.lower[i] <- ConfidenceIntervalMedian(input$DecompressSpeedReading[input$OriginalSize == fsL[i]])[1]
    report$MedianCIDecompressSpeedReading.upper[i] <- ConfidenceIntervalMedian(input$DecompressSpeedReading[input$OriginalSize == fsL[i]])[2]
    
    report$MedianCIDecompressSpeedWriting.lower[i] <- ConfidenceIntervalMedian(input$DecompressSpeedWriting[input$OriginalSize == fsL[i]])[1]
    report$MedianCIDecompressSpeedWriting.upper[i] <- ConfidenceIntervalMedian(input$DecompressSpeedWriting[input$OriginalSize == fsL[i]])[2]
    
  }
  
  return(report)
}

CompressionRatio <- function(input){
  return(input$OriginalSize / input$CompressedSize)
}
#--- function end

#--- compute the performance metric and then save
setwd("/Users/fuyincherng/Documents/EPFLCourse/2017spring/PerformanceEvaluation/miniproject_dataset")

snap.random <- read.table(file = "preview/snappy.random", sep='\t', header = TRUE)
snap.bin <- read.table(file = "preview/snappy.binary", sep='\t', header = TRUE)
snap.wiki <- read.table(file = "preview/snappy.wiki", sep='\t', header = TRUE)
colnames(snap.random) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(snap.bin) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(snap.wiki) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")

zstd.random <- read.table(file = "preview/zstd.random", sep='\t', header = TRUE)
zstd.bin <- read.table(file = "preview/zstd.binary", sep='\t', header = TRUE)
zstd.wiki <- read.table(file = "preview/zstd.wiki", sep='\t', header = TRUE)
colnames(zstd.random) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(zstd.bin) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(zstd.wiki) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")

lzfse.random <- read.table(file = "preview/lzfse.random", sep='\t', header = TRUE)
lzfse.bin <- read.table(file = "preview/lzfse.binary", sep='\t', header = TRUE)
lzfse.wiki <- read.table(file = "preview/lzfse.wiki", sep='\t', header = TRUE)
colnames(lzfse.random) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(lzfse.bin) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(lzfse.wiki) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")

zlib.random <- read.table(file = "preview/zlib.random", sep='\t', header = TRUE)
zlib.bin <- read.table(file = "preview/zlib.binary", sep='\t', header = TRUE)
zlib.wiki <- read.table(file = "preview/zlib.wiki", sep='\t', header = TRUE)
colnames(zlib.random) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(zlib.bin) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(zlib.wiki) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")

brotli.random <- read.table(file = "preview/brotli.random", sep='\t', header = TRUE)
brotli.bin <- read.table(file = "preview/brotli.binary", sep='\t', header = TRUE)
brotli.wiki <- read.table(file = "preview/brotli.wiki", sep='\t', header = TRUE)
colnames(brotli.random) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(brotli.bin) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(brotli.wiki) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")

zlib.bin.rand <- read.table(file = "preview/rand_bin/zlib.tsv", sep='\t', header = TRUE)
snap.bin.rand <- read.table(file = "preview/rand_bin/snappy.tsv", sep='\t', header = TRUE)
zstd.bin.rand <- read.table(file = "preview/rand_bin/zstd.tsv", sep='\t', header = TRUE)
lzfse.bin.rand <- read.table(file = "preview/rand_bin/lzfse.tsv", sep='\t', header = TRUE)
brotli.bin.rand <- read.table(file = "preview/rand_bin/brotli.tsv", sep='\t', header = TRUE)
colnames(zlib.bin.rand) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(snap.bin.rand) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(zstd.bin.rand) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(lzfse.bin.rand) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(brotli.bin.rand) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")


zlib.wiki.dir <- read.table(file = "preview/rand_wiki/zlib.wikidir", sep='\t', header = TRUE)
snap.wiki.dir <- read.table(file = "preview/rand_wiki/snappy.wikidir", sep='\t', header = TRUE)
zstd.wiki.dir <- read.table(file = "preview/rand_wiki/zstd.wikidir", sep='\t', header = TRUE)
lzfse.wiki.dir <- read.table(file = "preview/rand_wiki/lzfse.wikidir", sep='\t', header = TRUE)
brotli.wiki.dir <- read.table(file = "preview/rand_wiki/brotli.wikidir", sep='\t', header = TRUE)
colnames(zlib.wiki.dir) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(snap.wiki.dir) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(zstd.wiki.dir) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(lzfse.wiki.dir) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")
colnames(brotli.wiki.dir) <- c("OriginalSize","CompressedSize","CompressTime","DecompressTime")

# Compression Ratio = uncompressed size / compressed size
snap.random$CompressionRatio <- CompressionRatio(snap.random) 
snap.bin$CompressionRatio <- CompressionRatio(snap.bin)
snap.wiki$CompressionRatio <- CompressionRatio(snap.wiki)

zstd.random$CompressionRatio <- CompressionRatio(zstd.random)
zstd.bin$CompressionRatio <- CompressionRatio(zstd.bin)
zstd.wiki$CompressionRatio <- CompressionRatio(zstd.wiki)

lzfse.random$CompressionRatio <- CompressionRatio(lzfse.random)
lzfse.bin$CompressionRatio <- CompressionRatio(lzfse.bin)
lzfse.wiki$CompressionRatio <- CompressionRatio(lzfse.wiki)

zlib.random$CompressionRatio <- CompressionRatio(zlib.random)
zlib.bin$CompressionRatio <- CompressionRatio(zlib.bin)
zlib.wiki$CompressionRatio <- CompressionRatio(zlib.wiki)

brotli.random$CompressionRatio <- CompressionRatio(brotli.random)
brotli.bin$CompressionRatio <- CompressionRatio(brotli.bin)
brotli.wiki$CompressionRatio <- CompressionRatio(brotli.wiki)

zlib.bin.rand$CompressionRatio <- CompressionRatio(zlib.bin.rand)
snap.bin.rand$CompressionRatio <- CompressionRatio(snap.bin.rand)
zstd.bin.rand$CompressionRatio <- CompressionRatio(zstd.bin.rand)
lzfse.bin.rand$CompressionRatio <- CompressionRatio(lzfse.bin.rand)
brotli.bin.rand$CompressionRatio <- CompressionRatio(brotli.bin.rand)

zlib.wiki.dir$CompressionRatio <- CompressionRatio(zlib.wiki.dir)
snap.wiki.dir$CompressionRatio <- CompressionRatio(snap.wiki.dir)
zstd.wiki.dir$CompressionRatio <- CompressionRatio(zstd.wiki.dir)
lzfse.wiki.dir$CompressionRatio <- CompressionRatio(lzfse.wiki.dir)
brotli.wiki.dir$CompressionRatio <- CompressionRatio(brotli.wiki.dir)

# Compression Speed: reading & writing
# reading = original size / comression time
snap.random$CompressSpeedReading <- snap.random$OriginalSize / snap.random$CompressTime
snap.bin$CompressSpeedReading <- snap.bin$OriginalSize / snap.bin$CompressTime
snap.wiki$CompressSpeedReading <- snap.wiki$OriginalSize / snap.wiki$CompressTime

zstd.random$CompressSpeedReading <- zstd.random$OriginalSize / zstd.random$CompressTime
zstd.bin$CompressSpeedReading <- zstd.bin$OriginalSize / zstd.bin$CompressTime
zstd.wiki$CompressSpeedReading <- zstd.wiki$OriginalSize / zstd.wiki$CompressTime

lzfse.random$CompressSpeedReading <- lzfse.random$OriginalSize / lzfse.random$CompressTime
lzfse.bin$CompressSpeedReading <- lzfse.bin$OriginalSize / lzfse.bin$CompressTime
lzfse.wiki$CompressSpeedReading <- lzfse.wiki$OriginalSize / lzfse.wiki$CompressTime

zlib.random$CompressSpeedReading <- zlib.random$OriginalSize / zlib.random$CompressTime
zlib.bin$CompressSpeedReading <- zlib.bin$OriginalSize / zlib.bin$CompressTime
zlib.wiki$CompressSpeedReading <- zlib.wiki$OriginalSize / zlib.wiki$CompressTime

brotli.random$CompressSpeedReading <- brotli.random$OriginalSize / brotli.random$CompressTime
brotli.bin$CompressSpeedReading <- brotli.bin$OriginalSize / brotli.bin$CompressTime
brotli.wiki$CompressSpeedReading <- brotli.wiki$OriginalSize / brotli.wiki$CompressTime

# writing = compressed size / compression time
snap.random$CompressSpeedWriting <- snap.random$CompressedSize / snap.random$CompressTime
snap.bin$CompressSpeedWriting <- snap.bin$CompressedSize / snap.bin$CompressTime
snap.wiki$CompressSpeedWriting <- snap.wiki$CompressedSize / snap.wiki$CompressTime

zstd.random$CompressSpeedWriting <- zstd.random$CompressedSize / zstd.random$CompressTime
zstd.bin$CompressSpeedWriting <- zstd.bin$CompressedSize / zstd.bin$CompressTime
zstd.wiki$CompressSpeedWriting <- zstd.wiki$CompressedSize / zstd.wiki$CompressTime

lzfse.random$CompressSpeedWriting <- lzfse.random$CompressedSize / lzfse.random$CompressTime
lzfse.bin$CompressSpeedWriting <- lzfse.bin$CompressedSize / lzfse.bin$CompressTime
lzfse.wiki$CompressSpeedWriting <- lzfse.wiki$CompressedSize / lzfse.wiki$CompressTime

zlib.random$CompressSpeedWriting <- zlib.random$CompressedSize / zlib.random$CompressTime
zlib.bin$CompressSpeedWriting <- zlib.bin$CompressedSize / zlib.bin$CompressTime
zlib.wiki$CompressSpeedWriting <- zlib.wiki$CompressedSize / zlib.wiki$CompressTime

brotli.random$CompressSpeedWriting <- brotli.random$CompressedSize / brotli.random$CompressTime
brotli.bin$CompressSpeedWriting <- brotli.bin$CompressedSize / brotli.bin$CompressTime
brotli.wiki$CompressSpeedWriting <- brotli.wiki$CompressedSize / brotli.wiki$CompressTime

# Decompression Speed: reading & writing
# reading = compressed size / decomression time
snap.random$DecompressSpeedReading <- snap.random$CompressedSize / snap.random$DecompressTime
snap.bin$DecompressSpeedReading <- snap.bin$CompressedSize / snap.bin$DecompressTime
snap.wiki$DecompressSpeedReading <- snap.wiki$CompressedSize / snap.wiki$DecompressTime

zstd.random$DecompressSpeedReading <- zstd.random$CompressedSize / zstd.random$DecompressTime
zstd.bin$DecompressSpeedReading <- zstd.bin$CompressedSize / zstd.bin$DecompressTime
zstd.wiki$DecompressSpeedReading <- zstd.wiki$CompressedSize / zstd.wiki$DecompressTime

lzfse.random$DecompressSpeedReading <- lzfse.random$CompressedSize / lzfse.random$DecompressTime
lzfse.bin$DecompressSpeedReading <- lzfse.bin$CompressedSize / lzfse.bin$DecompressTime
lzfse.wiki$DecompressSpeedReading <- lzfse.wiki$CompressedSize / lzfse.wiki$DecompressTime

zlib.random$DecompressSpeedReading <- zlib.random$CompressedSize / zlib.random$DecompressTime
zlib.bin$DecompressSpeedReading <- zlib.bin$CompressedSize / zlib.bin$DecompressTime
zlib.wiki$DecompressSpeedReading <- zlib.wiki$CompressedSize / zlib.wiki$DecompressTime

brotli.random$DecompressSpeedReading <- brotli.random$CompressedSize / brotli.random$DecompressTime
brotli.bin$DecompressSpeedReading <- brotli.bin$CompressedSize / brotli.bin$DecompressTime
brotli.wiki$DecompressSpeedReading <- brotli.wiki$CompressedSize / brotli.wiki$DecompressTime

# writing = original size / decompression time
snap.random$DecompressSpeedWriting <- snap.random$OriginalSize / snap.random$DecompressTime
snap.bin$DecompressSpeedWriting <- snap.bin$OriginalSize / snap.bin$DecompressTime
snap.wiki$DecompressSpeedWriting <- snap.wiki$OriginalSize / snap.wiki$DecompressTime

zstd.random$DecompressSpeedWriting <- zstd.random$OriginalSize / zstd.random$DecompressTime
zstd.bin$DecompressSpeedWriting <- zstd.bin$OriginalSize / zstd.bin$DecompressTime
zstd.wiki$DecompressSpeedWriting <- zstd.wiki$OriginalSize / zstd.wiki$DecompressTime

lzfse.random$DecompressSpeedWriting <- lzfse.random$OriginalSize / lzfse.random$DecompressTime
lzfse.bin$DecompressSpeedWriting <- lzfse.bin$OriginalSize / lzfse.bin$DecompressTime
lzfse.wiki$DecompressSpeedWriting <- lzfse.wiki$OriginalSize / lzfse.wiki$DecompressTime

zlib.random$DecompressSpeedWriting <- zlib.random$OriginalSize / zlib.random$DecompressTime
zlib.bin$DecompressSpeedWriting <- zlib.bin$OriginalSize / zlib.bin$DecompressTime
zlib.wiki$DecompressSpeedWriting <- zlib.wiki$OriginalSize / zlib.wiki$DecompressTime

brotli.random$DecompressSpeedWriting <- brotli.random$OriginalSize / brotli.random$DecompressTime
brotli.bin$DecompressSpeedWriting <- brotli.bin$OriginalSize / brotli.bin$DecompressTime
brotli.wiki$DecompressSpeedWriting <- brotli.wiki$OriginalSize / brotli.wiki$DecompressTime

#save file
write.csv(snap.random, "snap_radom.csv")
write.csv(snap.bin, "snap_bin.csv")
write.csv(snap.wiki, "snap_wiki.csv")

write.csv(zstd.random, "zstd_radom.csv")
write.csv(zstd.bin, "zstd_bin.csv")
write.csv(zstd.wiki, "zstd_wiki.csv")

write.csv(lzfse.random, "lzfse_radom.csv")
write.csv(lzfse.bin, "lzfse_bin.csv")
write.csv(lzfse.wiki, "lzfse_wiki.csv")

write.csv(zlib.random, "zlib_radom.csv")
write.csv(zlib.bin, "zlib_bin.csv")
write.csv(zlib.wiki, "zlib_wiki.csv")

write.csv(brotli.random, "brotli_radom.csv")
write.csv(brotli.bin, "brotli_bin.csv")
write.csv(brotli.wiki, "brotli_wiki.csv")

write.csv(zlib.bin.rand, "zlib_bin_rand.csv")
write.csv(snap.bin.rand, "snap_bin_rand.csv")
write.csv(zstd.bin.rand, "zstd_bin_rand.csv")
write.csv(lzfse.bin.rand, "lzfse_bin_rand.csv")
write.csv(brotli.bin.rand, "brotli_bin_rand.csv")

write.csv(zlib.wiki.dir, "zlib_wiki_rand.csv")
write.csv(snap.wiki.dir, "snap_wiki_rand.csv")
write.csv(zstd.wiki.dir, "zstd_wiki_rand.csv")
write.csv(lzfse.wiki.dir, "lzfse_wiki_rand.csv")
write.csv(brotli.wiki.dir, "brotli_wiki_rand.csv")


#--- aggrate Method and samples
#compute the mean and median confidence interval for 50 sample for each file size
FileSizeList <- unique(snap.random$OriginalSize) #same for all method and file type
n <- length(FileSizeList)

#m,f,n,input,fsL
snap.random.aggregate <- SampleAggregate("snappy", "random", n, snap.random, FileSizeList)
snap.bin.aggregate <- SampleAggregate("snappy", "binary", n, snap.bin, FileSizeList)
snap.wiki.aggregate <- SampleAggregate("snappy", "wiki", n, snap.wiki, FileSizeList)

zstd.random.aggregate <- SampleAggregate("zstd", "random", n, zstd.random, FileSizeList)
zstd.bin.aggregate <- SampleAggregate("zstd", "binary", n, zstd.bin, FileSizeList)
zstd.wiki.aggregate <- SampleAggregate("zstd", "wiki", n, zstd.wiki, FileSizeList)

lzfse.random.aggregate <- SampleAggregate("lzfse", "random", n, lzfse.random, FileSizeList)
lzfse.bin.aggregate <- SampleAggregate("lzfse", "binary", n, lzfse.bin, FileSizeList)
lzfse.wiki.aggregate <- SampleAggregate("lzfse", "wiki", n, lzfse.wiki, FileSizeList)

zlib.random.aggregate <- SampleAggregate("zlib", "random", n, zlib.random, FileSizeList)
zlib.bin.aggregate <- SampleAggregate("zlib", "binary", n, zlib.bin, FileSizeList)
zlib.wiki.aggregate <- SampleAggregate("zlib", "wiki", n, zlib.wiki, FileSizeList)

brotli.random.aggregate <- SampleAggregate("brotli", "random", n, brotli.random, FileSizeList)
brotli.bin.aggregate <- SampleAggregate("brotli", "binary", n, brotli.bin, FileSizeList)
brotli.wiki.aggregate <- SampleAggregate("brotli", "wiki", n, brotli.wiki, FileSizeList)

#combine all method and file type togather 
write.csv(snap.random.aggregate, "snap_radom_agg.csv")
write.csv(snap.bin.aggregate, "snap_bin_agg.csv")
write.csv(snap.wiki.aggregate, "snap_wiki_agg.csv")

write.csv(zstd.random.aggregate, "zstd_radom_agg.csv")
write.csv(zstd.bin.aggregate, "zstd_bin_agg.csv")
write.csv(zstd.wiki.aggregate, "zstd_wiki_agg.csv")

write.csv(lzfse.random.aggregate, "lzfse_radom_agg.csv")
write.csv(lzfse.bin.aggregate, "lzfse_bin_agg.csv")
write.csv(lzfse.wiki.aggregate, "lzfse_wiki_agg.csv")

write.csv(zlib.random.aggregate, "zlib_radom_agg.csv")
write.csv(zlib.bin.aggregate, "zlib_bin_agg.csv")
write.csv(zlib.wiki.aggregate, "zlib_wiki_agg.csv")

write.csv(brotli.random.aggregate, "brotli_radom_agg.csv")
write.csv(brotli.bin.aggregate, "brotli_bin_agg.csv")
write.csv(brotli.wiki.aggregate, "brotli_wiki_agg.csv")

#save file
all <- rbind(snap.random.aggregate,snap.bin.aggregate,snap.wiki.aggregate,
             zstd.random.aggregate,zstd.bin.aggregate,zstd.wiki.aggregate,
             lzfse.random.aggregate,lzfse.bin.aggregate,lzfse.wiki.aggregate,
             zlib.random.aggregate,zlib.bin.aggregate,zlib.wiki.aggregate,
             brotli.random.aggregate,brotli.bin.aggregate,brotli.wiki.aggregate)

write.csv(all, "AllMethod_PerformanceMetric.csv")

