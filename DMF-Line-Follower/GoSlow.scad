// ************************************************************
// Compound planetary for rover wheel.
// Ring Gear A connects to the chassis.
// Ring Gear B connects to the wheeel.
// No sun gear, motor drives the planet carrier.
//
// Filename: GoSlow.scad
// Created: 8/9/2019
// Revision: 1.0a1 8/9/2019
// Units: mm
// *************************************************************
//  ***** Hostory *****
// 1.0a1 8/9/2019 First code.
// *************************************************************



//include<CommonStuffSAEmm.scad>
include<CompoundHelicalPlanetary.scad>

$fn=90;
Overlap=0.05;
IDXtra=0.2;

GearWidth=5;
PlanetaryPitchA=300;
PlanetaryPitchB=285;
PC_GearTeeth=40;
PC_PinionTeeth=20;
SunGear_t=12;
PlanetA_t=13;
PlanetB_t=13;
nPlanets=3;
kSpline_d=12;
RingATeeth=43;
RingBTeeth=44;
Pressure_a=20;

//Ratio=RingBTeeth/(RingBTeeth-RingATeeth)*(PC_GearTeeth/PC_PinionTeeth);
//echo(Ratio=Ratio);



translate([0,0,GearWidth+Overlap]) CompoundRingGearHelix(Pitch=PlanetaryPitchA, nTeeth=RingATeeth, Thickness=GearWidth, twist=twist, HB=false, RimWidth=3.5);
CompoundRingGearHelix(Pitch=PlanetaryPitchB, nTeeth=RingBTeeth, Thickness=GearWidth, twist=twist, HB=false, RimWidth=3.5);

translate([-RingATeeth*PlanetaryPitchA/360+PlanetA_t*PlanetaryPitchA/360,0,0])  myPlanetB();

rotate([0,0,120]) translate([-RingATeeth*PlanetaryPitchA/360+PlanetA_t*PlanetaryPitchA/360,0,0])  rotate([0,0,-120])
	rotate([0,0,(360/PlanetB_t)*(RingBTeeth/3)]) myPlanetB();

rotate([0,0,-120]) translate([-RingATeeth*PlanetaryPitchA/360+PlanetA_t*PlanetaryPitchA/360,0,0])  rotate([0,0,120])
	rotate([0,0,-(360/PlanetB_t)*(RingBTeeth/3)]) myPlanetB();
	
//rotate([0,0,180/PlanetB_t])
//gap=(RingBTeeth*PlanetaryPitchB/360-PlanetB_t*PlanetaryPitchB/360)-(RingATeeth*PlanetaryPitchA/360-PlanetA_t*PlanetaryPitchA/360);

//echo(gap=gap);

translate([-RingATeeth*PlanetaryPitchA/360+PlanetA_t*PlanetaryPitchA/360,0,GearWidth+Overlap]) rotate([0,0,180/PlanetA_t]) myPlanetA();

rotate([0,0,120]) translate([-RingATeeth*PlanetaryPitchA/360+PlanetA_t*PlanetaryPitchA/360,0,GearWidth+Overlap]) rotate([0,0,-120]) 
 rotate([0,0,180/PlanetA_t]) myPlanetA();
  
rotate([0,0,-120]) translate([-RingATeeth*PlanetaryPitchA/360+PlanetA_t*PlanetaryPitchA/360,0,GearWidth+Overlap]) rotate([0,0,120]) 
rotate([0,0,180/PlanetA_t]) myPlanetA();

translate([0,0,(GearWidth+Overlap)*2]) myPlanetCarrierGear();

translate([PC_PinionTeeth*PlanetaryPitchA/360+PC_GearTeeth*PlanetaryPitchA/360,0,(GearWidth+Overlap)*2+GearWidth])
rotate([0,0,180/PC_PinionTeeth]) rotate([180,0,0]) myPininGear();

module myPininGear(){
	gear (
	number_of_teeth=PC_PinionTeeth,
	circular_pitch=PlanetaryPitchA, diametral_pitch=false,
	pressure_angle=Pressure_a,
	clearance = 0.2,
	gear_thickness=GearWidth,
	rim_thickness=GearWidth,
	rim_width=3,
	hub_thickness=GearWidth+10,
	hub_diameter=12,
	bore_diameter=6,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false);
}
	

module myPlanetCarrierGear(){
	gear (
	number_of_teeth=PC_GearTeeth,
	circular_pitch=PlanetaryPitchA, diametral_pitch=false,
	pressure_angle=Pressure_a,
	clearance = 0.2,
	gear_thickness=GearWidth,
	rim_thickness=GearWidth,
	rim_width=3,
	hub_thickness=GearWidth,
	hub_diameter=0,
	bore_diameter=1.125*25.4,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false);
}
	


module myPlanetA(){
gear (
	number_of_teeth=PlanetA_t,
	circular_pitch=PlanetaryPitchA, diametral_pitch=false,
	pressure_angle=Pressure_a,
	clearance = 0.2,
	gear_thickness=GearWidth,
	rim_thickness=GearWidth,
	rim_width=3,
	hub_thickness=GearWidth,
	hub_diameter=14,
	bore_diameter=12.7,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false);
}
	
module myPlanetB(){
gear (
	number_of_teeth=PlanetB_t,
	circular_pitch=PlanetaryPitchB, diametral_pitch=false,
	pressure_angle=Pressure_a,
	clearance = 0.2,
	gear_thickness=GearWidth,
	rim_thickness=GearWidth,
	rim_width=3,
	hub_thickness=GearWidth,
	hub_diameter=14,
	bore_diameter=12.7,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false);
}
	
	
	
	
	
	
	
	