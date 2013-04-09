#analysis for Reich, P.B., Falster, D.S., Ellsworth, D.S., Wright, I.J., Westoby, M., Oleksyn, J. & Lee, T.D. (2009) Controls on declining carbon balance with leaf age among 10 woody species in Australian woodland: do leaves have zero daily net carbon balances when they die? New Phytologist, 183, 153-166.  

#load libaries
library(stats); library(smatr)
rm(list=ls(all=TRUE))
setwd("~/Documents/_projects/current/Falster - leaf age/analysis")

#load data
source('loadRawData.r');
#-----------------------------------------------
#Symbols and colours for plots
Fig = data.frame(Cols= rep(1, 9), Symb = c(15, 0 ,1,1,4,17,1,15,16))
plot(0, 0, type="n", ylim=c(0,10), xlim= c(0,5), ann = F, axes = F)
for(i in 1:9) points(1, 10-i, pch =Fig$Symb[i], col = Fig$Col[i], cex =2); 
text(1.2, 9:1, pos =4, labels = c("S1 - open sky, no ageing", 
                          "S2 - canopy", 
                          "S3 - NA", 
                          "S4 - within shoot", 
                          "S5 - extra shoot", 
                          "S6 - all shading", 
                          "S7 - NA", 
                          "S8 - leaf physiology", 
                          "S9 - all decline"));
dev.off();
#------------------------------------------------------------------------------
#species selections for plots 1 & 2
Select = data.frame(Spp= c(rep("acasua",3), rep("banobl", 3), rep("lamfor", 3)), Ind=c(c(2,5,40), c(40,51,90), c(14,50,55)));
#----------------------------------------------------------------------------
add.error.bar<-function(x, Ymin, Ymax, len, lty="solid")
  {segments(x, Ymin, x, Ymax, lty=lty)
   segments(x -len, Ymax, x+len, Ymax)
   segments(x -len, Ymin, x+len, Ymin)
   } 
 
 add.error.bar2<-function(x, Y, gap, Ymin, Ymax, len, lty = "solid")
  {
  if(Ymin < Y-gap)
  	{segments(x, Ymin, x, Y-gap, lty=lty)
    segments(x -len, Ymin, x+len, Ymin)}
  if(Ymax > Y+gap)
  	{segments(x, Y+gap, x, Ymax, lty=lty)
    segments(x -len, Ymax, x+len, Ymax)}
   } 
#-------------------------------------------------------------------------------
#GENERATE DATASETS
#Predicted values at end leaf lifespan - LIGHT INTERCEPTION
  L_abs<-NULL; L_pval<-NULL;
  for (i in 1:n.ind)
  	{
	#SUBSET BY PLANT
	Dat<-subset(Raw, fac.indiv==in.list[i])
	
    #ordinary regression - 
    reg.s2l <-lm(S2AV_L~ AGE, data = Dat)
    Xout<-data.frame(AGE = 0) 
    L.young = predict(reg.s2l, Xout)
    reg.s4l <- lm(S4AV_L ~ AGE, data = Dat)
	reg.s5l <- lm(S5AV_L ~ AGE, data = Dat); 
    reg.s6l <- lm(S6AV_L ~ AGE, data = Dat)
  
    L_pval<-rbind(L_pval,cbind(as.data.frame(Dat$SPP[1]), Dat$INDIV[1], anova(reg.s2l)[1,5], anova(reg.s6l)[1,5]))
    Xout<-data.frame(AGE = Dat$LL[1]) 
	L_abs<-rbind(L_abs,
 		   cbind(as.data.frame(Dat$SPP[1]), Dat$INDIV[1], Dat$LL[1],  
				L.young, predict(reg.s2l, Xout), predict(reg.s4l, Xout), predict(reg.s5l, Xout), predict(reg.s6l, Xout)))	  
  	}
 names(L_abs) = c("SPP", "INDIV", "LL", "Young", "S2", "S4", "S5", "S6")
 names(L_pval) = c("SPP", "INDIV", "S2", "S6")
 data.frame(L_pval[,1:2], L_pval[,3:4]<0.05);
 rm(reg.s2l, reg.s4l, reg.s5l, reg.s6l, Dat)
 L_sum_pval <- aggregate(L_pval[,3:4]<0.05, by = list(SPP=L_pval[,1]), sum)
  

#average by species - LIGHT
  L_Mean_abs = aggregate(L_abs[,4:8], by = list(SPP=L_abs[,1]), mean)
  L_Max_abs  = aggregate(L_abs[,4:8], by = list(SPP=L_abs[,1]), max)
  L_Min_abs  = aggregate(L_abs[,4:8], by = list(SPP=L_abs[,1]), min)    
