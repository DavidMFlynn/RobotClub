// ****************************************
// A simple wheel for a robot
// by Dave Flynn
// Created: 7/26/2019
// Revision: 0.9.0 7/26/2019
// ****************************************
//  ***** History ******
// 0.9.0 7/26/2019 First code
// ****************************************
//  ***** for STL output *****
// Wheel(OD=120,Tire_w=15);
// WheelGear();
// MotorGear();
// BearingSpacer();
// ****************************************
//  ***** for Viewing *****
 ShowWheel();
// ****************************************
//  ***** Routines *****
// GearSpacing()
// ****************************************

include<CommonStuffSAEmm.scad>
include<involute_gears.scad>

$fn=90;
Overlap=0.05;
IDXtra=0.2;

	Wall_t=1.2;
	Bearing_OD=1.125*25.4;
	Bearing_ID=12.7;
	Bearing_h=5/16*25.4;
	kMotorShaft_d=6;
	Hub_h=Bearing_h*3+Wall_t*2;
	kBoltInset=4;
	nBolts=5;
	GearPitch=300;
	wGearTeeth=36;
	mGearTeeth=12;

module ShowWheel(){
	color("Tan") Wheel(OD=120,Tire_w=15);
	translate([0,0,Bearing_h*3+Wall_t*3]) rotate([180,0,180]) color("LightBlue") WheelGear();
	translate([GearSpacing(),0,Bearing_h*3-Wall_t]) 
		rotate([0,0,180/mGearTeeth]) MotorGear();
	translate([0,0,Wall_t*2+Bearing_h]) color("Green") BearingSpacer();
} // ShowWheel

//ShowWheel();

module BearingSpacer(){
	difference(){
		cylinder(d=(Bearing_OD+Bearing_ID)/2,h=Bearing_h);
		
		translate([0,0,-Overlap]) cylinder(d=Bearing_ID+IDXtra,h=Bearing_h+Overlap*2);
		translate([0,0,Bearing_h/2]) rotate([90,0,0]) Bolt6Hole();
	} // diff
} // BearingSpacer

//translate([0,0,Wall_t*2+Bearing_h]) BearingSpacer();

module Wheel(OD=120,Tire_w=20){
	
	module Hub(){
		difference(){
			union(){
				for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
					hull(){
						translate([Bearing_OD/2+Wall_t+kBoltInset,0,Hub_h-5-10]) cylinder(r=kBoltInset,h=10,$fn=36);
						translate([Bearing_OD/2+Wall_t+kBoltInset,0,Hub_h-5-10]) sphere(r=kBoltInset,$fn=36);
						translate([0,0,Hub_h-5-10]) cylinder(r=kBoltInset,h=10,$fn=36);
						translate([0,0,Hub_h-5-10]) sphere(r=kBoltInset,$fn=36);
						
					} // hull
				
			  cylinder(d=Bearing_OD+Wall_t*2,h=Hub_h);
			} // union
			
			translate([0,0,Wall_t]) cylinder(d=Bearing_OD-Wall_t*2, h=Bearing_h*3+Wall_t*2);
			translate([0,0,Wall_t*2]) cylinder(d=Bearing_OD, h=Bearing_h*3+Wall_t*2);
			
			 for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([Bearing_OD/2+Wall_t+kBoltInset,0,Hub_h-5])
				Bolt4Hole();
		} // diff
	} // Hub
	
	module Rim(OD=OD,Tire_w=Tire_w){
		difference(){
			cylinder(d=OD,h=Tire_w,$fn=OD*4);
			
			translate([0,0,-Overlap]) cylinder(d=OD-Wall_t*2,h=Tire_w+Overlap*2);
		} // diff
	} // Rim
	
	sRing1_r=OD/2-Wall_t;
	sRing4_r=Bearing_OD/2+Wall_t;
	sRing2_r=sRing1_r-(sRing1_r-sRing4_r)/3;
	sRing3_r=sRing2_r-(sRing1_r-sRing4_r)/3;
	
