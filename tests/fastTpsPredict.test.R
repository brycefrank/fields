 # fields is a package for analysis of spatial data written for
  # the R software environment .
  # Copyright (C) 2018
  # University Corporation for Atmospheric Research (UCAR)
  # Contact: Douglas Nychka, nychka@ucar.edu,
  # National Center for Atmospheric Research,
  # PO Box 3000, Boulder, CO 80307-3000
  #
  # This program is free software; you can redistribute it and/or modify
  # it under the terms of the GNU General Public License as published by
  # the Free Software Foundation; either version 2 of the License, or
  # (at your option) any later version.
  # This program is distributed in the hope that it will be useful,
  # but WITHOUT ANY WARRANTY; without even the implied warranty of
  # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  # GNU General Public License for more details.


suppressMessages(library(fields))
options(echo=FALSE)
test.for.zero.flag<-1
set.seed(123)
nc<- 10
center<- matrix( runif(nc*2), nc,2)
grid.list<- list( x= seq(0,1,,10), y=seq( 0,1,,15))
coef<- rnorm( nc)
delta<- .3

out<- multWendlandGrid( grid.list,center, delta, coef)


xg<- make.surface.grid( grid.list)
test<-  Wendland2.2(  rdist( xg, center)/delta)%*% coef
test.for.zero.flag<-1 
test.for.zero( test, out, tag="Comparing FORTRAN grid eval to matrix vector multiplication")





# testing predictSurface function
nc<- 100
set.seed(12)
x<- matrix( runif(nc*2), nc,2)

y<- rnorm( nc)
delta<- .2
obj<- fastTps( x,y, theta=delta, lambda=.1)

grid.list<- list( x= seq(0,1,,3), y=seq( 0,1,,4))
xg<- make.surface.grid( grid.list)
look0<- c(predict( obj, xg))
look1<- predictSurface( obj, grid.list, extrap=TRUE)
look2<-  predict.mKrig( obj, xg)
test.for.zero( look0, c(look1$z), tag="testing PredictSurface and predict.fastTps")
test.for.zero( look0, c(look2), tag="testing PredictSurface with slower mKrig predict")

# new y
set.seed(123)
 ynew<- rnorm( nc)
 look0<- c(predict( obj, xg, ynew=ynew))
 look1<- predictSurface( obj, grid.list, ynew=ynew, extrap=TRUE)
 look2<- c(predict(fastTps( x,ynew, theta=delta, lambda=.1) , xg, ynew=ynew))
 test.for.zero( look0, look2,tag="predict with ynew")
 test.for.zero( look0, c(look1$z), tag="predictSurface with ynew")
options( echo=TRUE)
#