#Fractional declines Light cpature 
  L_prop = data.frame(L_abs[,1:4], Lf_ang = (L_abs$S2 - L_abs$Young)/ L_abs$Young,  (L_abs[,6:7]-L_abs$S2 ) / L_abs$S2, Total = (L_abs$S6-L_abs$Young)/ L_abs$Young) 
  L_Mean_prop = aggregate(L_prop[,3:8], by = list(SPP=L_prop[,1]), mean)
  L_Max_prop  = aggregate(L_prop[,4:8], by = list(SPP=L_prop[,1]), max)
  L_Min_prop  = aggregate(L_prop[,4:8], by = list(SPP=L_prop[,1]), min)    
   
#Summary table for table 3 
  tab3 = data.frame(L_Mean_prop, L_Min_prop, L_Max_prop)
  write.table(tab3, "paper1/outputFiles/tab3_light_interception.txt", sep="\t"); 
  rm(tab3)

#---------------------------------------------------------------------------------
#Predicted values at end leaf lifespan - CARBON
  C_abs<-NULL; C_pval<-NULL;
  for (i in 1:n.ind){
	 #SUBSET BY PLANT
	Dat<-subset(Raw, fac.indiv==in.list[i])
	
  #ordinary regression - carbon daytime
  reg.s2c <-lm(S2AV_CD~ AGE, data = Dat)
  Xout<-data.frame(AGE = 0) 
  C.young = predict(reg.s2c, Xout)
  reg.s4c <- lm(S4AV_CD ~ AGE, data = Dat)
	reg.s5c <- lm(S5AV_CD ~ AGE, data = Dat); 
  reg.s6c <- lm(S6AV_CD ~ AGE, data = Dat)
	reg.s8c <- lm(S8AV_CD ~ AGE, data = Dat)
	reg.s9c <- lm(S9AV_CD ~ AGE, data = Dat);
  reg.s9N <- lm(S9AV_C ~ AGE, data = Dat);
  reg.s9W  <- lm(S9AV_CW ~ AGE, data = Dat)
 C_pval<-rbind(C_pval,cbind(as.data.frame(Dat$SPP[1]), Dat$INDIV[1], anova(reg.s2c)[1,5], anova(reg.s6c)[1,5], anova(reg.s9c)[1,5]))
 
 Xout<-data.frame(AGE = Dat$LL[1]) 
 C_abs<-rbind(C_abs,
 		   cbind(as.data.frame(Dat$SPP[1]), Dat$INDIV[1], Dat$LL[1],  
				C.young, predict(reg.s2c, Xout), predict(reg.s4c, Xout), predict(reg.s5c, Xout), predict(reg.s6c, Xout), 
        predict(reg.s8c, Xout), predict(reg.s9c, Xout), predict(reg.s9N, Xout), predict(reg.s9W, Xout)))
   }
 names(C_abs) = c("SPP", "INDIV", "LL", "Young", "S2", "S4", "S5", "S6", "S8", "S9", "Night", "WP")
 names(C_pval) = c("SPP", "INDIV", "S2", "S6", "S9")
 data.frame(C_pval[,1:2], C_pval[,3:5]<0.05)
 rm(reg.s2c, reg.s4c, reg.s5c, reg.s6c, reg.s8c, reg.s9c,  reg.s9N,  reg.s9W, Dat)

  C_Sum_pval = aggregate(C_pval[,3:5]<0.05, by = list(SPP=C_pval[,1]), sum)
 
#------------------------------------------------------------------------
#average by species

  C_Mean_abs = aggregate(C_abs[,4:12], by = list(SPP=C_abs[,1]), mean)
  C_Max_abs  = aggregate(C_abs[,4:12], by = list(SPP=C_abs[,1]), max)
  C_Min_abs  = aggregate(C_abs[,4:12], by = list(SPP=C_abs[,1]), min)   

#Fractional declines in daytime C balance- 
  C_prop = data.frame(C_abs[,1:4], Lf_ang = (C_abs$S2 - C_abs$Young)/ C_abs$Young,  (C_abs[,c(6,7,9,10)]-C_abs$S2 ) / C_abs$S2, S6 = (C_abs$S6-C_abs$Young)/ C_abs$Young, Total = (C_abs$S9-C_abs$Young)/ C_abs$Young) 
  C_Mean_prop = aggregate(C_prop[,3:11], by = list(SPP=C_prop[,1]), mean)
  C_Max_prop  = aggregate(C_prop[,4:11], by = list(SPP=C_prop[,1]), max)
  C_Min_prop  = aggregate(C_prop[,4:11], by = list(SPP=C_prop[,1]), min)    
   
