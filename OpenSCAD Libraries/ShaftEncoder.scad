// ***************************************************************
// Shaft Angle Encoder Housing
// Filename: ShaftEncoder.scad
// by: David M. Flynn
// Created: 12/21/2018
// Revision: 1.2.0 2/23/2018
// units: mm
// ***************************************************************
// Notes:
//  Housing for Enc1 pcb.
//  Shaft must be 6mm and extend 8.5mm from the mounting surface.
//  For IntegratedBase() the shaft should extend 5mm beyond the surface.
// ***************************************************************
// History:
echo("ShaftEncoder 1.2.0");
// 1.2.0 2/23/2018 Added Programmer Case
// 1.1.1 2/13/2018 Made J1 and J2 parametric ond optional.
// 1.1.0 1/5/2018 Added IntegratedBase();, Enc1IntegratedShaftHole(Dia=6.35, Height=10);
// 1.0.0 12/21/2018 First Code
// ***************************************************************
//  ***** for STL output *****
// rotate([180,0,0]) Cover(Cut=false, HasSPIConn=true, HasABIUVWConn=false);
// MagnetHolder();
// Base();

// Programmer Case
// ProgCaseBot(Holes=true);
// mirror([1,0,0]) ProgCaseBot(HasJ2=true,Holes=true); // Case Top
// rotate([180,0,0]) ProgCaseMid();
// ***************************************************************
//  ***** Routines ******
// IntegratedBase(); // Used to add an encoder base to a robot joint cover plate.
// Enc1IntegratedShaftHole(Dia=6.35, Height=10);
// PCB_Holes() Bolt2Hole();
// PCB_Enc1();
// ***************************************************************
//  ***** for Viewing *****
// ViewAll();
// ***************************************************************

include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=90;

// PCB data
Enc1_PCB_x=0.8*25.4;
Enc1_PCB_y=0.7*25.4;
Enc1_PCB_CL_x=0.425*25.4;
Enc1_PCB_CL_y=0.325*25.4;
Enc1_PCB_Hole_y=0.25*25.4;

// Disc magnet
SE_Magnet_OD=6;
SE_Magnet_h=2.5;

// Cover dimensions
SE_Cover_OD=32;
SE_Cover_ID=29;
SE_Cover_h=18;
SE_MountingHole_BC=SE_Cover_ID-10;

	USBPCB_x=22;
	USBPCB_y=38.4;
	USBPCB_z=2.4;
	PCB_t=1.8;
	PCB_Xtra=0.4;
	USBPCB_H1_x=3;
	USBPCB_H1_y=3.75;
	USBPCB_H2_x=19.25;
	USBPCB_H2_y=25.45;
	USBPCB_CaseWall=1.5;
	CaseLip=1.8;
	PCB_Space=12.7;
	
module RoundRect(X=10,Y=10,Z=4,R=1){
		hull(){
			translate([-X/2+R,-Y/2+R,0]) cylinder(r=R,h=Z);
			translate([X/2-R,-Y/2+R,0]) cylinder(r=R,h=Z);
			translate([-X/2+R,Y/2-R,0]) cylinder(r=R,h=Z);
			translate([X/2-R,Y/2-R,0]) cylinder(r=R,h=Z);
		} // hull
	} // RoundRect
	
module ProgCaseBot(HasJ2=false,Holes=false){
	
	module J2Opening(){
			translate([-USBPCB_x/2+1.2-IDXtra, -USBPCB_y/2+5.0-IDXtra,-Overlap]) cube([18.5+IDXtra*2,5.3+IDXtra*2,10]);
			translate([-USBPCB_x/2+6.3-IDXtra, -USBPCB_y/2+3.1-IDXtra,-Overlap]) cube([8.4+IDXtra*2,6.5,10]);
	} // J2Opening
	
