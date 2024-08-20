//
//  shelter-v2
//  
//  v4 - contains completed shelter, platform and ticket machines
//  v5 - deepened shelter construction so it can print
//  v6 - platform reduced to 2x2m sections with dimples, plus ramp
//  v7 - added handrail to ramp and made printable

PRINTRAMP = false;
PRINTPLATFORM = true;
PRINTPLATFORM2 = true;
PRINTPLATFORM3 = true;
PRINTSHELTER = true;
PRINTTICKETMACHINE1 = false;
PRINTTICKETMACHINE2 = false;

$fn=32;

RAILH = 4.5 * 87;

PLATH = 915+RAILH;
PLATL = 4000;
PLATW1 = 2000;
PLATW2 = 100;
PLATOD = 150;
PLATOH = 150;
RAMPW = 1500;

SHELW = 4000;
POLEH = 2336;
POLED = 180;//mm est
POLET = 108*2.5;
SEC1W = 1354.7;
SEC2W = 1290.6;
SEC3W = 1354.7;
ARMW = 43.5;//12;
DIVW = 87;//50;

BOTRAIL = 58*2.5;
MIDRAIL = 450*2.5;
TOPRAIL = 934*2.5;
BOTRAILD = 60*2.5;
MIDRAILD = 36*2.5;
TOPRAILD = 24*2.5;

DOF = 100+30;
SEC1 = 60;//40,,80
SEC2 = 42;//28,,56

SC=2.5;
ROOFP = [[0,94*SC],[684*SC,224*SC],
                   [688*SC,240*SC],
         [0*SC,110*SC]];

SPARP = [[0,0],[66*SC,0],[146*SC,90*SC],[660*SC,196*SC],[674*SC,226*SC],
         [0,94*SC]];
TOPPP = [[0,0],[66*SC,0],[100*SC,70*SC],[100*SC,120*SC],
         [0,94*SC]];


// no 1:87 scaling appled
// need to apply but do with 1mm minimums
scale(1/87)
{

    if (PRINTRAMP == true)
    {
        HRH = 1100;
        HRPH = 1150;
        HRDE = HRPH+15;
        HRR1 = 50;
        HRR2 = 40;
        HRG = 1400;
        //handrail
        translate([0,450,0])
        color("yellow")
        translate([0+PLATL-(PLATL-SHELW)/2,0,HRH])
        {
            translate([0,-(PLATW1+220),-35])
            rotate([0,90+12,0]) cylinder(r=HRR2,h=6000);
            translate([0,-(PLATW1+255),-35])
            rotate([0,90+12,0]) cylinder(r=HRR2,h=6000);
            translate([0,-(PLATW1+220),-550])
            rotate([0,90+12,0]) cylinder(r=HRR2,h=6000);
            translate([0,-(PLATW1+255),-550])
            rotate([0,90+12,0]) cylinder(r=HRR2,h=6000);
            translate([HRG*4+280,-(PLATW1+230),-35-HRDE-620])
            cylinder(r=HRR2,h=570);
            translate([HRG*4+280,-(PLATW1+255),-35-HRDE-620])
            cylinder(r=HRR2,h=570);
        }
        translate([0,450,0])
        color("lightgrey")
        translate([0+PLATL-(PLATL-SHELW)/2,0,0])
        {
            translate([100,-(PLATW1+250),-35])
            cylinder(r=HRR1,h=HRPH);
            translate([HRG,-(PLATW1+250),-35-HRDE*0.25])
            cylinder(r=HRR1,h=HRPH);
            translate([HRG*2,-(PLATW1+250),-35-HRDE*0.5])
            cylinder(r=HRR1,h=HRPH);
            translate([HRG*3,-(PLATW1+250),-35-HRDE*0.75])
            cylinder(r=HRR1,h=HRPH);
            translate([HRG*4,-(PLATW1+250),-35-HRDE])
            cylinder(r=HRR1,h=HRPH);
        }
        
        //ramp
        translate([0+PLATL-(PLATL-SHELW)/2,-PLATW1+PLATOD+5,-PLATH])
        cube([200,RAMPW-10,150]);
        translate([1.46*PLATL-(PLATL-SHELW)/2,-PLATW1+PLATOD+5,-PLATH])
        cube([200,RAMPW-10,150]);
        translate([1.96*PLATL-(PLATL-SHELW)/2,-PLATW1+PLATOD+5,-PLATH])
        cube([200,RAMPW-10,150]);
        color("grey")
        translate([0+PLATL-(PLATL-SHELW)/2,0,0])
        intersection()
        {
            // slope
            rotate([0,12,0])
            {
                translate([0,-PLATW1+PLATOD,-PLATH])
                color("gray")
                    difference()
                    {
                        cube([PLATL*1.5,RAMPW,PLATH-PLATOD]);
                        translate([75,75,-50])
                        cube([PLATL*1.5-150,RAMPW-150,PLATH+200]);
                    }
            
                translate([0,-PLATW1+150,-PLATOD])
                color("lightgray")
                difference()
                {
                    cube([PLATL*1.5,RAMPW,PLATOD]);
                    //concrete sections
                    translate([0,-1,PLATOD+SEC2]) rotate([-90,45,0])
                    cube([SEC1,SEC1,RAMPW+2]);
                    translate([2000,-1,PLATOD+SEC2]) rotate([-90,45,0])
                    cube([SEC1,SEC1,RAMPW+2]);
                    translate([4000,-1,PLATOD+SEC2]) rotate([-90,45,0])
                    cube([SEC1,SEC1,RAMPW+2]);
                    translate([6000,-1,PLATOD+SEC2]) rotate([-90,45,0])
                    cube([SEC1,SEC1,RAMPW+2]);
                }
            }
            translate([-00,-PLATW1-PLATOD,-PLATH])
                cube([PLATL*1.5,PLATW1+PLATOD+PLATOD,PLATH]);
        }
    }
    
    if (PRINTPLATFORM == true)
    {
        platform(0);
        platform(1);
        platform(2);
        platform(3);
    }

    if (PRINTTICKETMACHINE1 == true)
        translate([POLED+SEC1W+SEC2W,-700,0]) ticketmachine();

    if (PRINTTICKETMACHINE2 == true)
        translate([POLED,-700,0]) ticketmachine();

    if (PRINTSHELTER == true)
    {
        shelter(0);
        shelter(1);
        shelter(2);
    }
}