#Summary table for table 3 
  Tab3 = data.frame(C_Mean_prop, C_Min_prop, C_Max_prop);
  write.table(Tab3, "paper1/outputFiles/tab3_carbonGain.txt", sep="\t"); 
  rm(Tab3)


#----------------------------------------------------------------------------------------------------------------
#Fig 1 - Example 
postscript("paper1/figs/fig1.eps", horizontal=FALSE, onefile=FALSE, height=8,width=6, pointsize=12, paper ="A4" )
#pdf("paper1/figs/figs/fig1.pdf", height=8,width=6, pointsize=10, paper ="special" )
par(mfcol=c(3,1), oma=c(5, 5, 3, 1), mai=c(0.6, 0.4, 0, 0))
j=0;
for(i in c(1,4,8))
  {
  j=j+1;  
  #data selection
  Dat = subset(Raw, Raw$SPP ==as.character(Select$Spp[i]) & Raw$INDIV==Select$Ind[i]);    
  Y_ax =seq(0, 30, 5); Y_ax2=seq(0, 30, 2.5);
  X_ax =seq(0, max(Dat$LL), 0.2); X_ax2 =seq(-0.2, max(Dat$LL), 0.1); 
  
  plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(Dat$LL) +0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", las=1)    
  axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=1, adj = 0.5)
  axis(4, at=Y_ax, labels=F,  tck=0.03)
  axis(1, at=X_ax, labels=X_ax, las=1, tck=0.03, cex.axis=1)
  axis(3, at=X_ax, labels=F, las=1, tck=0.03)
  axis(2, at=Y_ax2, labels=F, tck=0.015); axis(4, at=Y_ax2, labels=F, tck=0.015)
  axis(1, at=X_ax2, labels=F, tck=0.015); axis(3, at=X_ax2, labels=F, tck=0.015)
  box()
  
  if(j==2) mtext(expression(paste("Intercepted light (mol photons ", m^{-2},d^{-1},")")), side = 2, line = 3.0, outer = F, at= NA, cex =1.1)
  if(j==3) mtext(expression(paste("Leaf age (yrs)")), side = 1, line = 0, outer = T,  cex =1.1)
  if(j==1) Name = sp.list$Species[1]; 
  if(j==2) Name = sp.list$Species[3];  
  if(j==3) Name = sp.list$Species[9];  
  mtext(as.character(Name),  side = 3, line = 1.0, outer = F, cex =1.0)
  
  X<-Dat$AGE;   Xout<-data.frame(X = c(0,Dat$LL[1])) 
  Y<-Dat$S2AV_L;  	points(X,Y,type="p", pch=Fig$Symb[2], cex=1.3, col = "black")
  		R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col = "black", lty = "dotted")
  Y<-Dat$S4AV_L;   	points(X,Y,type="p", pch=Fig$Symb[4], cex=1.3, col = "black")
  		R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col = "black", lty = "dashed")
  Y<-Dat$S6AV_L;	points(X,Y,type="p", pch=Fig$Symb[6], cex=1.3, col = "black")
  		R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col = "black", lty = "solid")
 #legend("topright", legend = paste(Dat$SPP[1], " ", Dat$INDIV[1]), bty= "n")    
  }
dev.off(); rm(R, i, X, X_ax, X_ax2, Y_ax, Y_ax2, Y, Xout, Dat, Name)