	module CaseScrewHoles(){
		translate([-USBPCB_x/2+USBPCB_H1_x, -USBPCB_y/2+USBPCB_H1_y,USBPCB_CaseWall+USBPCB_z]) Bolt2ClearHole();
		translate([-USBPCB_x/2+USBPCB_H2_x, -USBPCB_y/2+USBPCB_H2_y,USBPCB_CaseWall+USBPCB_z]) Bolt2ClearHole();
	} // CaseScrewHoles
	
	difference(){
		hull(){
			RoundRect(X=USBPCB_x+PCB_Xtra+USBPCB_CaseWall*2,Y=USBPCB_y+PCB_Xtra+USBPCB_CaseWall*2,Z=0.1,R=1);
			translate([0,0,USBPCB_CaseWall+USBPCB_z+PCB_t])
			RoundRect(X=USBPCB_x+PCB_Xtra+USBPCB_CaseWall*4,Y=USBPCB_y+PCB_Xtra+USBPCB_CaseWall*4,Z=CaseLip,R=1);
		} // hull
		
		// Lip
		translate([0,0,USBPCB_CaseWall+USBPCB_z+PCB_t])
			RoundRect(X=USBPCB_x+USBPCB_CaseWall*2+IDXtra,Y=USBPCB_y+USBPCB_CaseWall*2+IDXtra,Z=CaseLip+Overlap,R=1);
		
		// PCB parts
		translate([0,0,USBPCB_CaseWall]) RoundRect(X=USBPCB_x-2,Y=USBPCB_y-2,Z=USBPCB_z+Overlap,R=1);
		// PCB
		translate([0,0,USBPCB_CaseWall+USBPCB_z]) RoundRect(X=USBPCB_x+PCB_Xtra,Y=USBPCB_y+PCB_Xtra,Z=PCB_t+Overlap,R=0.25);
		
		if (HasJ2==false){
		// USB connector
		translate([-USBPCB_x/2+3.1,0,USBPCB_CaseWall+USBPCB_z+PCB_t]) cube([12.4,USBPCB_y,11.3]);}
		
		// Bolt holes
		if (Holes==true) CaseScrewHoles();
		
		if (HasJ2==true) J2Opening();
		
	} // diff
	
	if (Holes==true) 
	difference(){
		union(){
				translate([-USBPCB_x/2+USBPCB_H1_x, -USBPCB_y/2+USBPCB_H1_y,0]) cylinder(d=5,h=USBPCB_CaseWall+USBPCB_z);
				translate([-USBPCB_x/2+USBPCB_H2_x, -USBPCB_y/2+USBPCB_H2_y,0]) cylinder(d=5,h=USBPCB_CaseWall+USBPCB_z);
				
		} // union
		
		if (HasJ2==true) J2Opening();
		
		// Bolt holes
		CaseScrewHoles();
			
//		translate([-USBPCB_x/2+USBPCB_H1_x, -USBPCB_y/2+USBPCB_H1_y,USBPCB_CaseWall+USBPCB_z]) Bolt2ClearHole();
//		translate([-USBPCB_x/2+USBPCB_H2_x, -USBPCB_y/2+USBPCB_H2_y,USBPCB_CaseWall+USBPCB_z]) Bolt2ClearHole();
	} // diff
	
} // ProgCaseBot

//ProgCaseBot();
//translate([0,0,(USBPCB_CaseWall+USBPCB_z)*2+PCB_Space+Overlap*2]) mirror([0,0,1]) ProgCaseBot(HasJ2=true);

module ProgCaseMid(){
	
	
	difference(){
		RoundRect(X=USBPCB_x+USBPCB_CaseWall*2,Y=USBPCB_y+USBPCB_CaseWall*2,Z=PCB_Space,R=1);
		
		// Inside
		translate([0,0,-Overlap]) RoundRect(X=USBPCB_x,Y=USBPCB_y,Z=PCB_Space+Overlap*2,R=0.25);
		
		// USB Connector
		translate([-USBPCB_x/2+3.1,0,-Overlap]) cube([12.4,USBPCB_y,11.3]);
	} // diff
	
