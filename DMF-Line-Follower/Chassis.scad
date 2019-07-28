// ****************************************
// A simple hanging chassis for a robot
// Filename: Chassis.scad
// by Dave Flynn
// Created: 7/26/2019
// Revision: 0.9.2 7/28/2019
// ****************************************
//  ***** History ******
// 0.9.2 7/28/2019 Skirts
// 0.9.1 7/27/2019 Split axil clamp
// 0.9.0 7/26/2019 First code
// ****************************************
//  ***** for STL output *****
// rotate([0,-90,0]) AxilClamp();
// rotate([0,-90,0]) ChassisSide();
// ChassisFloor();
// Skirt();
// ****************************************
//  ***** for Viewing *****
// ShowAll();
// rotate([0,0,180]) ShowAll();
// ****************************************
//  ***** Routines *****
//
// ****************************************

include<Wheel.scad>

kMotor5202_d=38;
kMotor5202_l=109;
kMotor5202Nose_d=32;
kMotor5202Nose_l=33;

kMotor_a=38;
kBaseMin=44; // Axil to floor distance
kFloor_t=3;
kChassis_W=130;
kChassis_L=90;
	kShaftFlange_t=kBoltInset*4;
	kShaftFlange_d=Bearing_ID+kBoltInset*4;
MotorPlate_t=kBoltInset*2;

module ShowAll(){
	translate([-kChassis_W/2,0,0]) AxilClamp();
	translate([-kChassis_W/2,0,0]) ChassisSide();
	translate([0,0,-kBaseMin-kFloor_t]) ChassisFloor();
	
	// motor
	translate([-kChassis_W/2+MotorPlate_t,0,0]) rotate([-kMotor_a,0,0])
		translate([0,GearSpacing(),0]) rotate([0,90,0]) color("Red") {
			translate([0,0,kMotor5202Nose_l]) cylinder(d=kMotor5202_d,h=kMotor5202_l-kMotor5202Nose_l);
			cylinder(d=kMotor5202Nose_d,h=kMotor5202Nose_l);
			mirror([0,0,1]) cylinder(d=6,h=24);
		}
		
	translate([-kChassis_W/2-29,0,0]) rotate([0,90,0]) rotate([0,0,90-kMotor_a]) ShowWheel();
		
		translate([0,-kChassis_L/2,-kBaseMin]) rotate([-60,0,0]) color("Silver") Skirt();

} // ShowAll

//ShowAll();
//rotate([0,0,180]) ShowAll();


module MotorFace5202(Panel_h=6){
	translate([0,0,-Overlap]) cylinder(d=12.5,h=Panel_h+Overlap*2);
	translate([8,8,Panel_h]) Bolt6ButtonHeadHole();
	translate([-8,8,Panel_h]) Bolt6ButtonHeadHole();
	translate([8,-8,Panel_h]) Bolt6ButtonHeadHole();
	translate([-8,-8,Panel_h]) Bolt6ButtonHeadHole();
} // MotorFace5202

//MotorFace5202(Panel_h=6);

module AxilClamp(){
	difference(){
		rotate([0,90,0]) cylinder(d=kShaftFlange_d,h=kShaftFlange_t);
		
		// Axil
		translate([-Overlap,0,0]) rotate([0,90,0]) cylinder(d=Bearing_ID,h=kShaftFlange_t+Overlap*2);
		
		// Cut away bottom of flange
		translate([-Overlap,-kShaftFlange_d/2-Overlap,IDXtra]) mirror([0,0,1]) cube([kShaftFlange_t+Overlap*2,kShaftFlange_d+Overlap*2,kShaftFlange_d]);
		// Flange bolts
		translate([kShaftFlange_t/2-kBoltInset,-kShaftFlange_d/2+kBoltInset+1,8]) Bolt4HeadHole(depth=8);
		translate([kShaftFlange_t/2+kBoltInset,-kShaftFlange_d/2+kBoltInset+1,8]) Bolt4HeadHole(depth=8);
		translate([kShaftFlange_t/2-kBoltInset,kShaftFlange_d/2-kBoltInset-1,8]) Bolt4HeadHole(depth=8);
		translate([kShaftFlange_t/2+kBoltInset,kShaftFlange_d/2-kBoltInset-1,8]) Bolt4HeadHole(depth=8);
	} // diff
	
} // AxilClamp

