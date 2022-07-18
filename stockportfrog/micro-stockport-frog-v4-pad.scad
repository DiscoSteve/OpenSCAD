//  Micro Stockport Frog
//
//  Reverse engineered from photos of the real Stockport Frog
//  see https://stockportsgiantleap.co.uk/
//
//  micro-stockport-frog-v4.scad - 3D printable Stockport Frog by Steve Nicklin
//  Copyright (C) 2019  Steve Nicklin		                            
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
//  Date        Ver Description
//  --------------------------------------------------------------------------------------
//  20190616    V1  Base print for first few micro frogs
//  20190619    V2  Added front feet and toes
//  20190620    V3  Added rear leags, feet and toes
//  20190622    V3-split  Same as V3 but model split into frog and hat
//  20190626    V4  Added lilypad base
//  --------------------------------------------------------------------------------------


$fn = 64;

HATHGT = 13.4;

LILYDEP = HATHGT * (40.85/100);
LILYRAD1 = 20;
LILYRAD2 = 11;
LILYRAD3 = 3;


translate([0,-5,-LILYDEP])
{
    lilypad();
}

module lilypad()
{
    color("green")
    {
        difference()
        {
            cylinder(r=LILYRAD1,h=LILYDEP);
            translate([0,-LILYRAD1,-0.1])
            cube([LILYRAD1+1,LILYRAD1+1,LILYDEP+0.2]);
        }
        translate([0,-LILYRAD1+LILYRAD2,-0.1])
            cylinder(r=LILYRAD2,h=LILYDEP);
        translate([LILYRAD1-LILYRAD2,0,-0.1])
            cylinder(r=LILYRAD2,h=LILYDEP);
        translate([LILYRAD1-LILYRAD2+LILYRAD3+1.305,
                  -LILYRAD1+LILYRAD2-LILYRAD3-1.305,-0.1])
        difference()
        {
                translate([-LILYRAD3*2-0.8,0.8,0])
                cube([LILYRAD3*2,LILYRAD3*2,LILYDEP]);
                translate([0,0,-0.1])
                cylinder(r=LILYRAD3,h=LILYDEP*2);
        }
    }
}

