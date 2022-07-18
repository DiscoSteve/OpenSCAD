//  Micro Bee in the City
//
//  Reverse engineered from photos of the real Manchester Bee In The City
//  see https://beeinthecitymcr.co.uk
//
//  micro-bee-in-the-city-v2.scad - 3D printable Bee In The City by Steve Nicklin
//  Copyright (C) 2018  Steve Nicklin		                            
//
//  This program is free software; you can redistribute it and\or modify    
//  it under the terms of the GNU General Public License as published by    
//  the Free Software Foundation; either version 3 of the License, or       
//  (at your option) any later version.                                     
//  This program is distributed in the hope that it will be useful,         
//  but WITHOUT ANY WARRANTY; without even the implied warranty of          
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           
//  GNU General Public License for more details.                            
//  You should have received a copy of the GNU General Public License       
//  along with this program; if not, write to the Free Software Foundation, 
//  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA       
//                                                                          
//  You can contact the author at steve@stevenicklin.com                    
//
//  Change History
//  Date      Ver Description
//  --------------------------------------------------------------------------------------
//  20180730  V1  Base print for first 7 micro bees
//  20180804  V2  grouped elements to allow base to be printed - change removed
//  20180806  V3  increased antennae thickness due to print issues, inc. GNU GPL statement
//  --------------------------------------------------------------------------------------


$fn = 54;

BASE_HEIGHT = 1.0; // Metre
BASE_WIDTH = 0.5;
BASE_DEPTH = 0.7;

//
// Base that bee sits on
//
color("LightBlue")
    translate([0,0,0.2])
        Base();
    
//
// Bee made up of a Head, Thorax, Abdomen and Wings
//
translate([-0.35,0,1.5])
{
    rotate([0,0,20])
        Head();
    translate([0.35,0,-0.2])
        rotate([0,-60,0])
        Thorax();
    translate([0.42,0,-0.3])
        rotate([0,125,0])
        Abdomen();
  color("White")
    translate([0,0,0])
        Wings();
}

//
// Base - made up of a stretched sphere cut in half and stood on flat face
//
module Base()
{
  union()
  {
    intersection()
    {
        translate([-1,-1,0]) cube([2,2,2]);
        scale([0.7,0.5,0.8]) sphere(r=1);
    }
    translate([0,0,-0.2])
      scale([0.7,0.5,0.2])
        cylinder(r=1,h=1);
  }
}

//
// Wings - made of two polygons extruded
//
module Wings()
{
    // Left Outer Wing
    translate([0.3,-0.1,-0.0])
        rotate([90,20,-10])
            scale([0.045,0.045,0.045])
                Wing();

    // Left Inner Wing
    translate([0.42,-0.1,-0.05])
        rotate([90,25,-10])
            scale([0.038,0.02,0.04])
                Wing();

    // Right Outer Wing
    translate([0.3,0.1,-0.0])
        rotate([90,20,10])
            scale([0.045,0.045,0.045])
                Wing();

    // Right Inner Wing
    translate([0.42,0.1,-0.05])
        rotate([90,25,10])
            scale([0.038,0.02,0.04])
                Wing();
}

module Wing()
{
    linear_extrude(height=0.5,convexity=10)
        polygon(points=[[0,0],
        [7,3.6],[15,7.8],
        [21,9.5],[23,9.8],
        [24,9.5],[24.6,9],
        [24.9,8],[25.1,7],
        [25.2,6],[25.1,5],
        [25,4.3],[24.1,3],
        [23.2,2],[22.2,1],
        [21.3,0.3],[21,0.2],
        [20,0]]);
    
}
//
// Head - made up of head shape, with eyes and antennae
//
module Head()
{
    MainHead();
    color([0.2,0.2,0.2])
        Eyes();
    color([0.2,0.2,0.2])
        Antennae();
}

//
// Eyes - built from a cut out of an enlarged head shape to ensure they lay directly on head
//
module Eyes()
{
    intersection()
    {
        // redraw head scaled outwards
        scale([1.05,1.05,1.05]) MainHead();
        // chopped out to circ;e/ovals of bigger head shape to make eyes
        translate([0,0,-0.04]) union()
        {
            rotate([0,-90,-60]) 
            {
                cylinder(r=0.11,h=0.25);
                intersection()
                {
                    scale([1.5,1,1]) cylinder(r=0.11,h=0.25);
                    translate([-0.2,-0.12,0]) cube([0.2,0.25,1]);
                }
            }
            rotate([0,-90,60]) 
            {
                cylinder(r=0.11,h=0.25);
                intersection()
                {
                    scale([1.5,1,1]) cylinder(r=0.11,h=0.25);
                    translate([-0.2,-0.12,0]) cube([0.2,0.25,1]);
                }
            }
        }
    }
}