	module Spoke(D1=sRing1_r,D2=sRing2_r,a=360/20){
		hull(){
			translate([D1,0,0]){
				cylinder(d1=Wall_t,d2=Wall_t*2,h=Tire_w/2+Overlap,$fn=18);
				translate([0,0,Tire_w/2]) cylinder(d2=Wall_t,d1=Wall_t*2,h=Tire_w/2+Overlap,$fn=18);
			}
			rotate([0,0,a]) translate([D2,0,0]){
				cylinder(d1=Wall_t,d2=Wall_t*2,h=Tire_w/2+Overlap,$fn=18);
				translate([0,0,Tire_w/2]) cylinder(d2=Wall_t,d1=Wall_t*2,h=Tire_w/2+Overlap,$fn=18);
			}
		} // hull
		
	} // Spoke
	
	Hub();
	Rim();
	for (j=[0:9]) rotate([0,0,360/10*j]){
		rotate([0,0,360/20]) Spoke(D1=sRing2_r,D2=sRing1_r,a=360/40);
		rotate([0,0,360/20]) Spoke(D1=sRing2_r,D2=sRing1_r,a=-360/40);}
		
	for (j=[0:4]) rotate([0,0,360/5*j]){
			
				difference(){
					Spoke(D1=sRing3_r,D2=sRing4_r,a=0);
			
					translate([Bearing_OD/2+Wall_t+kBoltInset,0,Hub_h-5]) Bolt4Hole();
				} // diff
				
			Spoke(D1=sRing3_r,D2=sRing2_r,a=360/20);
			Spoke(D1=sRing3_r,D2=sRing2_r,a=-360/20);}
			
	
	
} // Wheel

//Wheel(OD=120,Tire_w=15);

//translate([0,0,Bearing_h*3+Wall_t*3]) rotate([180,0,180]) WheelGear();

function GearSpacing() = GearPitch*wGearTeeth/360+GearPitch*mGearTeeth/360;


module MotorGear(){
	difference(){
		
	gear (	number_of_teeth=mGearTeeth,
		circular_pitch=GearPitch, diametral_pitch=false,
		pressure_angle=20,
		clearance = 0.2,
		gear_thickness=5,
		rim_thickness=5,
		rim_width=3,
		hub_thickness=12,
		hub_diameter=12,
		bore_diameter=kMotorShaft_d+IDXtra,
		circles=0,
		backlash=0,
		twist=0,
		involute_facets=0,
		flat=false);
			
		translate([0,0,9]) rotate([90,0,0]) Bolt6Hole();
		} // diff
} // MotorGear

//translate([GearSpacing(),0,Bearing_h*3-Wall_t]) 
	//rotate([0,0,180/mGearTeeth]) MotorGear();

module WheelGear(){
	
	
	difference(){
		union(){
	gear (	number_of_teeth=wGearTeeth,
		circular_pitch=GearPitch, diametral_pitch=false,
		pressure_angle=20,
		clearance = 0.2,
		gear_thickness=5+Wall_t,
		rim_thickness=5,
		rim_width=3,
		hub_thickness=5,
		hub_diameter=Bearing_OD+Wall_t*4,
		bore_diameter=Bearing_OD+Wall_t*2+IDXtra,
		circles=nBolts,
		backlash=0,
		twist=0,
		involute_facets=0,
		flat=false);
	
	
		cylinder(d=Bearing_OD+Wall_t*4,h=Wall_t);
		}
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) translate([Bearing_OD/2+Wall_t+kBoltInset,0,0])
			rotate([180,0,0]) Bolt4ButtonHeadHole();
			
		
		translate([0,0,-Overlap]) cylinder(d=Bearing_OD-Wall_t*2,h=Wall_t+Overlap*2);
	} // diff
} // WheelGear
































