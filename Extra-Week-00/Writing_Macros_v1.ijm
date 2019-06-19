/** 
 * Writing Macros
 * ----------------------------------------------
 * 
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// set Parameters 
luts     = newArray("Cyan", "Green", "Magenta");
min_vals = newArray(0, 0, 0);
max_vals = newArray(170, 130, 255);

// set the slice, the LUT and the min and Max values for BrightnessContrast
// for each channels

setSlice(0);
run(luts[0]);
setMinAndMax(min_vals[0], max_vals[0]);

setSlice(1);
run(luts[1]);
setMinAndMax(min_vals[1], max_vals[1]);

setSlice(2);
run(luts[2]);
setMinAndMax(min_vals[2], max_vals[2]);

// show all the channels at once
run("Make Composite");

