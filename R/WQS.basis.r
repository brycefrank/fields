# fields, Tools for spatial data
# Copyright 2004-2007, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html

"WQS.basis" <-
function (N, cut.n = 8) 
{
Wtransform( diag(1,N), inv=TRUE,cut.min=cut.n)
}