//translate([-kChassis_W/2,0,0]) AxilClamp();
nBBolts=4;

module ChassisFloor(Width=kChassis_W,Length=kChassis_L){
	
	CenterZone_W=Width-kBoltInset*4;
	CenterZone_L=Length-kBoltInset*4;
	LH_d=10;
	nWLH=CenterZone_W/(LH_d+5);
	nLLH=CenterZone_L/(LH_d+5);
	
	difference(){
		union(){
			translate([-Width/2,-Length/2,0]) cube([Width,Length,kFloor_t]);
			
			// front & back
			//translate([-Width/2,-Length/2, kMotor5202_d/2+kFloor_t]) rotate([0,90,0])
				//cylinder(r=kMotor5202_d/2+kFloor_t, h=Width);
		} // union
		
		// Side mounting bolts
		for (j=[0:nBBolts-1]){
			translate([-Width/2+kBoltInset,-Length/2+kBoltInset+(Length-kBoltInset*2)/(nBBolts-1)*j,kFloor_t])
				Bolt4ClearHole();
			translate([Width/2-kBoltInset,-Length/2+kBoltInset+(Length-kBoltInset*2)/(nBBolts-1)*j,kFloor_t])
				Bolt4ClearHole();
		}
		
		// Lightening holes
		for (k=[0:nLLH-1])
			for (j=[0:nWLH-1])
				translate([-CenterZone_W/2+CenterZone_W/nWLH*j+CenterZone_W/nWLH-LH_d/2,
					-CenterZone_L/2+CenterZone_L/nLLH*k+CenterZone_L/nLLH,-Overlap])
					cylinder(d=LH_d,h=kFloor_t+Overlap*2);
			
		translate([0,0,kBaseMin+kFloor_t]) rotate([-kMotor_a,0,0]) 
		translate([-Width/2+kBoltInset*2,GearSpacing(),0]) rotate([0,90,0]) cylinder(d=kMotor5202_d+1,h=CenterZone_W);
			
		translate([0,0,kBaseMin+kFloor_t]) rotate([180+kMotor_a,0,0]) 
		translate([-Width/2+kBoltInset*2,GearSpacing(),0]) rotate([0,90,0]) cylinder(d=kMotor5202_d+1,h=CenterZone_W);

			
	} // diff
} // ChassisFloor

//ChassisFloor();

kSkirtLen=30;

module ChassisSide(Length=kChassis_L){
	Plate_t=5;
	
	
	module BoltCylinder(){
		cylinder(r=kBoltInset,h=6,$fn=36);
		translate([0,0,6]) sphere(r=kBoltInset,$fn=36);
	} // BoltCylinder
	
	module BoltCylinderHole(){
		rotate([180,0,0]) Bolt4Hole(depth=7);
	} // BoltCylinderHole
	
