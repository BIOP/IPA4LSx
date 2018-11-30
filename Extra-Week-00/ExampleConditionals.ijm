/** 
 * Excercise Conditionals
 * ----------------------------------------------
 * 
 * This short macro showcases the use of the conditional if/else statement
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Arne Seitz, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

if (nImages==0){	//the function nImages returns the number of open images. 				
		File.openDialog("Please select an image to open");
		toOpen=File.directory+File.name;
		waitForUser("The file you selected is: "+toOpen);
		open(toOpen);
}
//The conditional above asures that there is an image opened.

title=getTitle();		//retuens the title of he current image

if (endsWith(title,".jpg")){		//compare the end of the String title with the expression ".jpg"
	showMessage("You opened an image with a lossy compression format");
}

