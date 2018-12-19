/* 
 * Fourier Stripe Filtering
 * ----------------------------------------------
 * 
 * This short macro shows the destriping procedure presented in the course slides from 4.3.2
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

waitForUser("Please Open 'image_with_stripes.tif' and 'Stripe_Filter.tif'");

selectImage("image_with_stripes.tif");

// Make a copy and apply the stripe filter in Fourier
run("Duplicate...", "title=[Destriped Image]");

// We just run the custom filter on the stiped image
run("Custom Filter...", "filter=Stripe_Filter.tif");

// We can check the difference between the two images to see what was removed
imageCalculator("Subtract create 32-bit", "Destriped Image","image_with_stripes.tif");

rename("Difference between the striped and destriped images");

run("Tile");