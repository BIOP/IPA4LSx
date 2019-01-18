/** 
 * 
 * ----------------------------------------------
 * 
 * This short macro showcases different a way to analyse images from :
 * https://drive.google.com/open?id=1xWbruaJmOUe0CQ-3v5eLtNqgcIVKrHpX
 *  
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// clear environment
roiManager("reset");
print("\\Clear");
close("\\Others");

// and define measurements
run("Set Measurements...", "area mean standard modal min area_fraction limit display redirect=None decimal=5");

// Channels Info
dapi_chNbr = 1 ;
measure_chNbr = 2 ; 

// Detection
medianRadius = 2 ;  
auto_threshold = "Huang ";

// output 
makeFlatten = false;
makeGlobalresults_ratherThanIndividual = true ;

image_name = getTitle();
image_id = getImageID();

run("Duplicate...", "title=["+image_name+"] duplicate");
run("Split Channels");
selectWindow("C"+dapi_chNbr+"-"+image_name);

// pre-filtering
//
// Applly median filtering 
if (medianRadius > 0 ) run("Median...", "radius="+medianRadius);

// thresholding
setAutoThreshold(auto_threshold+" dark");
setOption("BlackBackground", true);
run("Convert to Mask");

// Cleaning
run("Options...", "iterations=5 count=3 black edm=8-bit do=Open");
run("Fill Holes");
run("Watershed");

// Detect Particles
run("Analyze Particles...", "summarize add");

selectImage(image_id);
roiManager("Show All");
Stack.setChannel( measure_chNbr);


if (makeFlatten) run("Flatten", "slice");

if ( makeGlobalresults_ratherThanIndividual ) {
	selectImage(image_id);
	roisToSelect = Array.getSequence( roiManager("Count")) ;
	roiManager("Select",roisToSelect );
	roiManager("OR");
	roiManager("Add");
	roiManager("Select", (roiManager("Count")-1) ); 
	roiManager("Rename", "All" );
}else{
	roiManager("deselect");
}
roiManager("Measure");