#Archivo para analizar el sobrelape que existe entre las coordenadas del archivo bed y rangos de promotores de la base de datos Agris para Arabidopsis
#NOTA: para analizar los archivos bed es necesario eliminar las primeras lineas que tienen los detalles de los experimentos de swembl.


source("http://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")


#Generando un dataframe para los rangos de promotores
df_promoter <- read.table("/Users/Bernardo/Desktop/PromoterInfo.tbl", header = FALSE, sep="\t")


#Generando un dataframe para los rangos de los archivos bed
df_bed <- read.table("/Users/Bernardo/Desktop/AT1_0.01.bed", header = FALSE, sep="\t")


library(GenomicRanges)

GR_promoter <-makeGRangesFromDataFrame(df_promoter, start.field="V4", end.field="V5", seqnames.field="V2")
GR_bed <- makeGRangesFromDataFrame(df_bed, start.field="V2", end.field="V3", seqnames.field="V1")


#Utilizando la funcion subsetByOverlaps, que extrae los elementos en el query que sobrelapan por lo menos con un elemento del subject
a <- subsetByOverlaps(GR_bed, GR_promoter)


#Numero de rangos de promotores de la base de datos Agris
print("Numero de rangos de promotores de la base de datos Agris: ")
nrow(df_promoter)

#Numero de coordenadas en el archivo .bed
print("Numero de coordenadas en el archivo .bed: ")
nrow(df_bed)

#Numero de sobrelapes entre el archivo bed y los rangos de promotores
print("Numero de sobrelapes entre el archivo bed y los rangos de promotores: ")
length(a)