//
// MainHead - constructed from a merge of half a sphere and half a stretched sphere
//
// NOTE - this needs reworking to take a small portion of a very stretched (but larger)
//        sphere to get a more pointed lower head shape
//
module MainHead()
{
    scale([0.9,1,1])
    {
        intersection()
        {
            translate([-1,-1,0]) cube([2,2,2]);
            scale([0.2,0.2,0.14]) sphere(r=1);
        }
        intersection()
        {
            translate([-1,-1,-2]) cube([2,2,2]);
//            scale([0.2,0.2,0.35]) sphere(r=1);
            translate([0,0,0.6]) scale([0.25,0.25,1]) sphere(r=1);
        }
    }
}

//
// Antenna - made up of a shrinking cylinder for the lower antenna and two spheres either end
//           of a shorter cylinder for the upper antenna
//
// NOTE - this needs reworking to use a chop of a torus for the bend between antenna parts
//
module Antennae()
{
    ANT_LEN_BOT = 0.225;
    ANT_LEN_TOP = 0.1;
    
    // 20180806 - V3 - increased thickness due to print issues
    ANT_RAD_BOT = 0.03;//0.018;
    ANT_RAD_TOP = 0.022;//0.013;
    ANT_BOT_HEIGHT = 0.1;//0.11;
    ANT_BOT_LR = 0.1;
    ANT_BOT_FB = -0.05;
    
    // Right Antenna
    translate([ANT_BOT_FB,ANT_BOT_LR,ANT_BOT_HEIGHT])
    {
        rotate([-10,-10,0])
        {
            // Lower
            cylinder(r1=ANT_RAD_BOT,r2=ANT_RAD_TOP,h=ANT_LEN_BOT);
            translate([0,0,ANT_LEN_BOT]) 
            {
                sphere(r=ANT_RAD_TOP);
                rotate([0,-70,-20])
                {
                    // Upper
                    cylinder(r=ANT_RAD_TOP,h=ANT_LEN_TOP);
                    translate([0,0,ANT_LEN_TOP]) sphere(r=ANT_RAD_TOP);
                }
            }
        }
    }
    
    // Left Antenna
    translate([ANT_BOT_FB,-ANT_BOT_LR,ANT_BOT_HEIGHT])
    {
        rotate([10,-10,0])
        {
            // Lower
            cylinder(r1=ANT_RAD_BOT,r2=ANT_RAD_TOP,h=ANT_LEN_BOT);
            translate([0,0,ANT_LEN_BOT]) 
            {
                sphere(r=ANT_RAD_TOP);
                rotate([0,-70,20])
                {
                    // Upper
                    cylinder(r=ANT_RAD_TOP,h=ANT_LEN_TOP);
                    translate([0,0,ANT_LEN_TOP]) sphere(r=ANT_RAD_TOP);
                }
            }
        }    }
}

//
// Thorax - made up of a sphere and three three part legs either side
//
module Thorax()
{
        // Thorax
        scale([0.25,0.25,0.25]) sphere(r=1);
 
        // Left Legs
        rotate([0,-30,7]) translate([-0.14,-0.23,0.11])
        {
            // Upper limb
            scale([0.17,0.05,0.05]) sphere(r=1);
            translate([-0.23,0.01,0.09]) rotate([0,40,-3])
            {
                // Lower Limb plus foot
                scale([0.17,0.05,0.05]) sphere(r=1);
                translate([-0.18,0.005,0]) rotate([10,90,0])
                Foot();
            }
        }
        rotate([0,-45,13]) translate([-0.14,-0.25,0.03])
        {
            // Upper limb
            scale([0.17,0.05,0.05]) sphere(r=1);
            translate([-0.23,0,0.09]) rotate([0,40,0])
            {
                // Lower Limb plus foot
                scale([0.17,0.05,0.05]) sphere(r=1);
                translate([-0.18,0.00,0]) rotate([0,90,0])
                Foot();
            }
        }
        rotate([0,-60,30]) translate([-0.25,-0.24,0.02])
        {
            // Upper limb
            scale([0.19,0.05,0.05]) sphere(r=1);
            translate([-0.29,0.05,0.09]) rotate([0,30,-20])
            {
                // Lower Limb plus foot
                scale([0.2,0.05,0.05]) sphere(r=1);
                translate([-0.19,0.00,-0.01]) rotate([45,70,50])
                scale([1.1,1,1.2]) Foot();
            }
        }
        