#------------------------------------------------------------------------------        
#Fig 3 - paper
 # pdf("paper1/figs/fig3.pdf", height=8,width=8,pointsize=10, paper ="A4" )
 postscript("paper1/figs/fig3.eps", height=8,width=8,pointsize=12, paper ="A4", horizontal=F )

 par(mfcol=c(3,3), oma=c(5, 5, 3, 1), mai=c(0.2, 0.2, 0, 0))
 Y_ax =seq(-1, 0.25, 0.25); Y_ax2=seq(-1, 0.25, 0.125);
 for(j in 1:9)
    {
    Dat = subset(Raw, Raw$SPP ==as.character(Select$Spp[j]) & Raw$INDIV==Select$Ind[j]);   
    X_ax =seq(0, max(Dat$LL), 0.5); X_ax2 =seq(0, max(Dat$LL), 0.25); 
    plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(Dat$LL)+0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", lwd=1) 
  	axis(2, at=Y_ax, labels=F, tck=0.03);
  	axis(4, at=Y_ax, labels=F,  tck=0.03); 
    axis(1, at=X_ax, labels=F, tck=0.03); axis(3, at=X_ax, labels=F, tck=0.03)
    axis(2, at=Y_ax2, labels=F, tck=0.015); axis(4, at=Y_ax2, labels=F, tck=0.015)
    axis(1, at=X_ax2, labels=F, tck=0.015); axis(3, at=X_ax2, labels=F, tck=0.015)
	  box() 
   if(j<=3) axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=1, adj = 0.5);
   if(j==3 | j==6 | j ==9) axis(1, at=X_ax, labels=X_ax, las=1, tck=0.03, cex.axis=1);
   if(j==1) {mtext(as.character(sp.list$Species[1]),  side = 3, line = 1.0, outer = F, at= NA, adj = 0.5, cex =1.1)}   
   if(j==4) {mtext(as.character(sp.list$Species[3]),  side = 3, line = 1.0, outer = F, at= NA, adj = 0.5, cex =1.1)}
   if(j==7){mtext(as.character(sp.list$Species[9]),  side = 3, line = 1.0, outer = F, at= NA, adj = 0.5, cex =1.1)}	 
   X<-Dat$AGE;  Xout<-data.frame(X = c(0,Dat$LL[1])) 
   Y<-(Dat$S6AV_CD -Dat$S2AV_CD)/Dat$S2AV_CD;
      points(X,Y,type="p", pch=Fig$Symb[6], cex=1.2, col= Fig$Col[6])
      R<-lm( Y~ 0+  X); points(Xout$X, predict(R, Xout), type="l", lty="solid", lwd = 1.0)
   Y<-(Dat$S8AV_CD -Dat$S2AV_CD)/Dat$S2AV_CD;
       points(X,Y,type="l", lwd=1.6)
   }
  mtext(expression(paste("Proportion change in net daytime carbon balance")), side = 2, line = 3.0, outer = T, at= NA, adj = 0.5, cex =1.1)
  mtext("Leaf age (years)", side = 1, line = 2.0, outer = T, at= NA, adj = 0.5, cex =1.1) 	
dev.off();
rm(R,  X, X_ax, X_ax2, Y_ax, Y_ax2, Y, Xout, Dat, j)

#------------------------------------------------------------------------------        

#Fig 4 
#pdf("paper1/figs/fig4.pdf", height=7,width=12,pointsize=12, paper ="special" )
postscript("paper1/figs/fig4.eps", horizontal=FALSE, onefile=FALSE, height=7,width=12,pointsize=12)
  
  Order <-1:10; #order(C_Mean_prop[,3])
  Y_ax =seq(0.4, -1.2, -0.2); Y_ax2=seq(0.4, -1.2, -0.1);
  X_ax =seq(0.5, 9.5,1); 
  
  par(mai=c(2.0, 1.2, 0.5, 0.5))
  plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(0,10) , ylim=c(-1.2, 0.4), xaxs="i", yaxs="i", lwd=1)
  axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.02, adj = 0.5)
  axis(4, at=Y_ax, labels=F,  tck=0.02); 
  axis(2, at=Y_ax2, labels=F,  tck=0.01); axis(4, at=Y_ax2, labels=F,  tck=0.015); 
  axis(1, at=0:10, labels=F,  tck=-0.02);   axis(3, at=c(0,10), labels=F,  tck=0); 
  axis(1, at=seq(0.5, 9.5, 1), labels=as.character(sp.list[Order,1]), tick=0, las=3);     
  mtext("Proportion change in net daytime carbon balance", side = 2, line = 4.0, outer = F, at= NA, adj = 0.5, cex =1.1)	
  curve(0*x,from=0,to=10, lty="dotted", add= T)
  j=1;
  for(i in Order)
	 {
   	len = 0.05
   	points(j-0.8,  C_Mean_prop$S4[i], cex=1.3, pch=Fig$Symb[4], col = Fig$Col[4])
   		add.error.bar2(j-0.8, C_Mean_prop$S4[i], 0.03, C_Min_prop$S4[i], C_Max_prop$S4[i], len, lty= "solid")
	points(j-0.65, C_Mean_prop$S5[i], cex=1.3, pch=Fig$Symb[5], col = Fig$Col[5])
	 	add.error.bar2(j-0.65, C_Mean_prop$S5[i], 0.03, C_Min_prop$S5[i], C_Max_prop$S5[i], len, lty= "solid")
	points(j-0.5,  C_Mean_prop$S6[i], cex=1.3, pch=Fig$Symb[6], col = Fig$Col[6])
	 	add.error.bar2(j-0.5, C_Mean_prop$S6[i], 0.03, C_Min_prop$S6[i], C_Max_prop$S6[i], len, lty= "solid")
	points(j-0.35, C_Mean_prop$S8[i], cex=1.3, pch=Fig$Symb[8], col = Fig$Col[8])
	 	add.error.bar2(j-0.35, C_Mean_prop$S8[i], 0.03, C_Min_prop$S8[i], C_Max_prop$S8[i], len, lty= "solid")
	points(j-0.2,  C_Mean_prop$Total[i], cex=1.3, pch=Fig$Symb[9], col = Fig$Col[9])
	 	add.error.bar2(j-0.2, C_Mean_prop$Total[i], 0.03, C_Min_prop$Total[i], C_Max_prop$Total[i], len, lty= "solid")
	points(c(j,j), c(min(Y_ax), max(Y_ax)), type='l', lwd=0.05, lty="dashed", col="darkgray")
	j = j+1;
   	}
