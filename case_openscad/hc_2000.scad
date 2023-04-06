$fn = 24;
module barr()
{
    difference()
    {
        cube([5, 5, 10]);
        cylinder(d=5, h=10);
    }
}

module main()
{
    difference()
    {
        difference()
        {    
            cube([500, 200, 55]);
            translate([0, 0, 40]) rotate([4.5, 0, 0]) cube([500 - 120, 200 - 50, 55]);
            translate([0, 2.5, 38]) rotate([0, 270, 180]) scale([1, 1, 50 - 12]) barr();
            translate([500 - 120, 2.5, 52.5]) rotate([0, 270, 180]) scale([1, 1, 12]) barr();
            translate([0, 200-47.9, 52.5]) rotate([0, 270, 180]) scale([1, 1, 50-12]) barr();
            translate([0, 197.5, 52.5]) rotate([0, 90, 0]) rotate([0, 0, 90]) scale([1, 1, 50]) barr();
            
            translate([40, 35, 20]) rotate([4.5, 0, 0]) cube([245, 100, 35]);
            difference()
            {
                union()
                {
                    translate([0, -10,  -1]) cube([510, 15, 21]);
                    translate([5, 10,  5]) cube([490, 185, 45]);
                    translate([5,  5, 25]) cube([490, 185, 25]);
                }
                translate([0, 0, 35]) rotate([4.5, 0, 0]) cube([500 - 115, 200 - 55, 55]);
            }
            
            translate([390, -5, 25]) cube([102, 100, 25]);
            for(i = [50: 5: 400])
            {
                translate([i, 170, 30]) rotate([0, -35, -25]) cube([2, 600, 150]);
                translate([i, 0, -1]) rotate([0, -35, -25]) cube([2, 20, 15]);
            }
            //cutter
            //translate([-1, -1, -1]) cube([100, 500, 500]);
            //translate([-1, -1, -1]) cube([700, 80, 500]);
        }
        translate([-1, 2.5, 22.5]) rotate([90, 0, 0]) rotate([0, 270, 180]) scale([1, 1, 51]) barr();
        translate([-1, 7.5, 2.5]) rotate([90, 0, 0]) rotate([0, 270, 180]) scale([1, 1, 51]) barr();
        translate([-1, 197.5, 2.5]) rotate([180, 0, 0]) rotate([0, 270, 180]) scale([1, 1, 51]) barr();
    }
}

module one()
{
    difference()
    {
        main();
        translate([190, -1, -1]) cube([600, 600, 600]);
    }
}

module two()
{
    difference()
    {
        main();
        translate([-1, -1, -1]) cube([190, 600, 600]);
        translate([380, -1, -1]) cube([600, 600, 600]);
    }
}

module three()
{
    difference()
    {
        main();
        translate([-1, -1, -1]) cube([380, 600, 600]);
        //translate([400, -1, -1]) cube([200, 600, 600]);
    }
}

module capac()
{
    difference()
    {
        main();
        translate([5, -1, -1]) cube([500, 600, 600]);
        //translate([400, -1, -1]) cube([200, 600, 600]);
    }
}

//main();

//translate([0, -200, 0]) color("Red") one();

translate([0, 200, 0]) color("Green")
union()
{
    color("Blue") one();
    color("Red") two();
    translate([375, 0, 0]) capac();
}

//translate([0, -100, 0]) color("Blue") three();