        // Right Legs
        rotate([0,-30,-7]) translate([-0.14,0.23,0.11])
        {
            // Upper limb
            scale([0.17,0.05,0.05]) sphere(r=1);
            translate([-0.23,-0.01,0.09]) rotate([0,40,3])
            {
                // Lower Limb plus foot
                scale([0.17,0.05,0.05]) sphere(r=1);
                translate([-0.18,-0.005,0]) rotate([-10,90,0])
                Foot();
            }
        }
        rotate([0,-45,-13]) translate([-0.14,0.25,0.03])
        {
            // Upper limb
            scale([0.17,0.05,0.05]) sphere(r=1);
            translate([-0.23,0,0.09]) rotate([0,40,0])
            {
                // Lower Limb plus foot
                scale([0.17,0.05,0.05]) sphere(r=1);
                translate([-0.18,0.00,0]) rotate([0,90,0])
                Foot();
            }
        }
        rotate([0,-60,-30]) translate([-0.25,0.24,0.02])
        {
            // Upper limb
            scale([0.19,0.05,0.05]) sphere(r=1);
            translate([-0.29,-0.05,0.09]) rotate([0,30,20])
            {
                // Lower Limb plus foot
                scale([0.2,0.05,0.05]) sphere(r=1);
                translate([-0.19,0.00,-0.01]) rotate([45,70,40])
                scale([1.1,1,1.2]) Foot();
            }
        }
}

//
// Foot - made up of half sphere topping a stretched half sphere
//
module Foot()
{
    intersection()
    {
        translate([-0.1,-0.1,-0.1]) cube([0.2,0.2,0.1]);
        scale([0.035,0.035,0.09]) sphere(r=1);
    }
    intersection()
    {
        translate([-0.1,-0.1,0]) cube([0.2,0.2,0.1]);
        scale([0.035,0.035,0.035]) sphere(r=1);
    }
   
}

//
// Thorax2 - module not used
//
module Thorax2()
{
    intersection()
    {
        translate([-1,-1,0]) cube([2,2,2]);
        scale([0.25,0.25,0.25]) sphere(r=1);
    }

    translate([0,0,-0.1])
        cylinder(r=0.25,h=0.1);

    translate([0,0,-0.1])
    intersection()
    {
        translate([-1,-1,-2]) cube([2,2,2]);
        scale([0.25,0.25,0.1]) sphere(r=1);
    }
   
}

//
// Leg - module not used, legs baked into Thorax module
//
module Leg(L1,L2,L3,A1,A2)
{
}

//
// Abdomen - made from two halfs of an extrusion of the grooves
//
module Abdomen()
{
    // Upper half abdomen - slightly stretched upwards
    rotate([0,0,90])  scale([1,1.2,1]) HalfAbdomen();
    // Lower half abdomen - slightly squashed
    rotate([0,0,-90]) scale([1,0.6,1]) HalfAbdomen();
    
}

//
// HalfAbdomen - extrusion of a set of points to delineate the grooves and curved profile
//
module HalfAbdomen()
{
    intersection()
    {
      rotate_extrude(convexity=10)
        polygon( points=[[0,0],
                         [0.100,0.02],
                         [0.190,0.05],
                         [0.239,0.10],
    
                         [0.28,0.1875],
                         [0.275,0.2000],
                         [0.285,0.2125],
    
                         [0.300,0.3600],
                         [0.290,0.3725],
                         [0.300,0.3850],
    
                         [0.300,0.5375],
                         [0.290,0.5500],
                         [0.295,0.5625],
    
                         [0.265,0.7125],
                         [0.255,0.7250],
                         [0.256,0.7375],

                         [0.200,0.840],
                         [0.180,0.850],
                         [0.185,0.860],
                         
                         [0.157,0.900],
                         [0.120,0.930],
                         [0.100,0.940],
                         [0.080,0.950],
                         [0.060,0.955],
                         [0.000,0.960]] );
      translate([-0.5,0,0]) cube([1,1,1]);
    }
}
