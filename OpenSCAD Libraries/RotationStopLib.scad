// *******************************************
// Rotation Stop 690° max rotation
// by: David M. Flynn
// Filename: RotationStopLib.scad
// Created: 9/18/2019
// Revision: 1.0.1 9/18/2019
// Units: mm
// *******************************************
//  ***** History *****
echo("RotationStopLib 1.0.1");
// 1.0.1 9/18/2019 Inner ring fix.
// 1.0.0 9/18/2019 First code.
// *******************************************
//  ***** for STL output *****
// rotate([180,0,0]) OuterRing(D=OuterRing_OD,Stop_a=10,H=Ring_H,Retainer=true);
// InnerRing(D=InnerRing_OD(OuterRing_OD),Stop_a=10,H=Ring_H,Retainer=true);
// StopRing(OD=StopRing_OD(OuterRing_OD),Stop_a=10,H=Ring_H-0.5);
// *******************************************
//  ***** Routines *****
// function InnerRing_OD(OD)
// function StopRing_OD(OD)
// *******************************************
//  ***** for Viewing *****
// rotate([0,0,155]) InnerRing(D=InnerRing_OD(OuterRing_OD),Stop_a=10,H=Ring_H,Retainer=true);
// OuterRing(D=OuterRing_OD,Stop_a=10,H=Ring_H,Retainer=true);
// translate([0,0,0.25]) rotate([0,0,167.5]) 
// StopRing(OD=StopRing_OD(OuterRing_OD),Stop_a=10,H=Ring_H-0.5);
// *******************************************


$fn=$preview? 24:90;
IDXtra=0.2;
Overlap=0.05;

Wall_t=3;
Retainer_t=0.9;
Stop_t=3;
OuterRing_OD=100;
Ring_H=6;

function InnerRing_OD(OD)=OD-Wall_t*4-Stop_t*4-IDXtra*4;
function StopRing_OD(OD)=OD-Wall_t*2-Stop_t*2-IDXtra*2;

module InnerRing(D=InnerRing_OD(OuterRing_OD),Stop_a=10,H=Ring_H,Retainer=false){
	// outer ring
	difference(){
		cylinder(d=D,h=H,$fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=D-Wall_t*2,h=H+Overlap*2,$fn=$preview? 90:360);
	} // difference
	
	// Retainer
	if (Retainer==true)
		difference(){
			translate([0,0,-Retainer_t]) cylinder(d=D+Wall_t*2+Stop_t*2,h=Retainer_t+Overlap,$fn=$preview? 90:360);
			
			// inside
			translate([0,0,-Retainer_t-Overlap]) cylinder(d=D-Wall_t*2,h=Retainer_t+Overlap*3,$fn=$preview? 90:360);
		} // if

	// stop
	difference(){
		union(){
			translate([D/2-Wall_t,-Overlap,0]) cube([Wall_t-1+Stop_t+2, D*PI*(Stop_a/360),H]);
			translate([D/2-Wall_t,Overlap,0]) mirror([0,1,0]) cube([Wall_t-1+Stop_t+2, D*PI*(Stop_a/360),H]);
		} // union
		
		// trim outside
		difference(){
			translate([0,0,-Overlap]) cylinder(d=D+20,h=H+Overlap*2);
			translate([0,0,-Overlap*2]) cylinder(d=D+Stop_t*2,h=H+Overlap*4);
		} // difference
		
		// trim inside
		translate([0,0,-Overlap]) cylinder(d=D-1,h=H+Overlap*2);
		
		// trim ends
		rotate([0,0,Stop_a/2]) translate([D/2-2,0,-Overlap]) cube([Wall_t+Stop_t*2+2,20,H+Overlap*2]);
		rotate([0,0,-Stop_a/2]) translate([D/2-2,0,-Overlap]) mirror([0,1,0]) cube([Wall_t+Stop_t*2+2,20,H+Overlap*2]);
	} // difference
} // OuterRing

//rotate([0,0,155]) InnerRing(D=OuterRing_OD-Wall_t*4-Stop_t*4-IDXtra*4,H=Ring_H,Retainer=true);

module OuterRing(D=OuterRing_OD,Stop_a=10,H=Ring_H,Retainer=false){
	
	// outer ring
	difference(){
		cylinder(d=D,h=H,$fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=D-Wall_t*2,h=H+Overlap*2,$fn=$preview? 90:360);
	} // difference
	
	// Retainer
	if (Retainer==true)
		difference(){
			translate([0,0,H-Overlap]) cylinder(d=D,h=Retainer_t,$fn=$preview? 90:360);
			
			translate([0,0,H-Overlap*2]) cylinder(d=D-Wall_t*4-Stop_t*2,h=Retainer_t+Overlap*3,$fn=$preview? 90:360);
		}
	
	
	// stop
	difference(){
		union(){
			translate([-D/2+1,-Stop_t/2,0]) cube([Wall_t-1+Stop_t+2, D*PI*(Stop_a/360),H]);
			translate([-D/2+1,-Stop_t/2,0]) mirror([0,1,0]) cube([Wall_t-1+Stop_t+2, D*PI*(Stop_a/360),H]);
		} // union
		
		// trim outside
		difference(){
			translate([0,0,-Overlap]) cylinder(d=D+10,h=H+Overlap*2);
			translate([0,0,-Overlap*2]) cylinder(d=D-1,h=H+Overlap*4);
		} // difference
		
		// trim inside
		translate([0,0,-Overlap]) cylinder(d=D-Wall_t*2-Stop_t*2,h=H+Overlap*2);
		
		// trim ends
		rotate([0,0,-Stop_a/2]) translate([-D/2,0,-Overlap]) cube([Wall_t+Stop_t*2,20,H+Overlap*2]);
		rotate([0,0,Stop_a/2]) translate([-D/2,0,-Overlap]) mirror([0,1,0]) cube([Wall_t+Stop_t*2,20,H+Overlap*2]);
	} // difference
} // OuterRing

//OuterRing(D=OuterRing_OD,H=Ring_H,Retainer=true);

module StopRing(OD=StopRing_OD(OuterRing_OD),Stop_a=10,H=Ring_H-0.5){
	rotate([0,0,180]) OuterRing(D=OD,Stop_a=Stop_a,H=H,Retainer=false);
	InnerRing(D=OD,Stop_a=Stop_a,H=H);
} // StopRing

//translate([0,0,0.25]) rotate([0,0,167.5]) StopRing(OD=StopRing_OD(OuterRing_OD),H=Ring_H);



