	translate([-0.1,-0.1,0])
	difference(){
		union(){
			hull(){
				translate([-USBPCB_x/2+USBPCB_H1_x, -USBPCB_y/2+USBPCB_H1_y,0]) cylinder(d=5,h=PCB_Space);
				translate([-USBPCB_x/2-1, -USBPCB_y/2+USBPCB_H1_y-2.5,0]) cube([0.01,5,PCB_Space]);
				//translate([-USBPCB_x/2+USBPCB_H1_x-1.8, -USBPCB_y/2+USBPCB_H1_y,0]) cylinder(d=5,h=PCB_Space);
			}
			hull(){
				translate([-USBPCB_x/2+USBPCB_H2_x, -USBPCB_y/2+USBPCB_H2_y,0]) cylinder(d=5,h=PCB_Space);
				translate([USBPCB_x/2+1, -USBPCB_y/2+USBPCB_H2_y-2.5,0]) cube([0.01,5,PCB_Space]);
				//translate([-USBPCB_x/2+USBPCB_H2_x+1.8, -USBPCB_y/2+USBPCB_H2_y,0]) cylinder(d=5,h=PCB_Space);
			}
		} // union
		
		
		translate([-USBPCB_x/2+USBPCB_H1_x, -USBPCB_y/2+USBPCB_H1_y,PCB_Space]) Bolt2Hole(depth=15);
		translate([-USBPCB_x/2+USBPCB_H2_x, -USBPCB_y/2+USBPCB_H2_y,PCB_Space]) Bolt2Hole(depth=15);
	} // diff
	
} // ProgCaseMid

//translate([0,0,USBPCB_z+PCB_t+USBPCB_CaseWall+Overlap]) ProgCaseMid();

module ViewAll(){
	MagnetHolder();
	translate([0,0,-SE_Cover_h+4.5-Overlap]) Base();
	Cover(Cut=true);
} // ViewAll

//ViewAll();

module PCB_Holes(){
	translate([0,Enc1_PCB_Hole_y,0]) children();
	translate([0,-Enc1_PCB_Hole_y,0]) children();
} // PCB_Holes

module PCB_Enc1(HasSPIConn=true, HasABIUVWConn=true){
	J1_CL_X=0.675*25.4; // from PCB 0,0
	J1_CL_Y=0.350*25.4;
	SPIConn_X=5.2+IDXtra;
	SPIConn_Y=17.8+IDXtra;
	
	J2_CL_X=0.125*25.4;
	J2_CL_Y=0.325*25.4;
	ABIUVWConn_X=7.5+IDXtra;
	ABIUVWConn_Y=12.7+IDXtra;
	
	// chip
	translate([-3,-3,0]) cube([6,6,1]);
	
	// J1
	if (HasSPIConn==true)
		translate([-Enc1_PCB_CL_x+J1_CL_X-SPIConn_X/2, -Enc1_PCB_CL_y+J1_CL_Y-SPIConn_Y/2, 1+1.6])
			cube([SPIConn_X, SPIConn_Y, 12]);
	
	// J2
	if (HasABIUVWConn==true)
		translate([-Enc1_PCB_CL_x+J2_CL_X-ABIUVWConn_X/2, -Enc1_PCB_CL_y+J2_CL_Y-ABIUVWConn_Y/2, 1+1.6]) 
			cube([ABIUVWConn_X, ABIUVWConn_Y, 12]);
	
	// PCB
	difference(){
		translate([-Enc1_PCB_CL_x, -Enc1_PCB_CL_y, 1]) cube([Enc1_PCB_x, Enc1_PCB_y, 1.6]);
		PCB_Holes() cylinder(d=2,h=3);
	} // diff
} // PCB_Enc1

//PCB_Enc1();

module PCB_Enc1RevA(HasSPIConn=true, HasABIUVWConn=true){
	J1_CL_X=0.675*25.4; // from PCB 0,0
	J1_CL_Y=0.350*25.4;
	SPIConn_X=5.2+IDXtra;
	SPIConn_Y=17.8+IDXtra;
	SPIConn_Y2=8+IDXtra;
	SPIConn_X2=6.5+IDXtra;
	SPIConn_Z=12;
	
