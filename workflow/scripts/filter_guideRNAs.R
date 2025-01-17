analysis =function(input, output, log) {
    #Log 
    out <- file(log$out, open = "wt")

    err <- file(log$err, open = "wt")

    sink(out, type = "output")

    sink(err, type = "message")

    #Script
    library(edgeR)
    x=readRDS(input$rds)
    sel=rowSums(cpm(x$counts)>0.5)>=3
    x=x[sel,]
    saveRDS(x, file = output$rds)
    png(output$plot,width=4000, height=2000, res=400)
        par(mfrow=c(2,1))
        barplot(colSums(x$counts), las=2, main="Counts per index", cex.names=0.5, cex.axis=0.8)
        barplot(rowSums(x$counts), las=2, main="Counts per guide RNA", cex.names=0.5, cex.axis=0.8)
    dev.off()
}

analysis(snakemake@input, snakemake@output, snakemake@log)