dev.off()

rm(i, X_ax, Y_ax, Y_ax2)


#----------------------------------------------------------------------------------------------------------------
#Fig 5
#pdf("paper1/figs/fig5.pdf", height=7,width=12,pointsize=12, paper ="special" )
postscript("paper1/figs/fig5.eps", height=6,width=12,pointsize=12, paper ="A4", horizontal=FALSE )

  Order <-1:10; #order(C_Mean_prop[,3])
  Y_ax =seq(-0.1, 0.25, 0.05); Y_ax2=seq(-0.1, 0.25, 0.01);
  X_ax =seq(0.5, 9.5,1); 
  
  par(mai=c(2.0, 1.2, 0.5, 0.5))
  plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(0,10) , ylim=c(-0.1, 0.25), xaxs="i", yaxs="i", lwd=1)
  axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.02, adj = 0.5)
  axis(4, at=Y_ax, labels=F,  tck=0.02); 
  axis(2, at=Y_ax2, labels=F,  tck=0.01); axis(4, at=Y_ax2, labels=F,  tck=0.015); 
  axis(1, at=0:10, labels=F,  tck=-0.02);   axis(3, at=c(0,10), labels=F,  tck=0); 
  axis(1, at=seq(0.5, 9.5, 1), labels=as.character(sp.list[Order,1]), tick=0, las=3);     
  mtext(expression(paste("Net daily carbon balance (mol ",CO[2], m^{-2},d^{-1},")")), side = 2, line = 4.0, outer = F, at= NA, adj = 0.5, cex =1.1)
  
  curve(0*x,from=0,to=10, lty="dotted", add= T)
  j=1;
  for(i in Order)
	{
   	len = 0.05
	text(j-0.84,   C_Mean_abs$Young[i], expression("12"["y"]), cex=0.6)
    		add.error.bar2(j-0.84, C_Mean_abs$Young[i], 0.0075,C_Min_abs$Young[i], C_Max_abs$Young[i], len)  
 	text(j-0.63,  C_Mean_abs$S9[i], expression("12"["lf"]), cex=0.6)
   			add.error.bar2(j-0.63, C_Mean_abs$S9[i], 0.0075, C_Min_abs$S9[i], C_Max_abs$S9[i], len)
 	text(j-0.42, C_Mean_abs$Night[i], expression("24"["lf"]), cex=0.6)
   			add.error.bar2(j-0.42,C_Mean_abs$Night[i], 0.0075, C_Min_abs$Night[i], C_Max_abs$Night[i], len)
	text(j-0.21,   C_Mean_abs$WP[i], expression("24"["pl"]), cex=0.6)
    		add.error.bar2(j-0.21, C_Mean_abs$WP[i], 0.0075,C_Min_abs$WP[i], C_Max_abs$WP[i], len)
	points(c(j,j), c(min(Y_ax), max(Y_ax)), type='l', lwd=0.05, lty="dashed", col="darkgray")
	j = j+1;
   	}
dev.off()
rm(i, X_ax, Y_ax, Y_ax2)

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
#EXTRA FIGS  - NOT USED IN PAPER

#pdf("paper1/figs/fig6.pdf", height=6,width=6, pointsize=10, paper ="special" )
postscript("paper1/figs/fig6.eps", height=6,width=6, pointsize=12, paper ="A4", horizontal=FALSE )