module platform(count)
{
    translate([-(PLATL-SHELW)/2-(count*PLATL),-PLATW1+PLATOD,-PLATH])
        color("gray")
            difference()
            {
                union()
                {
                    cube([PLATL,PLATW1+PLATW2-PLATOD,PLATH-PLATOD]);
                }
                translate([75,75,-100])
                cube([PLATL-150,PLATW1+PLATW2-PLATOD-150,PLATH]);
            }
    
    translate([-(PLATL-SHELW)/2-(count*PLATL),-PLATW1,-PLATOD])
        color("lightgray")
        difference()
        {
            cube([PLATL,PLATW1+PLATW2,PLATOD]);
            //concrete sections
            translate([0,-1,PLATOD+SEC2]) rotate([-90,45,0])
            cube([SEC1,SEC1,PLATW1+PLATW2+2]);
            translate([2000,-1,PLATOD+SEC2]) rotate([-90,45,0])
            cube([SEC1,SEC1,PLATW1+PLATW2+2]);
            translate([4000,-1,PLATOD+SEC2]) rotate([-90,45,0])
            cube([SEC1,SEC1,PLATW1+PLATW2+2]);
            
            //dimples
            translate([-1,250,DOF]) dimples();
            translate([400,250,DOF]) dimples();
            translate([800,250,DOF]) dimples();
            translate([1200,250,DOF]) dimples();
            translate([1600,250,DOF]) dimples();
            translate([2000,250,DOF]) dimples();
            translate([2400,250,DOF]) dimples();
            translate([2800,250,DOF]) dimples();
            translate([3200,250,DOF]) dimples();
            translate([3600,250,DOF]) dimples();
        }    
}

module spar()
{
    SPARW = 87;
    translate([SPARW/2,0,0])
    rotate([90,0,-90]) linear_extrude(height=SPARW,convexity=10,slices=2)
    polygon(SPARP);
}