	difference(){
		union(){
			rotate([0,90,0]) cylinder(d=kShaftFlange_d,h=kShaftFlange_t);
			
			// motor flange
			rotate([-kMotor_a,0,0]) translate([0,GearSpacing(),0]) rotate([0,90,0]) cylinder(d=kMotor5202Nose_d,h=MotorPlate_t);
			
			// Motor flange to axil gusset
			//hull(){
			//	rotate([-kMotor_a,0,0]) translate([0,kShaftFlange_d/2-4,0]) rotate([0,90,0]) cylinder(d=8,h=kShaftFlange_t);
			//	rotate([-kMotor_a,0,0]) translate([0,GearSpacing()-kMotor5202Nose_d/2+1,0]) rotate([0,90,0]) cylinder(d=8,h=MotorPlate_t);
			//}
			
			// left plate
			hull(){
				translate([0,0,0]) rotate([0,90,0]) cylinder(d=Bearing_ID,h=Plate_t);
				
				translate([0,Length/2-Plate_t,-kBaseMin]) cube([Plate_t,Plate_t,Plate_t]);
				translate([0,-Length/2,-kBaseMin]) cube([Plate_t,Plate_t,Plate_t]);
			} // hull
			
			// bottom plate bolts
			for (j=[0:nBBolts-1])
				translate([kBoltInset,-Length/2+kBoltInset+(Length-kBoltInset*2)/(nBBolts-1)*j,-kBaseMin])
					BoltCylinder();
			
			// Rear skirt (-Y)
			hull(){
				translate([0,-Length/2,-kBaseMin]) cube([Plate_t,Plate_t,Plate_t]);
				
				translate([0,-Length/2,-kBaseMin]) rotate([30,0,0]) translate([0,0,kSkirtLen-Plate_t]) cube([Plate_t,Plate_t,Plate_t]);
				
				translate([0,-Length/4,-kBaseMin/2]) rotate([0,90,0]) cylinder(d=Plate_t,h=Plate_t);
			} // hull
			
			translate([kBoltInset,-Length/2,-kBaseMin]) rotate([30,0,0]) translate([0,0,kBoltInset])
				rotate([-90,0,0]) BoltCylinder();
			
			translate([kBoltInset,-Length/2,-kBaseMin]) rotate([30,0,0]) translate([0,0,kSkirtLen-kBoltInset])
				rotate([-90,0,0]) BoltCylinder();
			
			// Front skirt (+Y)
			hull(){
				translate([0,Length/2-Plate_t,-kBaseMin]) cube([Plate_t,Plate_t,Plate_t]);
				
				translate([0,Length/2,-kBaseMin]) rotate([-30,0,0]) translate([0,-Plate_t,kSkirtLen-Plate_t]) 
					cube([Plate_t,Plate_t,Plate_t]);
				
				translate([0,Length/4,-kBaseMin/2]) rotate([0,90,0]) cylinder(d=Plate_t,h=Plate_t);
			} // hull
			
			translate([kBoltInset,Length/2,-kBaseMin]) rotate([-30,0,0]) translate([0,0,kBoltInset])
				rotate([90,0,0]) BoltCylinder();
			
			translate([kBoltInset,Length/2,-kBaseMin]) rotate([-30,0,0]) translate([0,0,kSkirtLen-kBoltInset])
				rotate([90,0,0]) BoltCylinder();
		} // union
		
		rotate([-kMotor_a,0,0]) translate([MotorPlate_t,GearSpacing(),0]) rotate([180,90,0])
			MotorFace5202(Panel_h=MotorPlate_t);
		
		// Axil
		translate([-Overlap,0,0]) rotate([0,90,0]) cylinder(d=Bearing_ID,h=kShaftFlange_t+Overlap*2);
		
		for (j=[0:nBBolts-1])
			translate([kBoltInset,-Length/2+kBoltInset+(Length-kBoltInset*2)/(nBBolts-1)*j,-kBaseMin])
				BoltCylinderHole();
		
		// Rear Skirt bolts
		translate([kBoltInset,-Length/2,-kBaseMin]) rotate([30,0,0]) translate([0,0,kBoltInset])
				rotate([-90,0,0]) BoltCylinderHole();
		translate([kBoltInset,-Length/2,-kBaseMin]) rotate([30,0,0]) translate([0,0,kSkirtLen-kBoltInset])
				rotate([-90,0,0]) BoltCylinderHole();
		
		// Front Skirt Bolts
		translate([kBoltInset,Length/2,-kBaseMin]) rotate([-30,0,0]) translate([0,0,kBoltInset])
				rotate([90,0,0]) BoltCylinderHole();
			
			translate([kBoltInset,Length/2,-kBaseMin]) rotate([-30,0,0]) translate([0,0,kSkirtLen-kBoltInset])
				rotate([90,0,0]) BoltCylinderHole();
		
		// Cut away top of flange
		translate([-Overlap,-kShaftFlange_d/2-Overlap,-IDXtra]) cube([kShaftFlange_t+Overlap*2,kShaftFlange_d+Overlap*2,kShaftFlange_d]);
		// Flange bolts
		translate([kShaftFlange_t/2-kBoltInset,-kShaftFlange_d/2+kBoltInset+1,0]) Bolt4Hole(depth=9);
		translate([kShaftFlange_t/2+kBoltInset,-kShaftFlange_d/2+kBoltInset+1,0]) Bolt4Hole(depth=9);
		translate([kShaftFlange_t/2-kBoltInset,kShaftFlange_d/2-kBoltInset-1,0]) Bolt4Hole(depth=9);
		translate([kShaftFlange_t/2+kBoltInset,kShaftFlange_d/2-kBoltInset-1,0]) Bolt4Hole(depth=9);
		
		// Lightening holes
		translate([-Overlap,0,-kBaseMin+11+4]) rotate([0,90,0]) cylinder(d=22,h=Plate_t+Overlap*2);
		translate([-Overlap,-25,-kBaseMin+7+4]) rotate([0,90,0]) cylinder(d=14,h=Plate_t+Overlap*2);
		translate([-Overlap,-Length/2+2,-kBaseMin+7+11]) rotate([0,90,0]) cylinder(d=14,h=Plate_t+Overlap*2);
	} // diff

	
} // ChassisSide

