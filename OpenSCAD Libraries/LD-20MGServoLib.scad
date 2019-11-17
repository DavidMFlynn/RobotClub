// **************************************************
// LD-20MG Servo Library
// David M. Flynn
// Filename: LD-20MGServoLib.scad
// Created: 7/16/2018
// Rev: 1.1.1 9/29/2019	
// Units: millimeters
// **************************************************
// History:
	echo("LD-20MGServoLib 1.1.1");
// 1.1.1 9/29/2019 Added extra width and height to Servo_HX5010
// 1.1.0 9/27/2019 Added HX5010 servo
// 1.0.0 7/16/2018 Coppied from HS-5245MGServoLib.scad
// **************************************************
// Notes:
//  Mounting of R/C mini servo HS-5245MG.
//  ToDo: Servo wheel needs adjusting.
// **************************************************
// Routines
//	Servo_LD20MG(BottomMount=false,TopAccess=false);
//  Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
//	LD20MGServoWheel();
// **************************************************

include<CommonStuffSAEmm.scad>

$fn=90;

module Servo_LD20MG(BottomMount=true,TopAccess=true){
	Servo_Shaft_Offset=9.85; // this moves double
	Servo_BoltSpace=10;
	Servo_BoltSpace2=49.4;
	Servo_x=54.5;
	Servo_h1=28.2; // bottom of servo to bottom of mount
	Servo_w=20.2;
	Servo_Body_l=40.5;
	Servo_Deck_h=3.2;
	Servo_TopStep_h=9.7;
	Servo_TopOfWheel=21.4;
	
	translate([-Servo_Shaft_Offset,0,0]){
	// body
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2,-Servo_h1])cube([Servo_x,Servo_w,Servo_h1+Overlap]);
	} else{
		translate([-Servo_Body_l/2,-Servo_w/2,-Servo_h1])cube([Servo_Body_l,Servo_w,Servo_h1+Overlap]);
	}
	
	// top
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2,0])cube([Servo_x,Servo_w,Servo_Deck_h+Overlap]);
		translate([-Servo_Body_l/2,-Servo_w/2,Servo_Deck_h])cube([Servo_Body_l,Servo_w,Servo_TopStep_h+Overlap]);
		// gussets
		hull(){
			translate([-Servo_x/2,-0.8,Servo_Deck_h])cube([Servo_x,1.6,0.01]);
			translate([-Servo_Body_l/2,-0.8,Servo_Deck_h+2.4])cube([Servo_Body_l,1.6,0.01]);
		} // hull
	} else
	if (TopAccess==true){
		translate([-Servo_x/2,-Servo_w/2,0])cube([Servo_x,Servo_w,19]);
	} else {
	translate([-Servo_x/2,-Servo_w/2,0])cube([Servo_x,Servo_w,14]);
	}
	
	// Bolt holes
	translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
		
	if (BottomMount==true){
		translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
		translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
		translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
		translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
	} else{
		translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
	}
	
	if (BottomMount==true){
		// servo wheel
		translate([Servo_Shaft_Offset,0,Servo_Deck_h+Servo_TopStep_h-Overlap])
			cylinder(d=21.3,h=Servo_TopOfWheel-Servo_Deck_h-Servo_TopStep_h+Overlap);
	} else {
		translate([Servo_Shaft_Offset,0,0]) cylinder(d=21.3,h=19.6);
	}
	translate([Servo_Shaft_Offset,0,0]) cylinder(d=9,h=30);
	translate([Servo_Shaft_Offset,14.5/2,19.6+6]) Bolt4HeadHole();
	translate([Servo_Shaft_Offset,-14.5/2,19.6+6]) Bolt4HeadHole();
	}
} // Servo_LD20MG

//Servo_LD20MG(BottomMount=false,TopAccess=false);


module Servo_HX5010(BottomMount=true,TopAccess=true,Xtra_w=0.2, Xtra_h=1){
	Servo_Shaft_Offset=9.4; // this moves double
	Servo_BoltSpace=10;
	Servo_BoltSpace2=49.4;
	Servo_x=54.75;
	Servo_h1=27.7; // bottom of servo to bottom of mount
	Servo_w=20.2;
	Servo_Body_l=41.0;
	Servo_Deck_h=2.6;
	Servo_TopStep_h=10.2;
	Servo_TopOfWheel=18.5;
	
	translate([-Servo_Shaft_Offset,0,0]){
	// body
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,-Servo_h1-Xtra_h]) cube([Servo_x,Servo_w+Xtra_w,Servo_h1+Xtra_h+Overlap]);
	} else{
		translate([-Servo_Body_l/2,-Servo_w/2-Xtra_w/2,-Servo_h1-Xtra_h]) cube([Servo_Body_l,Servo_w+Xtra_w,Servo_h1+Xtra_h+Overlap]);
	}
	
	// top
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,0]) cube([Servo_x,Servo_w+Xtra_w,Servo_Deck_h+Overlap]);
		translate([-Servo_Body_l/2,-Servo_w/2-Xtra_w/2,Servo_Deck_h]) cube([Servo_Body_l,Servo_w+Xtra_w,Servo_TopStep_h+Overlap]);
		// gussets
		hull(){
			translate([-Servo_x/2,-0.8,Servo_Deck_h])cube([Servo_x,1.6,0.01]);
			translate([-Servo_Body_l/2,-0.8,Servo_Deck_h+2.4])cube([Servo_Body_l,1.6,0.01]);
		} // hull
	} else
	if (TopAccess==true){
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,0]) cube([Servo_x,Servo_w+Xtra_w,19]);
	} else {
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,0]) cube([Servo_x,Servo_w+Xtra_w,14]);
	}
	
	// Bolt holes
	translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
		
	if (BottomMount==true){
		translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
		translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
		translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
		translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0])Bolt4Hole();
	} else{
		translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
	}
	
	if (BottomMount==true){
		// servo wheel
		translate([Servo_Shaft_Offset,0,Servo_Deck_h+Servo_TopStep_h-Overlap])
			cylinder(d=21.3,h=Servo_TopOfWheel-Servo_Deck_h-Servo_TopStep_h+Overlap);
	} else {
		translate([Servo_Shaft_Offset,0,0]) cylinder(d=21.3,h=19.6);
	}
	translate([Servo_Shaft_Offset,0,0]) cylinder(d=9,h=30);
	translate([Servo_Shaft_Offset,14.5/2,19.6+6]) Bolt4HeadHole();
	translate([Servo_Shaft_Offset,-14.5/2,19.6+6]) Bolt4HeadHole();
	}
} // Servo_HX5010

//Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);


module LD20MGServoWheel(){
	kHornThickness=2.1;
	kHub_d=13;
	
	cylinder(d=7.8,h=kHornThickness+1.2);
	cylinder(d=5.8,h=kHornThickness+10);
	
	hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([0,16.05,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
		
	hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([0,-16.05,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([-15.05,0,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([15.05,0,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
} // LD20MGServoWheel

//LD20MGServoWheel();