module shelter(count)
{
  translate([-SHELW*count-PLATL/3,0,0])
  {
    //poles
    if (count > 0)
    {
        color("gray")
        cylinder(r=POLED/2,h=POLEH+POLET);
    }
    color("gray")
    translate([SHELW,0,0])
    cylinder(r=POLED/2,h=POLEH+POLET);
    
    //optional elements
    //noticeboard
    if (count == 1)
    {
        translate([2*SHELW/3,30,BOTRAIL+BOTRAILD])
        {
            cube([SHELW/3-100,POLED/3,TOPRAIL-BOTRAIL-BOTRAILD]);
            translate([50,-POLED/3,50])
            cube([SHELW/3-200,POLED/2,TOPRAIL-BOTRAIL-BOTRAILD-100]);
        }
    }
    if (count == 2)
    {
        translate([POLED/2,30,BOTRAIL+BOTRAILD])
        {
            cube([SHELW/3-100,POLED/3,TOPRAIL-BOTRAIL-BOTRAILD]);
            translate([50,-POLED/3,50])
            cube([SHELW/3-200,POLED/2,TOPRAIL-BOTRAIL-BOTRAILD-100]);
        }
    }
    //seats
    if (count == 1)
    {
        translate([SHELW/10,-300,BOTRAIL+BOTRAILD/2])
        {
            cube([SHELW/7,300,BOTRAILD/2]);
            translate([SHELW/6,0,0])
            cube([SHELW/7,300,BOTRAILD/2]);
            translate([2*SHELW/6,0,0])
            cube([SHELW/7,300,BOTRAILD/2]);
        }
    }
    if (count == 2)
    {
        translate([SHELW/3+SHELW/11,-300,BOTRAIL+BOTRAILD/2])
        {
            cube([SHELW/7,300,BOTRAILD/2]);
            translate([SHELW/6,0,0])
            cube([SHELW/7,300,BOTRAILD/2]);
            translate([2*SHELW/6,0,0])
            cube([SHELW/7,300,BOTRAILD/2]);
        }
    }
    
    
    // roofbox
    color("gray")
    translate([SHELW+POLED/2,0,POLEH]) roof(SHELW+POLED);

    color("yellow")
    translate([SHELW,0,POLEH]) toppanel(SHELW);

    //spars
    if (count > 0)
    {
        color("gray")
        translate([0,0,POLEH]) spar();
    }
    color("gray")
    translate([SEC1W,0,POLEH]) spar();
    color("gray")
    translate([SEC1W+SEC2W,0,POLEH]) spar();
    color("gray")
    translate([SHELW,0,POLEH]) spar();

    //small rear roof
    translate([0,-8.6,POLEH+POLET-48])
        rotate([10,0,0]) cube([SHELW,100,50]);

    color("gray")
    translate([0,0,BOTRAIL])
    cube([SHELW,POLED/2,BOTRAILD]);

    color("gray")
    translate([0,0,MIDRAIL])
    cube([SHELW,POLED/2,MIDRAILD]);

    color("gray")
    translate([0,0,TOPRAIL])
    cube([SHELW,POLED/2,TOPRAILD]);

    color("gray")
    translate([SEC1W-DIVW/2,0,BOTRAIL])
    cube([DIVW,POLED/2,TOPRAIL-BOTRAIL]);

    color("gray")
    translate([SEC1W+SEC2W-DIVW/2,0,BOTRAIL])
    cube([DIVW,POLED/2,TOPRAIL-BOTRAIL]);
  }
}    


module roof(w)
{
    rotate([90,0,-90]) linear_extrude(height=w,convexity=10,slices=2)
    polygon(ROOFP);
}

module toppanel(w)
{
    rotate([90,0,-90]) linear_extrude(height=w,convexity=10,slices=2)
    polygon(TOPPP);
}

module ticketmachine()
{
    TMW = 1000;
    TMD = 600;
    TMH = 2000;
    TMH1 = 250;
    TMH2 = 1450;
    TMH3 = 300;
    
    //foot
    color("black")
    translate([5,5,0])
    cube([TMW-10,TMD-10,TMH1]);

    //body
    color("gray")
    translate([0,0,TMH1])
    difference()
    {
      union()
      {
        cube([TMW,TMD,TMH2]);
        translate([100,-100,400])
        {
          cube([TMW*0.7,TMD,300]);
          rotate([-45,0,0]) cube([TMW*0.7,TMD,200]);
          translate([0,0,300])
          rotate([-45,0,0]) cube([TMW*0.7,TMD,200]);
        }
        translate([TMW-150,-50,550]) cube([100,100,150]);
      }
      translate([100,-250,968])
      rotate([-35,0,0]) cube([TMW*0.5,300,280]);
      rotate([-10,0,0])
      translate([150,-250,475]) cube([TMW*0.59,200,100]);
      translate([TMW-150,-200,820]) cube([100,225,250]);

    }
    
    //top
    color("yellow")
    {
        translate([0,0,TMH1+TMH2])
        cube([TMW,TMD,TMH3]);
        translate([50,-100,TMH1+TMH2+100])
        {
            translate([0,50,0]) cylinder(r=50,h=200);
            translate([TMW-100,50,0]) cylinder(r=50,h=200);
            cube([TMW-100,TMD+100,TMH3-100]);
            translate([-50,50,0]) cube([TMW,TMD+50,TMH3-100]);
            
        }
    }
}

module dimples()
{
    DIMR = 20;
    D = [2,1.25,1];
    DEP = -20;
    difference()
    {
        cube([402,240,100]);
        translate([70,40,DEP]) scale(D) cylinder(r=DIMR,h=200);
        translate([70,120,DEP]) scale(D)  cylinder(r=DIMR,h=200);
        translate([70,200,DEP]) scale(D)  cylinder(r=DIMR,h=200);
        translate([200,40,DEP]) scale(D)  cylinder(r=DIMR,h=200);
        translate([200,120,DEP]) scale(D)  cylinder(r=DIMR,h=200);
        translate([200,200,DEP]) scale(D)  cylinder(r=DIMR,h=200);
        translate([330,40,DEP]) scale(D)  cylinder(r=DIMR,h=200);
        translate([330,120,DEP]) scale(D)  cylinder(r=DIMR,h=200);
        translate([330,200,DEP]) scale(D)  cylinder(r=DIMR,h=200);
    }                    
}