// ************************************************************
// Track Wheels for Lynx Motion Track
// Filename: LynxTrackLib.scad
// by: David M. Flynn
// Created: 9/11/2019
// Revision: 0.9.3 11/10/2019
// Units: mm
// ************************************************************
//  ***** History *****
echo("LynxTrackLib 0.9.3")
// 0.9.3 11/10/2019 Widened tooth by 0.25mm.
// 0.9.2 10/5/2019 Added kTrackBackSpace
// 0.9.1 9/14/2019 Little improvements
// 0.9.0 9/12/2019 It begins to be useful.
//
// ************************************************************
//  ***** Routines *****
//
// function TrackSurficeRad(nTeeth=15) // subtract about 0.5mm to 2mm
//
// ToothBoltHoleLocation() children(); // relitive to the tooth working surface
// SprocketTooth(); // one tooth 0,0,0 is the center of thack link surface
// ToothCenters(nTeeth=15) children(); // 
// Teeth(nTeeth=15);
// ToothHoldingDisk(nTeeth=15,Thickness=8); // from tooth center, 2 Req.
//
// TSM_Transporter_TrackSupport();
//
// ************************************************************
include<CommonStuffSAEmm.scad>

$fn=$preview? 24:90;
Overlap=0.05;
IDXtra=0.2;

TrackLink_Len=27.2;  // this may be a little off
TrackLinkPadOffset=4.5;
kTrackBackSpace=8.46667; //lateral space tooth to tooth on drive side of track

module ToothBoltHoleLocation(){
	translate([0,0,-11.5]) rotate([-90,0,0]) children();
} // ToothBoltHoleLocation

module SprocketTooth(){
	Len=20.68+0.25;
	Len2=19.00+0.25;
	Width=11.87;
	Height=5.10;
	ToothOffset=0.625;
	
	module Tooth(){
		T_w=4.6;
		TL1=5.0;
		TL2=8.75;
		T_h=7.0;
		
		hull(){
			translate([-TL1/2,-T_w/2,T_h-Overlap]) cube([TL1,T_w,Overlap]);
			translate([-TL2/2,-T_w/2,-Overlap]) cube([TL2,T_w,Overlap]);
		} // hull
	} // Tooth
	
	translate([-5,ToothOffset,0]) Tooth();
	translate([5,-ToothOffset,0]) Tooth();
	
	hull(){
		translate([-Len/2,-Width/2,-Overlap]) cube([Len,Width,Overlap]);
		translate([-Len2/2,-Width/2,-Height]) cube([Len2,Width,Overlap]);
	} // hull
	
	hull(){
		translate([0,-3,-11.5]) rotate([-90,0,0]) cylinder(d=8,h=6);
		translate([-12.5/2,-3,-Height]) cube([12.5,6,Overlap]);
	} // hull
	
	
} // SprocketTooth

// SprocketTooth();

function TrackSurficeRad(nTeeth=15)=TrackLink_Len/2/sin(180/nTeeth)-TrackLinkPadOffset;

module ToothCenters(nTeeth=15){
	Tangent_r=TrackLink_Len/2/sin(180/nTeeth); // hinge pin radius
	
	//echo(Tangent_r=Tangent_r);
	
	for (j=[0:nTeeth-1]) rotate([0,360/nTeeth*j,0]) translate([0,0,Tangent_r]) // hunge pin location
		rotate([0,180/nTeeth,0]) translate([TrackLink_Len/2,0,-TrackLinkPadOffset]) // surface of track pad
			children();
		
	
} // ToothCenters

module Teeth(nTeeth=15){
	ToothCenters(nTeeth=nTeeth)
			difference(){
				SprocketTooth();
				translate([0,6,0]) ToothBoltHoleLocation() Bolt4Hole();
			}
		
	
} // Teeth

//Teeth(nTeeth=15);

module ToothHoldingDisk(nTeeth=15,Thickness=8,ShowTeeth=true){
	difference(){
		rotate([-90,-90,0]) cylinder(r=TrackSurficeRad(nTeeth=nTeeth)-0.5,h=Thickness,$fn=nTeeth);
		
		ToothCenters(nTeeth=nTeeth)
			{
				SprocketTooth();
				translate([0,Thickness,0]) ToothBoltHoleLocation() children();
			}
	} // diff
	
	if (ShowTeeth==true)
	color("Red") Teeth(nTeeth=nTeeth);
} // ToothHoldingDisk

//ToothHoldingDisk(nTeeth=15,Thickness=8);

module TSM_Transporter_TrackSupport(){
	// TSM = Terran Space Marines
	
	DriveWheel_Spacing=136;
	
	translate([DriveWheel_Spacing/2,0,0]) ToothHoldingDisk(nTeeth=15,Thickness=8)Bolt4Hole();
	translate([-DriveWheel_Spacing/2,0,0]) ToothHoldingDisk(nTeeth=15,Thickness=8)Bolt4Hole();
	translate([DriveWheel_Spacing/2+100,0,60]) ToothHoldingDisk(nTeeth=9,Thickness=8)Bolt4Hole();
	translate([-DriveWheel_Spacing/2-100,0,60]) ToothHoldingDisk(nTeeth=9,Thickness=8)Bolt4Hole();
} // TSM_Transporter_TrackSupport

//TSM_Transporter_TrackSupport();










