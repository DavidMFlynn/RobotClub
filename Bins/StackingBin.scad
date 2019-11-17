// ***************************************
// Stacking bin
// A small bin for small parts.
// by David M. Flynn
// License: MIT
// Created: 11/14/2019
// Revision: 1.0 11/17/2019
// Units: mm
// ***************************************
//  ***** History *****
// 1.0 11/17/2019 First rev'd version
// ***************************************
//  ***** for STL output
// StackingBin(X=60,Y=60,Z=14);
// ***************************************

$fn=$preview? 24:90;
Overlap=0.05;
IDXtra=0.2;

Bottom_Thickness=2.4;
Wall_Thickness=2.4;
Corner_r=4;
Stacking_Lip_h=1.5;
Stacking_Lip_w=1.2;

module RoundRect(X=10,Y=10,Z=3,R=1){
	hull(){
		translate([-X/2+R,-Y/2+R,0]) cylinder(r=R,h=Z);
		translate([X/2-R,-Y/2+R,0]) cylinder(r=R,h=Z);
		translate([-X/2+R,Y/2-R,0]) cylinder(r=R,h=Z);
		translate([X/2-R,Y/2-R,0]) cylinder(r=R,h=Z);		
	} // hull
} // RoundRect 

module RoundBottomRoundRect(X=10,Y=10,Z=3,R=1){
	hull(){
		translate([-X/2+R,-Y/2+R,R]) sphere(r=R);
		translate([X/2-R,-Y/2+R,R]) sphere(r=R);
		translate([-X/2+R,Y/2-R,R]) sphere(r=R);
		translate([X/2-R,Y/2-R,R]) sphere(r=R);	
		translate([-X/2+R,-Y/2+R,R]) cylinder(r=R,h=Z-R);
		translate([X/2-R,-Y/2+R,R]) cylinder(r=R,h=Z-R);
		translate([-X/2+R,Y/2-R,R]) cylinder(r=R,h=Z-R);
		translate([X/2-R,Y/2-R,R]) cylinder(r=R,h=Z-R);		
	} // hull
} // RoundRect 


module StackingBin(X=60,Y=60,Z=14){
	difference(){
		union(){
			RoundRect(X=X,Y=Y,Z=Z,R=Corner_r);
			
			difference(){
				hull(){
					translate([0,0,Z-3]) RoundRect(X=X,Y=Y,Z=3+Stacking_Lip_h,R=Corner_r);
					translate([0,0,Z]) RoundRect(X=X+Stacking_Lip_w*2,Y=Y+Stacking_Lip_w*2,Z=Stacking_Lip_h,R=Corner_r+Stacking_Lip_w);
				} // hull
				
				//translate([0,0,Z-3-Overlap]) RoundRect(X=X-10,Y=Y+10,Z=3+Stacking_Lip_h+Overlap*2,R=Corner_r);
				//translate([0,0,Z-3-Overlap]) RoundRect(X=X+10,Y=Y-10,Z=3+Stacking_Lip_h+Overlap*2,R=Corner_r);
			} // difference
		} // union
		
		// inside
		translate([0,0,Bottom_Thickness]) RoundBottomRoundRect(X=X-Wall_Thickness*2,Y=Y-Wall_Thickness*2,Z=Z,R=Corner_r-Wall_Thickness);
		
		// top
		translate([0,0,Z]) RoundRect(X=X+IDXtra*2,Y=Y+IDXtra*2,Z=3,R=Corner_r+IDXtra);
	} // difference
	
	
	
} // StackingBin

//StackingBin();





