	J2_CL_X=0.125*25.4;
	J2_CL_Y=0.325*25.4;
	ABIUVWConn_X=9.8+IDXtra;
	ABIUVWConn_Y=12.7+IDXtra;
	
	// chip
	translate([-3,-3,0]) cube([6,6,1]);
	
	// J1
	if (HasSPIConn==true){
		translate([-Enc1_PCB_CL_x+J1_CL_X-SPIConn_X/2, -Enc1_PCB_CL_y+J1_CL_Y-SPIConn_Y/2, 1+1.6])
			cube([SPIConn_X, SPIConn_Y, SPIConn_Z]);
		translate([-Enc1_PCB_CL_x+J1_CL_X-SPIConn_X/2-SPIConn_X2+SPIConn_X, -Enc1_PCB_CL_y+J1_CL_Y-SPIConn_Y2/2, 1+1.6+1])
			cube([SPIConn_X2, SPIConn_Y2, SPIConn_Z-1]);
	}
	
	// J2
	if (HasABIUVWConn==true)
		translate([-Enc1_PCB_CL_x+J2_CL_X-ABIUVWConn_X/2, -Enc1_PCB_CL_y+J2_CL_Y-ABIUVWConn_Y/2, 1+1.6]) 
			cube([ABIUVWConn_X, ABIUVWConn_Y, 12]);
	
	// PCB
	R=2.54;
	Z=1.7;
	difference(){
		translate([-Enc1_PCB_CL_x, -Enc1_PCB_CL_y, 1])
		
		hull(){
			translate([R,R,0]) cylinder(r=R,h=Z);
			translate([Enc1_PCB_x-R,R,0]) cylinder(r=R,h=Z);
			translate([R,Enc1_PCB_y-R,0]) cylinder(r=R,h=Z);
			translate([Enc1_PCB_x-R,Enc1_PCB_y-R,0]) cylinder(r=R,h=Z);
		} // hull
		
		 //cube([Enc1_PCB_x, Enc1_PCB_y, 1.6]);
		PCB_Holes() cylinder(d=2,h=3);
	} // diff
} // PCB_Enc1RevA


//PCB_Enc1RevA();
		
module MagnetHolder(){
	M_Holder_len=12;
	Shaft_OD=6;
	
	difference(){
		translate([0,0,-1-M_Holder_len]) cylinder(d=8.8,h=M_Holder_len);
		
		translate([0,0,-1-SE_Magnet_h]) cylinder(d=SE_Magnet_OD+IDXtra,h=SE_Magnet_h+Overlap);
		translate([0,0,-1-M_Holder_len-Overlap]) cylinder(d=Shaft_OD+IDXtra,h=M_Holder_len-SE_Magnet_h-1);
		translate([0,0,-1-M_Holder_len-Overlap]) cylinder(d=Shaft_OD-1,h=M_Holder_len);
	} // diff
	
} // MagnetHolder

//MagnetHolder();

module CoverRevA(Cut=false, HasSPIConn=true, HasABIUVWConn=true){
	
	
	translate([0,0,1]) PCB_Holes() cylinder(d=2,h=4);
	
	translate([0,0,2.6]) PCB_Holes() cylinder(d=6,h=2.4);
	
	difference(){
		translate([0,0,-SE_Cover_h+6]) cylinder(d=SE_Cover_OD,h=SE_Cover_h);
		
		translate([0,0,-SE_Cover_h+6-Overlap])  cylinder(d=SE_Cover_ID,h=SE_Cover_h-2);
		
		// for cutaway view
		if (Cut==true)
		translate([0,0,-SE_Cover_h+6-Overlap]) cube([50,50,50]);
		
		PCB_Enc1(HasSPIConn=HasSPIConn, HasABIUVWConn=HasABIUVWConn);
	} // diff
	
