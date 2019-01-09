/** 
 *  Difference of Gaussian & Watershed
 * ----------------------------------------------
 * 
 * This short macro showcases use of Difference of Gaussian combined with watershed 
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2019 - Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */
 
close("\\Others");
roiManager("reset");

// you need to open an image first.
// like thet homogeneous_beads.tif or heterogeneous_beads.tif
// iamges can be downloaded at : 
// https://drive.google.com/a/epfl.ch/file/d/1hdBO-z6GxYRv-E9AXY1NUv3cnjM1h-3W/view?usp=sharing
beads_image = getTitle()

// we define here a sigma for a Gaussian Blur
sigma1 = 1 ;
// and we calculate a 2nd sigma, by multipling sigma by a given factor.
// (in this exemple it's 1.6 but it could be different) 
sigma2 = 1.6 * sigma1 ; 

// select the image, duplicate and apply a Gaussian Blur with the defined Sigma
selectImage(beads_image);
run("Duplicate...", "title=gb"+sigma1);
run("Gaussian Blur...", "sigma="+sigma1);
//
selectImage(beads_image);
run("Duplicate...", "title=gb"+sigma2);
run("Gaussian Blur...", "sigma="+sigma2);

// Calcultate an image by substrating the smallest to the largest sigma
imageCalculator("Subtract create 32-bit", "gb"+sigma2,"gb"+sigma1);
selectImage(nImages);
rename("Difference of Gaussian");

// Thresholding
setAutoThreshold("Triangle no-reset");
run("Convert to Mask");

// Use the Watershed
run("Watershed");

// Detect Particles
run("Analyze Particles...", "size=20-Infinity pixel summarize add");