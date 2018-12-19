/* 
 * Ratio Image Demo for Showing Image Math 
 * 
 * Note that this data is pre-processed to only highlight the image calculations done
 * 
 * No filtering or other image processing method is shown here.
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */
 
run("Close All");
waitForUser("Please Open 'Ratio Demo Image_Cleaned.tif'\nand press OK.");
// Use Batch Mode to avoid showing intermediate steps
setBatchMode(true);

// Duplicate it to keep original
run("Select None");
run("Duplicate...", "duplicate");

// Get name of image for subsequent use
name = getTitle();


// Restore the selection
run("Restore Selection");

// Convert to 32 bit in order to produce accurate results
run("32-bit");

// Set the outside of the circles to Not A Number (NaN) to exclude them from the ratio calculation
run("Make Inverse");
run("Set...", "value=NaN stack");


channel1 = "C1-"+name;
channel2 = "C2-"+name;

// split Channels to perform the ratio
run("Split Channels");

// Divide Channel 1 With Channel 2
imageCalculator("Divide create 32-bit", channel1, channel2);

//Rename for convenience
rename("C1 Divided By C2 - "+name);

// Set the display scale to between 0 and 5
setMinAndMax(0,5.0);

// Choose an appropriate Lookup Table
run("6 shades");

// Show the resulting image
setBatchMode("Show");
setLocation(200, 200);

// Create a Scale Bar to Go With the Image
newImage("Scale 0 to 5.0", "32-bit ramp", 256, 20, 1);
run("6 shades");
// and make it Vertical
run("Rotate 90 Degrees Left");

// The Ramp 32 bit image goes from 0 to 1 so we multiply it by 5 so it matches our image scale
run("Multiply...", "value=5.0");
setMinAndMax(0,5.0);

// Show the scale bar
setBatchMode("Show");
setLocation(50, 200);

// Exit Batch Mode
setBatchMode(false);
waitForUser("If you hover the mouse over the image,\nyou can read the ratio of C1 to C2 for each pixel");