//translate([-kChassis_W/2,0,0]) ChassisSide();
//rotate([0,0,180]) ChassisSide(Width=kChassis_W);

//translate([-kChassis_W/2-29,0,0]) rotate([0,90,0]) rotate([0,0,90-kMotor_a]) ShowWheel();
//rotate([0,0,180]) translate([-kChassis_W/2-29,0,0]) rotate([0,90,0]) rotate([0,0,90-kMotor_a]) ShowWheel();


module Skirt(Width=kChassis_W){
	kFloor_t=3;
	
	difference(){
		union(){
			translate([-Width/2,-kSkirtLen,-kFloor_t]) cube([Width,kSkirtLen,kFloor_t]);
			
			// bottom lip
			hull(){
				translate([-Width/2,-Overlap,-kFloor_t]) cube([Width,Overlap,kFloor_t]);
				
				translate([-Width/2,-Overlap,0]) rotate([-90-30,0,0]) cube([Width,1.7,kFloor_t]);
				translate([-Width/2,-Overlap,-kFloor_t])  cube([Width,1.7,1.7]);
			} // hull
			
			// Alignment
			hull(){
				translate([-Width/2+kBoltInset*3,0,0]){
				translate([0,-kFloor_t/2,-Overlap]) cylinder(d=kFloor_t,h=kFloor_t); //cube([kFloor_t,kFloor_t,kFloor_t]);
				translate([-kFloor_t/2,0,Overlap]) rotate([60,0,0]) cube([kFloor_t,2.4,1]);}
				
				translate([Width/2-kBoltInset*3,0,0]){
				translate([0,-kFloor_t/2,-Overlap]) cylinder(d=kFloor_t,h=kFloor_t); //cube([kFloor_t,kFloor_t,kFloor_t]);
				translate([-kFloor_t/2,0,Overlap]) rotate([60,0,0]) cube([kFloor_t,2.4,1]);}
			} // hull
		} // union
		
		// Rear Skirt bolts
		translate([-Width/2+kBoltInset,-kSkirtLen+kBoltInset,0]) Bolt4ClearHole();
		translate([-Width/2+kBoltInset,-kBoltInset,0]) Bolt4ClearHole();
		translate([Width/2-kBoltInset,-kSkirtLen+kBoltInset,0]) Bolt4ClearHole();
		translate([Width/2-kBoltInset,-kBoltInset,0]) Bolt4ClearHole();
		
		// Lightening holes
		nLH=5;
		LH_d=18;
		kCenterLen=Width-kBoltInset*6;
		
		for (j=[0:nLH-1]) translate([-kCenterLen/2+LH_d/2+(kCenterLen-LH_d)/(nLH-1)*j,-kSkirtLen/2,-kFloor_t-Overlap])
			cylinder(d=LH_d,h=kFloor_t+Overlap*2);
		
		
	} // diff
} // Skirt

//translate([0,-kChassis_L/2,-kBaseMin]) rotate([-60,0,0]) Skirt();






