par(mfcol=c(3,1), oma=c(4, 1, 1, 1), mai=c(0.3, 0.8, 0.2, 0))
Y_ax =seq(0, 20, 5);
Brakes= seq(-0.1, 0.14, 0.01)

hist(C_abs$S9, ylim = c(0,20), breaks=Brakes, col="gray" , ylab =NULL, xlab =NULL, main = "12hr leaf", freq =F, axes=F, xaxs="i", yaxs="i")
axis(2, at=Y_ax, labels=F, tck=0.015); axis(4, at=Y_ax, labels=F, tck=0.015) 

hist(C_abs$Night, ylim = c(0,20), breaks=Brakes, col="gray" , ylab =NULL, xlab =NULL, main = "24hr leaf", freq =F, axes=F, xaxs="i", yaxs="i")
axis(2, at=Y_ax, labels=F, tck=0.015); axis(4, at=Y_ax, labels=F, tck=0.015) 
mtext("Frequency", side = 2, line = 3.0, outer = F, at= NA, adj = 0.5, cex =1.1)

hist(C_abs$WP, ylim = c(0,20), breaks=Brakes, col="gray" , ylab =NULL, xlab =NULL, main = "24hr plant", freq =F , axes=F)
axis(2, at=Y_ax, labels=F, tck=0.015); axis(4, at=Y_ax, labels=F, tck=0.015) 

axis(1, at=Brakes, labels=T, tck=-0.015, xaxs="i"); 
mtext(expression(paste("Net daily carbon balance (mol ",CO[2], m^{-2},d^{-1},")")), side = 1, line = 3.0, outer = F, at= NA, adj = 0.5, cex =1.1)	
dev.off()


#----------------------------------------------------------------------------------------------------------------
#Figure 1 - Plot different scenarios for each indiv LIGHT  (appendix - all species)
  pdf("paper1/figs/fig1_allspecies.pdf", height=10,width=6,pointsize=10, paper ="A4",onefile=TRUE)
 	for(n in 1:n.spp)
    {
    Ind = unique(Raw[Raw$SPP==as.character(sp.list$SPP[n]), "INDIV"]);
    I =    length(Ind);
    par(mfrow=c(I,1), oma=c(5,5,5, 2), mar=c(3, 0, 0, 0));
    for(i in 1:I)
        {   
        Dat = subset(Raw, Raw$SPP==as.character(sp.list$SPP[n]) & Raw$INDIV==Ind[i])   
        Y_ax =seq(0, 35, 10); Y_ax2=seq(0, 35, 5);
        X_ax =seq(0, max(Dat$LL), 0.2); X_ax2 =seq(0, max(Dat$LL), 0.1); 
        plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(Dat$LL)+0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", las=1)
        axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=0.8, adj = 0.5)
        axis(4, at=Y_ax, labels=F,  tck=0.03)
        axis(1, at=X_ax, labels=X_ax, las=1, tck=0.03, cex.axis=0.8)
        axis(3, at=X_ax, labels=F, las=1, tck=0.03)
        axis(2, at=Y_ax2, labels=F, tck=0.015); axis(4, at=Y_ax2, labels=F, tck=0.015)
        axis(1, at=X_ax2, labels=F, tck=0.015); axis(3, at=X_ax2, labels=F, tck=0.015)
        box()
        X<-Dat$AGE;  Xout<-data.frame(X = c(0,Dat$LL[1]))      
        
        Y<-Dat$S2AV_L;
        points(X,Y,type="p", pch=Fig$Symb[2], cex=1.3, col= Fig$Cols[2]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[2], lty = "dotted")

        Y<-Dat$S4AV_L;
        points(X,Y,type="p", pch=Fig$Symb[4], cex=1.3, col =Fig$Cols[4]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[4], lty = "dashed")

        Y<-Dat$S6AV_L;
        points(X,Y,type="p", pch=Fig$Symb[6], cex=1.3, col = Fig$Cols[6]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[6], lty = "solid")
       
        legend("topright", legend = paste("indiv = ",Ind[i]), bty= "n")  
       }
   mtext(expression(paste("Intercepted light (mol ", m^{-2},d^{-1},")")), side = 2, line = 3, outer = T, adj = 0.5, cex =1.2)
   mtext(expression(paste("Leaf age (yrs)")), side = 1, line = 0.2, outer = T, adj = 0.5, cex =1.2)
   mtext(as.character(sp.list$Species[n]), side = 3, line = 2, outer = T, adj = 0.5, cex =1.5)
   }
dev.off()
rm(R, Ind, I, i, X, X_ax, X_ax2, Y_ax, Y_ax2, Y, Xout, Dat)

