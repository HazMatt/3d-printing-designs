// Aegean Sea isalnd mats

$fn= $preview ? 32 : 128;

// sleeved card
cx = 67;
cy = 94;
// space around card in inset
spc = 1;
// depth of card inset
cdp = 2.5;

// border around card on mat
brd = 7;

// mat base thickness
bsx = 3.5;

// feet height
ft = 3;

pegR = 1.5;

matX = cx+(spc*2)+(brd*2);
matY = cy+(spc*2)+(brd*2);
matZ = bsx; // +ft;

islandMat();

translate([cx/2, cy/2+16, 0])
    matFeetPeg();
translate([cx/2-10, cy/2+16, 0])
    matFeetPeg();
translate([cx/2-20, cy/2+16, 0])
    matFeetPeg();
translate([cx/2-30, cy/2+16, 0])
    matFeetPeg();

// cube(size=[68, 94, 5], center=true);

module islandMat(){
    difference(){
        roundedRect([matX, matY, matZ], 2);

        // card inset
        translate([0, 0, matZ-cdp])
            roundedRect([cx+spc, cy+spc, cdp+1], 2);

        // finger insets
        translate([cx/2, 0, matZ-cdp])
            cylinder(h=cdp+1, r=brd, center=false, $fn=20);
        translate([-cx/2, 0, matZ-cdp])
            cylinder(h=cdp+1, r=brd, center=false, $fn=20);

        // peg holes
        translate([(cx/2)+5, cy/2+5, 1])
            peg(matZ+0.07);

        translate([(-cx/2)-5, cy/2+5, 1])
            peg(matZ+0.07);

        translate([(cx/2)+5, -cy/2-5, 1])
            peg(matZ+0.07);

        translate([(-cx/2)-5, -cy/2-5, 1])
            peg(matZ+0.07);

        // border waves
        translate([(cx/2)+7.5, 18, 3])
            wave(.5, 3, 5);

        translate([(cx/2)+7.5, -38, 3])
            wave(.5, 3, 5);

        translate([14, 54.5, 3])
            rotate([0, 0, 90])
                wave(.5, 4, 5);

        translate([-14, -54.5, 3])
            rotate([0, 0, -90])
                wave(.5, 4, 5);

    }
    // big waves
    translate([12, -40, 0])
        wave(1, 7);
    translate([-3, 40, 2])
        rotate([180, 0, 0])
            wave(1, 7);

    // translate([(cx/2)+5, cy/2+5, -3])
    //     matFeetPeg();

}

module matFeet() {
    difference() {
        roundedRect([brd-1, brd-1, ft], 2);
        translate([0, 0, ft-0.2])
            roundedRect([brd-2.5, brd-2.5, ft], 2);
    }
}

module matFeetPeg() {
    roundedRect([brd-1, brd-1, ft], 2);
    translate([0, 0, ft])
        peg();
}

module peg(size=matZ) {
    //cylinder(h=matZ, r=pegR, center=true);
    cube([size,size,size+2], true);
}

module spiral(size=1) {
    rotate([0, 0, 90])
    linear_extrude(height = 2, center = false, convexity = 5)
        scale(size)
        import("spiral.svg", dpi = 100);
}

module wave(size=1, length=3, space=10) {
    spiral(size);
    for (i = [1:length]) {
        translate([0, space*i, 0])
            spiral(size);
    }
    
}

module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height=z)
    hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);
    }
}
