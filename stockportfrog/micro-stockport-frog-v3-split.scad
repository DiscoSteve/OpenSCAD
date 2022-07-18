//  Micro Stockport Frog
//
//  Reverse engineered from photos of the real Stockport Frog
//  see https://stockportsgiantleap.co.uk/
//
//  micro-stockport-frog-v1.scad - 3D printable Stockport Frog by Steve Nicklin
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
//  --------------------------------------------------------------------------------------


$fn = 64;

PRINTALL = false;
PRINTHAT = false;
PRINTFROG = true;

HATDIA = 13.8;
HATHGT = 13.4;
RIMDIA = 21.4;
RIMHGT = 2.25;

EYEDIA = 9.5;
EYESPC = 43/32 * EYEDIA;

translate([0,-RIMDIA*1.7,RIMDIA*2.63])
rotate([3,0,0])
{
    difference()
    {
        union()
        {
            if (PRINTALL == true || PRINTFROG == true)
                translate([-(EYESPC+EYEDIA)/2,(HATDIA-EYEDIA)/2,EYEDIA/2-RIMHGT/2])
                    eye();
            if (PRINTALL == true || PRINTHAT == true)
                translate([0,0,0])
                    hat();
            if (PRINTALL == true || PRINTFROG == true)
                translate([(EYESPC+EYEDIA)/2,(HATDIA-EYEDIA)/2,EYEDIA/2-RIMHGT/2])
                    eye();
        }
        if (PRINTHAT == false && PRINTFROG == true)
        {
            translate([0,0,0])
                hat();
        }
    }
}


BODYTOPWID = HATDIA*2.8;
BODTTOPHGT = HATDIA*1.5;
BODYBOTWID = HATDIA*4;
BODYBOTHGT = BODYBOTWID * 0.9;
BODYLEN = (RIMDIA * 4) - (BODYTOPWID/2)*1.3 - BODYBOTWID/2;

translate([0,0,BODYBOTHGT/2])
{
    if (PRINTALL == true || PRINTFROG == true)
        body();
}

translate([BODYTOPWID/2.575,-BODYLEN/1.31,0])
{
    if (PRINTALL == true || PRINTFROG == true)
        frontleg();  
}
translate([-BODYTOPWID/2.575,-BODYLEN/1.31,0])
{
    if (PRINTALL == true || PRINTFROG == true)
        scale([-1,1,1]) frontleg();  
}
translate([BODYTOPWID/2,-BODYLEN/7,0])
{
    if (PRINTALL == true || PRINTFROG == true)
        backleg();  
}
translate([-BODYTOPWID/2,-BODYLEN/7,0])
{
    if (PRINTALL == true || PRINTFROG == true)
        scale([-1,1,1]) backleg();  
}

BLEGLEN1 = HATDIA * 2.75;
BLEGDIA1 = HATDIA * 1.35;

BLEGLEN2 = HATDIA * 2.2;
BLEGDIA2 = HATDIA * 1.35;

BLEGLEN3 = HATDIA * 2.9;
BLEGDIA3 = HATDIA * 1.35;


module backleg()
{
    color("red")
    {
        translate([0,BLEGLEN2/4,BLEGDIA1*1.2])
        rotate([30,0,25])
        scale([1,BLEGLEN2/BLEGDIA2,1])
            sphere(r=BLEGDIA2/2);

        translate([0,BLEGLEN1/2.75,BLEGDIA1])
        rotate([10,0,15])
        scale([1,BLEGLEN1/BLEGDIA1,1])
            sphere(r=BLEGDIA1/2);

        translate([-BLEGDIA3/10,BLEGLEN3/2.8,BLEGDIA3/1.6])
        rotate([30,20,15])
        scale([1,BLEGLEN3/BLEGDIA3,0.7])
            sphere(r=BLEGDIA3/2);

    }
    toes(5);
}

LEGDIA = HATDIA *0.8;
LEGLEN = HATHGT*2.9;

