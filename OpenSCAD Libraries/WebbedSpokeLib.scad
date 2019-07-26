// **********************************************************
// Webbed Spoke Library
// Filename: WebbedSpokeLib.scad
// Created: 11/1/2018
// Revision: 1.0 11/1/2018
// Units: mm
// *********************************************************
// History:
// 1.0 11/1/2018 First code
// *********************************************************
// Usage:
// for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
//    WebbedSpoke(ID=25,OD=100,Spoke_w=5,Spoke_h=2,Web_h=4);
// *********************************************************
// Routines
// WebbedSpoke(ID=25,OD=100,Spoke_w=5,Spoke_h=2,Web_h=4);
// *********************************************************

$fn=90;
Overlap=0.05;
IDXtra=0.2;

module WebbedSpoke(ID=25,OD=100,Spoke_w=5,Spoke_h=2,Web_h=4){
	difference(){
		union(){
			translate([-Spoke_w,0,0]) cube([Spoke_w*2,OD/2,Spoke_h]);
			if (Web_h != 0)
				translate([-Spoke_h/2,0,0]) cube([Spoke_h,OD/2+IDXtra,Web_h*1.5]);
		} // union
		
		// left and right edges
		for (j=[0:1]) mirror([j,0,0]){
		hull(){			
			rotate([0,0,atan2(Spoke_w,ID/2+Spoke_w/2)]) translate([0,ID/2+Spoke_w/2-Overlap,-Overlap])
				cylinder(d=Spoke_w,h=Spoke_h+Overlap*2);
				
			
			rotate([0,0,atan2(Spoke_w,OD/2-Spoke_w/2)]) translate([0,OD/2-Spoke_w/2,-Overlap])
				cylinder(d=Spoke_w,h=Spoke_h+Overlap*2);
		} // hull
		
		rotate([0,0,atan2(Spoke_w,ID/2+Spoke_w/2)]) translate([0,ID/2+Spoke_w/2-Overlap,-Overlap])mirror([1,1,0])
			cube([Spoke_w,Spoke_w,Spoke_h+Overlap*2]);
	}

		// trim ID
		translate([0,0,-Overlap]) cylinder(d=ID-Overlap,h=Spoke_h+Web_h*1.5+Overlap*2);
	
		// trim OD
		difference(){
			translate([0,0,-Overlap]) cylinder(d=OD+Spoke_w+Overlap,h=Spoke_h+Web_h+Overlap*2);
			translate([0,0,-Overlap*2]) cylinder(d=OD+Overlap,h=Spoke_h+Web_h+Overlap*4);
		} // diff
		
		// top of web
		if (Web_h != 0){
			hull(){
				translate([-Spoke_h/2-Overlap,ID/2+Web_h,Web_h*2]) rotate([0,90,0])
					cylinder(d=Web_h*2,h=Spoke_h+Overlap*2);
				translate([-Spoke_h/2-Overlap,OD/2-Web_h,Web_h*2]) rotate([0,90,0])
					cylinder(d=Web_h*2,h=Spoke_h+Overlap*2);
			} // hull
			
		} // if
	} // diff
} // WebbedSpoke

//WebbedSpoke();