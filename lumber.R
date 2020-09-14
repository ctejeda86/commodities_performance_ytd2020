setwd("C:\\Users\\HP\\Documents\\Termo\\Sep 2020\\lumber")
library(dplyr)
library(ggplot2)
library(lubridate)
library(ggrepel)
library(grid)
library(gridExtra)
datos<-read.csv(file="Lumber_Futures_Historical_Data.csv",
                header=TRUE,dec=".",fill=TRUE)
variables<-c("fecha","precio","open","high",
             "low","vol","varpor")
names(datos)=variables
print(datos,digits=5)
datos$fecha<-mdy(datos$fecha)
library(directlabels)
library(lattice)
#ver máximos de precio
which.max(datos$precio)
datos$fecha[(which.max(datos$precio))]
#ver mínimos de precio
which.min(datos$precio)
datos$fecha[(which.min(datos$precio))]
#crear nueva columna para referenciar etiquetas en gráfico
datos$datlabels<-""
ix_datlab<-c(1,65,172,177)
datos$datlabels[ix_datlab]<-datos$precio[ix_datlab]
varporce<-((datos[177,2]/datos[1,2])-1)*100



#gráfica
x11()
ggplot(data=datos,aes(x=fecha,y=precio,label=datlabels))+
  #si no le pongo color no se grafica nada, aplica igual para
  #geom_point
  geom_line(color="darkorange4")+
  labs(x="Mes",y="USD por 1,000 pies tablares")+
  #título
  ggtitle("Madera")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_classic()+
  #sirve para ajustar eje y que comience en 10 y hasta 25
  coord_cartesian(ylim = c(0, 930))+
  #agrega la etiqueta repel
  geom_text_repel(color="darkorange4")+
  #agregar anotación con variación porcentual
  #MUY IMPORTANTE, USAR as.Date para series de tiempo (eje x)
  annotate(geom="text", x =as.Date("2020-08-24"), 
           y = 500,
           label = "Rend. en 2020:
           122.05%")

comm<-read.table(file="comm.txt",header=TRUE,quote="\t")
nombrescom<-c("fecha","oro","plata","wti")
names(comm)=nombrescom
comm$fecha<-mdy(comm$fecha)