module frontleg()
{
    color("red")
    {
        // leg and heel
        translate([0,0,LEGDIA/4])
          scale([1,1,0.5])
            sphere(r=LEGDIA/2);
        translate([0,0,LEGDIA/4])
            cylinder(r=LEGDIA/2,h=LEGLEN);
        
    }
    toes(4);
}

TOEDIA = LEGDIA/2.5;
TOELEN = TOEDIA * 3;

module toes(toecount)
{
    color("red")
    {
        // new inner toe
        translate([-TOEDIA/2,TOEDIA/8,TOEDIA/2])
          rotate([90,90,-10])
          {
            hull()
            {
                cylinder(r1=TOEDIA/2,r2=TOEDIA/2,h=TOELEN);
                sphere(r=TOEDIA/2);
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.7);
            }
            {
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.5);
            }
        }
        translate([-TOEDIA/6,0,TOEDIA/2])
          rotate([90,90,4])
          {
            hull()
            {
                cylinder(r1=TOEDIA/2,r2=TOEDIA/2,h=TOELEN);
                sphere(r=TOEDIA/2);
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.7);
            }
            {
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.5);
            }
          }
        translate([TOEDIA/6,0,TOEDIA/2])
          rotate([90,90,18])
          {
            hull()
            {
                cylinder(r=TOEDIA/2,h=TOELEN);
                sphere(r=TOEDIA/2);
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.7);
            }
            {
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.5);
            }
          }
        //outer toe
        translate([TOEDIA/2,TOEDIA/8,TOEDIA/2])
          rotate([90,90,32])
          {
            hull()
            {
                cylinder(r=TOEDIA/2,h=TOELEN);
                sphere(r=TOEDIA/2);
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.7);
            }
            {
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.5);
            }
          }
        if (toecount == 5)
        {
          translate([TOEDIA/3,TOEDIA/3,TOEDIA/2])
          rotate([90,90,50])
          {
            hull()
            {
                cylinder(r=TOEDIA/2,h=TOELEN);
                sphere(r=TOEDIA/2);
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.7);
            }
            {
                translate([-TOELEN/18,0,TOELEN])
                sphere(r=TOEDIA/1.5);
            }
          }
        }         
    }
}

module hat()
{
    color("green")
    {
        cylinder(r=RIMDIA/2,h=RIMHGT);
        translate([0,0,RIMHGT])
            cylinder(r=HATDIA/2,h=HATHGT);
    }
}

module eye()
{
    color("red")
        sphere(r=EYEDIA/2);
}


module body()
{
    color("red")
    rotate([-40,0,0])
    translate([0,-BODYLEN,0])
    {
            // TO BE DELETED


      difference()
      {
        hull()
        {
            rotate([22,0,0])
            translate([0,0,0])
                scale([1,1.3,BODTTOPHGT/BODYTOPWID]) sphere(r=BODYTOPWID/2);
            translate([0,BODYLEN,0])
                scale([1,1,BODYBOTHGT/BODYBOTWID]) sphere(r=BODYBOTWID/2);
        }
        if (PRINTHAT == false)
        {
                translate([0,BODYLEN,0])
                rotate([40,0,0])
                translate([0,0,-BODYBOTHGT/2])
                translate([0,-RIMDIA*1.7,RIMDIA*2.63])
                rotate([3,0,0])
                hat();
        }

        rotate([22,0,0])
            translate([0,0,0])
            {
            difference()
            {
                scale([1,1.3,BODTTOPHGT/BODYTOPWID]) cylinder(r=BODYTOPWID/1.85,h=1);
                scale([1,1.3,BODTTOPHGT/BODYTOPWID])
                    translate([0,0,-1]) cylinder(r=BODYTOPWID/2.05,h=4);
                    translate([-BODYTOPWID,-BODYTOPWID/2.5,-1])
                        cube([BODYTOPWID*2,BODYTOPWID,4]);
            }

        }
      }
    }
}