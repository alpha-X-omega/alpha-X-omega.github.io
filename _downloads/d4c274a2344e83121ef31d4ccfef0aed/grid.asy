//project the scene to a 2D vector format
settings.render = 0;

//http://www.piprime.fr/developpeur/asymptote/examples-asy3d/grid3-asy/
import grid3;

currentprojection = obliqueZ;

limits((0, 0, 0), (5, 5, 5));
size(10cm);

xaxis3(Label("$X$", align=E), arrow=Arrow3);
yaxis3(Label("$Y$", align=N), arrow=Arrow3);
zaxis3(Label("$Z$", align=SW), arrow=Arrow3);

grid3(XYZgrid, end=false, Step=1);
