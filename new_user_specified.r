input=as.matrix(read.table("index.txt",header=T,sep="\t",fill=T))
file_name=input[,1]
par_name=paste("P",file_name,sep="")
nsample=length(file_name)

intensity=list()
baseline=list()
r.time=list()
#nsegment.base=32
n=1.5
win_size=11
peak_points=41
source("../Baseline correction function dad.r")
for(i in 1:nsample)
{
 intensity[[i]]=read.table(file_name[i],header=F,sep="\t")[,1]
 intensity[[i]]=intensity[[i]]-min(intensity[[i]])
 r.time[[i]]=(1:length(intensity[[i]]))*no_secs/60
 baseline[[i]]=baseline_correction(intensity[[i]],r.time[[i]],peak_points,n, win_size)
 windows()
 plot(r.time[[i]],intensity[[i]],type="l",main=file_name[i])
 lines(r.time[[i]],baseline[[i]],col=2)
 intensity[[i]]=intensity[[i]]-baseline[[i]]
 intensity[[i]][intensity[[i]]<=0]=0
 intensity[[i]]=intensity[[i]]+1  
 lines(r.time[[i]],intensity[[i]],col=3) 
 write.table(intensity[[i]],file=file_name[i],row.names=F,col.names=F,sep="\t")
}



