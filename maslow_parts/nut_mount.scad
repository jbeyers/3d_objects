//rotate(a=[0,180,0])
$fn=60;
difference() {
    import ("Maslow_Nut_Mount.stl");
//    translate([-50,0,-50]) cube([100,100,100]);
    difference() {
        cylinder(r=15.8/2, h=100);
        cylinder(r=12.2/2, h=100);
   
    }
}
