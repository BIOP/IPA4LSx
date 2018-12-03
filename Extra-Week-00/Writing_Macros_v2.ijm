/** 
 * Writing Macros
 * ----------------------------------------------
 * 
 * This short macro showcases different ways to use variable (string and number), arrays, for loop
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
for(i=0; i< 3 ; i++) {
	setSlice(i+1);
	run(luts[i]);
	setMinAndMax(min_vals[i], max_vals[i]);
}
// show all the channels at once
run("Make Composite");