	// Keying pin locator
	difference(){
		hull(){
			translate([-3,SE_Cover_ID/2-2,-SE_Cover_h+6+1.7]) cube([6,3,2]);
			translate([0,SE_Cover_ID/2+0.1,-SE_Cover_h+6+1.7+6]) cylinder(d=0.1,h=0.1);
		} // hull
		translate([0,SE_Cover_ID/2-2,-SE_Cover_h+6+1.7-Overlap]) cylinder(d=3+IDXtra,h=6);
	} // diff
	
	if (Cut==true) color("Red") PCB_Enc1RevA();
} // CoverRevA

//CoverRevA(Cut=true, HasSPIConn=true, HasABIUVWConn=true);

module Cover(Cut=false, HasSPIConn=true, HasABIUVWConn=true){
	
	
	translate([0,0,1]) PCB_Holes() cylinder(d=2,h=4);
	
	translate([0,0,2.6]) PCB_Holes() cylinder(d=6,h=2.4);
	
	difference(){
		translate([0,0,-SE_Cover_h+6]) cylinder(d=SE_Cover_OD,h=SE_Cover_h);
		
		translate([0,0,-SE_Cover_h+6-Overlap])  cylinder(d=SE_Cover_ID,h=SE_Cover_h-2);
		
		// for cutaway view
		if (Cut==true)
		translate([0,0,-SE_Cover_h+6-Overlap]) cube([50,50,50]);
		
		PCB_Enc1(HasSPIConn=HasSPIConn, HasABIUVWConn=HasABIUVWConn);
	} // diff
	
	// Keying pin locator
	difference(){
		hull(){
			translate([-3,SE_Cover_ID/2-2,-SE_Cover_h+6+1.7]) cube([6,3,2]);
			translate([0,SE_Cover_ID/2+0.1,-SE_Cover_h+6+1.7+6]) cylinder(d=0.1,h=0.1);
		} // hull
		translate([0,SE_Cover_ID/2-2,-SE_Cover_h+6+1.7-Overlap]) cylinder(d=3+IDXtra,h=6);
	} // diff
	
	if (Cut==true) color("Red") PCB_Enc1();
} // Cover

//Cover(Cut=true, HasSPIConn=true, HasABIUVWConn=true);
//Cover(Cut=false, HasSPIConn=true, HasABIUVWConn=false);

module Base(){
	difference(){
		union(){
			cylinder(d=SE_Cover_OD,h=1.5);
			cylinder(d=SE_Cover_ID,h=3);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=10,h=3+Overlap*2);
		
		// bolts
		translate([SE_MountingHole_BC/2,0,3]) Bolt4ClearHole();
		translate([-SE_MountingHole_BC/2,0,3]) Bolt4ClearHole();
	} // diff
	
	// keying pin
	translate([0,SE_Cover_ID/2-2,3-Overlap]) cylinder(d=3,h=2);
} // Base

//translate([0,0,-SE_Cover_h+4.5-Overlap]) Base();

module Enc1IntegratedShaftHole(Dia=6.35, Height=10){
	translate([0,0,-Height-1.5]) cylinder(d=Dia, h=Height+Overlap);
	translate([0,0,-1.5-Overlap]) cylinder(d=10,h=3+Overlap*2);
	
} // Enc1IntegratedShaftHole

//Enc1IntegratedShaftHole(Dia=6.35, Height=10);

module IntegratedBase(){
	translate([0,0,-1.5]){
	difference(){
		union(){
			cylinder(d=SE_Cover_OD,h=1.5);
			cylinder(d=SE_Cover_ID,h=3);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=10,h=3+Overlap*2);
		
		// bolts
		//translate([SE_MountingHole_BC/2,0,3]) Bolt4ClearHole();
		//translate([-SE_MountingHole_BC/2,0,3]) Bolt4ClearHole();
	} // diff
	
	// keying pin
	translate([0,SE_Cover_ID/2-2,3-Overlap]) cylinder(d=3,h=2);
}
} // IntegratedBase

//IntegratedBase();




















