//project the scene to a 2D vector format
settings.render = 0;

import grid3;

//project a point P onto the line segment SE
triple project(triple S, triple P, triple E) {
    triple A = P - S;
    triple B = E - S;

    return S + dot(A, B) / dot(B, B) * B;
}

path3 getRightAnglePath(triple A, triple B, triple C, real scale=0.02cm) {
    //ABC forms a right angle
    triple BA = B + unit(A - B) * scale;
    triple BC = B + unit(C - B) * scale;

    //form an isosceles right triangle
    triple TBA = B + unit(A - B) * scale * 2.0;
    triple TBC = B + unit(C - B) * scale * 2.0;

    //midpoint of isosceles right triangle forms the desired marker
    triple MPT = project(TBA, B, TBC);

    return BA -- MPT -- BC;
}

currentprojection = obliqueZ;

limits((0, 0, 0), (5, 5, 5));
size(10cm);

xaxis3(Label("$X$", align=E), arrow=Arrow3);
yaxis3(Label("$Y$", align=N), arrow=Arrow3);
zaxis3(Label("$Z$", align=SW), arrow=Arrow3);

real radius = 6;
real phi = radians(45);
real y = 5;

//label point in space
triple P = (radius * cos(phi), y, radius * sin(phi));
dot(P, L=Label("$P(r, \phi, y)$", p=fontsize(17pt)));

//project onto XZ-plane
triple P_xz = (radius * cos(phi), 0, radius * sin(phi));
draw(O -- P_xz, L=Label("$r$", p=red + fontsize(17pt)), p=red + dashed);
draw(getRightAnglePath(O, P_xz, P), p=red);
draw(P_xz -- P, L=Label("$y$", p=red + fontsize(17pt)), p=red + dashed);

//project onto X-axis
triple Pr_x = (radius * cos(phi), 0, 0);
draw(P_xz -- Pr_x, p=red + dashed);
draw(getRightAnglePath(P_xz, Pr_x, O), p=red);

draw(arc(O, unit(Pr_x - O), unit(P_xz - O)),
     L=Label("$\phi$", p=blue + fontsize(17pt), align=0.25SE),
     arrow=Arrow3, p=blue);
