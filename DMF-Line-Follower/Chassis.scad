// ****************************************
// A simple hanging chassis for a robot
// Filename: Chassis.scad
// by Dave Flynn
// Created: 7/26/2019
// Revision: 0.9.0 7/26/2019
// ****************************************
//  ***** History ******
// 0.9.0 7/26/2019 First code
// ****************************************
//  ***** for STL output *****
//
// ****************************************
//  ***** for Viewing *****
//
// ****************************************
//  ***** Routines *****
//
// ****************************************

include<Wheel.scad>

kMotor5202_d=38;
kMotor_a=38;
kChassis_W=130;

module MotorFace5202(Panel_h=6){
	translate([0,0,-Overlap]) cylinder(d=12.5,h=Panel_h+Overlap*2);
	translate([8,8,Panel_h]) Bolt6ButtonHeadHole();
	translate([-8,8,Panel_h]) Bolt6ButtonHeadHole();
	translate([8,-8,Panel_h]) Bolt6ButtonHeadHole();
	translate([-8,-8,Panel_h]) Bolt6ButtonHeadHole();
} // MotorFace5202

//MotorFace5202(Panel_h=6);

module ChassisSide(Width=120,Length=90){
	Plate_t=5;
	nBBolts=4;
	MotorPlate_t=kBoltInset*2;
	kBaseMin=44;
	kShaftFlange_t=10;
	
	difference(){
		union(){
			translate([-Width/2,0,0]) rotate([0,90,0]) cylinder(d=Bearing_ID+kBoltInset*4,h=kShaftFlange_t);
			
			// motor flange
			rotate([-kMotor_a,0,0]) translate([-Width/2,GearSpacing(),0]) rotate([0,90,0]) cylinder(d=32,h=MotorPlate_t);
			
			// left plate
			hull(){
				translate([-Width/2,0,0]) rotate([0,90,0]) cylinder(d=Bearing_ID,h=Plate_t);
				
				translate([-Width/2,Length/2-Plate_t,-kBaseMin]) cube([Plate_t,Plate_t,Plate_t]);
				translate([-Width/2,-Length/2,-kBaseMin]) cube([Plate_t,Plate_t,Plate_t]);
			} // hull
			
			// bottom plate bolts
			for (j=[0:nBBolts-1])
				translate([-Width/2+kBoltInset,-Length/2+kBoltInset+(Length-kBoltInset*2)/(nBBolts-1)*j,-kBaseMin]){
					cylinder(r=kBoltInset,h=6,$fn=36);
					translate([0,0,6]) sphere(r=kBoltInset,$fn=36);
			}
			
		} // union
		
		rotate([-kMotor_a,0,0]) translate([-Width/2+MotorPlate_t,GearSpacing(),0]) rotate([180,90,0])
			MotorFace5202(Panel_h=MotorPlate_t);
		
		translate([-Width/2-Overlap,0,0]) rotate([0,90,0]) cylinder(d=Bearing_ID+IDXtra,h=kShaftFlange_t+Overlap*2);
		
		for (j=[0:nBBolts-1])
			translate([-Width/2+kBoltInset,-Length/2+kBoltInset+(Length-kBoltInset*2)/(nBBolts-1)*j,-kBaseMin])
				rotate([180,0,0]) Bolt4Hole(depth=7);
			
	} // diff

	// motor
	translate([-Width/2+MotorPlate_t,0,0]) rotate([-kMotor_a,0,0])
		translate([0,GearSpacing(),0]) rotate([0,90,0]) color("Red") cylinder(d=kMotor5202_d,h=109);
	
} // ChassisSide

ChassisSide(Width=kChassis_W);
rotate([0,0,180]) ChassisSide(Width=kChassis_W);

translate([-kChassis_W/2-29,0,0]) rotate([0,90,0]) rotate([0,0,90-kMotor_a]) ShowWheel();
rotate([0,0,180]) translate([-kChassis_W/2-29,0,0]) rotate([0,90,0]) rotate([0,0,90-kMotor_a]) ShowWheel();

























