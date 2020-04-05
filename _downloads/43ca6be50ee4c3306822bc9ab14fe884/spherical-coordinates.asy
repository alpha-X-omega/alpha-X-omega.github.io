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

real rho = 7;
real theta = radians(55);
real phi = radians(35);

//connect origin to point in space
triple P = (rho * sin(theta) * cos(phi),
            rho * cos(theta),
            rho * sin(theta) * sin(phi));
draw(O -- P, L=Label("$\rho$", p=orange + fontsize(17pt)),
     p=orange + longdashdotted);

//project onto XZ-plane
triple P_xz = (rho * sin(theta) * cos(phi), 0, rho * sin(theta) * sin(phi));
draw(O -- P_xz, L=Label("$r$", p=red + fontsize(17pt)), p=red + dashed);
draw(getRightAnglePath(O, P_xz, P), p=red);
draw(P_xz -- P, L=Label("$y$", p=red + fontsize(17pt)), p=red + dashed);

//project onto X-axis
triple Pr_x = (rho * sin(theta) * cos(phi), 0, 0);
draw(P_xz -- Pr_x, p=brown + Dotted);
draw(getRightAnglePath(P_xz, Pr_x, O), p=brown);

//project onto Y-axis
triple Pr_y = (0, rho * cos(theta), 0);
draw(P -- Pr_y, p=red + dashed);
draw(getRightAnglePath(P, Pr_y, O), p=red);

//label the angles
draw(arc(O, 1.5 * unit(Pr_x - O), 1.5 * unit(P_xz - O)),
     L=Label("$\phi$", p=blue + fontsize(17pt), align=1.5E),
     arrow=Arrow3, p=blue);
draw(arc(O, 2.0 * unit(Pr_y - O), 2.0 * unit(P - O)),
     L=Label("$\theta$", p=blue + fontsize(17pt), align=NE),
     arrow=Arrow3, p=blue);

//label the dot and overwriting everything before it
dotfactor *= 1.5;
dot(P, L=Label("$P(\rho, \theta, \phi)$", p=fontsize(17pt)));