#Figure 1 - Plot different scenarios for each indiv C gain   (appendix - all species)
  pdf("paper1/figs/fig1_allspecies-C.pdf", height=10,width=6,pointsize=10, paper ="A4",onefile=TRUE)
 	for(n in 1:n.spp)
    {
    Ind = unique(Raw[Raw$SPP==as.character(sp.list$SPP[n]), "INDIV"]);
    I =    length(Ind);
    par(mfrow=c(I,1), oma=c(5,5,5, 2), mar=c(3, 0, 0, 0));
    for(i in 1:I)
        {Dat = subset(Raw, Raw$SPP==as.character(sp.list$SPP[n]) & Raw$INDIV==Ind[i])   
        Y_ax =seq(0, 0.3, 0.05); Y_ax2=seq(0, 0.3, 0.25);
        X_ax =seq(0, max(Dat$LL), 0.2); X_ax2 =seq(0, max(Dat$LL), 0.1); 
        plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(Dat$LL)+0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", las=1) 
        axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=0.8, adj = 0.5)
        axis(4, at=Y_ax, labels=F,  tck=0.03)
        axis(1, at=X_ax, labels=X_ax, las=1, tck=0.03, cex.axis=0.8)
        axis(3, at=X_ax, labels=F, las=1, tck=0.03)
        axis(2, at=Y_ax2, labels=F, tck=0.015); axis(4, at=Y_ax2, labels=F, tck=0.015)
        axis(1, at=X_ax2, labels=F, tck=0.015); axis(3, at=X_ax2, labels=F, tck=0.015)
        box()
        X<-Dat$AGE;  Xout<-data.frame(X = c(0,Dat$LL[1]))      
        
        Y<-Dat$S2AV_CD;
        points(X,Y,type="p", pch=Fig$Symb[2], cex=1.3, col= Fig$Cols[2]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[2], lty = "dotted")

        Y<-Dat$S4AV_CD;
        points(X,Y,type="p", pch=Fig$Symb[4], cex=1.3, col =Fig$Cols[4]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[4], lty = "dashed")

        Y<-Dat$S6AV_CD;
        points(X,Y,type="p", pch=Fig$Symb[6], cex=1.3, col = Fig$Cols[6]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[6], lty = "solid")
       
        legend("topright", legend = paste("indiv = ",Ind[i]), bty= "n")  
       }
  mtext(expression(paste("Intercepted light (mol ", m^{-2},d^{-1},")")), side = 2, line = 3, outer = T, adj = 0.5, cex =1.2)
  mtext(expression(paste("Leaf age (yrs)")), side = 1, line = 0.2, outer = T, adj = 0.5, cex =1.2)
  mtext(as.character(sp.list$Species[n]), side = 3, line = 2, outer = T, adj = 0.5, cex =1.5)
  }
dev.off()
rm(R, Ind, I, i, X, X_ax, X_ax2, Y_ax, Y_ax2, Y, Xout, Dat)

#----------------------------------------------------------------------------------------------------------------
#Figure 1 - Plot scenario 2 for each indiv LIGHT  (appendix - all species)
  pdf("paper1/figs/fig1_allspecies_scen2.pdf", height=10,width=6,pointsize=10, paper ="A4",onefile=TRUE)
 	for(n in 1:n.spp)
    {
    Ind = unique(Raw[Raw$SPP==as.character(sp.list$SPP[n]), "INDIV"]);
    I =    length(Ind);
    par(mfrow=c(I,1), oma=c(5,5,5, 2), mar=c(3, 0, 0, 0));
    for(i in 1:I)
        {   
        Dat = subset(Raw, Raw$SPP==as.character(sp.list$SPP[n]) & Raw$INDIV==Ind[i])   
        Y_ax =seq(0, 35, 10); Y_ax2=seq(0, 35, 5);
        X_ax =seq(0, max(Dat$LL), 0.2); X_ax2 =seq(0, max(Dat$LL), 0.1); 
        plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(Dat$LL)+0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", las=1)
        axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=0.8, adj = 0.5)
        axis(4, at=Y_ax, labels=F,  tck=0.03)
        axis(1, at=X_ax, labels=X_ax, las=1, tck=0.03, cex.axis=0.8)
        axis(3, at=X_ax, labels=F, las=1, tck=0.03)
        axis(2, at=Y_ax2, labels=F, tck=0.015); axis(4, at=Y_ax2, labels=F, tck=0.015)
        axis(1, at=X_ax2, labels=F, tck=0.015); axis(3, at=X_ax2, labels=F, tck=0.015)
        box()
        X<-Dat$AGE;  Xout<-data.frame(X = c(0,Dat$LL[1]))      
        
        Y<-Dat$S2AV_L;
        points(X,Y,type="p", pch=Fig$Symb[2], cex=1.3, col= Fig$Cols[2]); 
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[2], lty = "dotted")
		
		#add point for young leaves - check regressions from table
		points(0, L_abs[L_abs$SPP==as.character(sp.list$SPP[n]) &  L_abs$INDIV==Ind[i],]$Young, type="p", pch = 19)
		
		#add averegae for indiv
		points(X, 0*X+mean(Y), type='l', col='red')
		
		#add averegae for spp
		points(X, 0*X+mean(Raw[Raw$SPP==as.character(sp.list$SPP[n]),]$S2AV_L), type='l', col='blue')
       }
   mtext(expression(paste("Intercepted light (mol ", m^{-2},d^{-1},")")), side = 2, line = 3, outer = T, adj = 0.5, cex =1.2)
   mtext(expression(paste("Leaf age (yrs)")), side = 1, line = 0.2, outer = T, adj = 0.5, cex =1.2)
   mtext(as.character(sp.list$Species[n]), side = 3, line = 2, outer = T, adj = 0.5, cex =1.5)
   }
dev.off()
rm(R, Ind, I, i, X, X_ax, X_ax2, Y_ax, Y_ax2, Y, Xout, Dat)

#----------------------------------------------------------------------------------------------------------------
#Fig 3 - appendix - all species
pdf("paper1/figs/fig3_allspecies.pdf", height=10,width=6,pointsize=10, paper ="A4",onefile=TRUE)
for(n in 1:n.spp)
    {
    Ind = unique(Raw[Raw$SPP==as.character(sp.list$SPP[n]), "INDIV"]);
    I =    length(Ind);
    par(mfrow=c(I,1), oma=c(6,5,5, 2), mar=c(2, 0, 0, 0));
    for(i in 1:I)
        {   
        Dat = subset(Raw, Raw$SPP==as.character(sp.list$SPP[n]) & Raw$INDIV==Ind[i])   
     		Y_ax =seq(-1, 0.25, 0.25); Y_ax2=seq(-1, 0.25, 0.125);
  	    X_ax =seq(0, max(Dat$LL), 0.2); X_ax2 =seq(0, max(Dat$LL), 0.1); 
        
        plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(X_ax)+0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", lwd=1) 
        axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=0.8, adj = 0.5)
  	    axis(4, at=Y_ax, labels=F,  tck=0.03); 
        axis(1, at=X_ax, labels=F, tck=0.03); axis(3, at=X_ax, labels=F, tck=0.03)
        axis(2, at=Y_ax2, labels=F, tck=0.015); axis(4, at=Y_ax2, labels=F, tck=0.015)
        axis(1, at=X_ax2, labels=F, tck=0.015); axis(3, at=X_ax2, labels=F, tck=0.015)
	    if(i==I)
		      {	axis(1, at=X_ax, labels=X_ax, las=1, tck=0.03, cex.axis=0.8)
       	    	mtext("Leaf age (years)", side = 1, line = 3.0, outer = T, at= NA, adj = 0.5, cex =1.1)
       	    	}	
        X<-Dat$AGE;        Xout<-data.frame(X = c(0,Dat$LL[1])) 
        
        Y<-(Dat$S4AV_CD -Dat$S2AV_CD)/Dat$S2AV_CD;
        points(X,Y,type="p", pch=Fig$Symb[4], cex=1.2, col= Fig$Col[4])
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", lty = "dotted")
	      
        Y<-(Dat$S6AV_CD -Dat$S2AV_CD)/Dat$S2AV_CD;
       	points(X,Y,type="p", pch=Fig$Symb[6], cex=1.2, col= Fig$Col[6])
    	R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", lty="dashed")
        
        Y<-(Dat$S8AV_CD -Dat$S2AV_CD)/Dat$S2AV_CD;
        points(X,Y,type="l", cex=1.2, col= Fig$Col[8])
        legend("topright", legend = paste("indiv = ",Ind[i]), bty= "n")  	    
  	   }    
    mtext(as.character(sp.list$Species[n]),  side = 3, line = 2.0, outer = T, at= NA, adj = 0.5, cex =1.5)
    mtext(expression(paste("Proportion change in net daily C balance (0-1")), side = 2, line = 3.0, outer = T, at= NA, adj = 0.5, cex =1.1)
	 }
dev.off()

	

