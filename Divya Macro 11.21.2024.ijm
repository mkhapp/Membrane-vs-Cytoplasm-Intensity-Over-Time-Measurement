//initial inputs
run("Set Measurements...", "mean redirect=None decimal=3");
run("Input/Output...", "jpeg=85 gif=-1 file=.csv use use_file save_column save_row");
roiManager("reset");
run("Select None");
run("Clear Results");
a = 1;

//make sure the image is correct
while (nImages > 1) {
	waitForUser("Please close extraneous images.");
}

while (nImages == 0) {
	waitForUser("Please open your image.");
}

getDimensions(width, height, channels, slices, frames);
while (channels > 1) {
	waitForUser("Please ensure there is only one channel in your image.");
	getDimensions(width, height, channels, slices, frames);
}

while (nImages > 1) {
	waitForUser("Please close extraneous images.");
}

while (nImages == 0) {
	waitForUser("Please open your image.");
}

getDimensions(width, height, channels, slices, frames);
while (channels > 1) {
	waitForUser("Please ensure there is only one channel in your image.");
	getDimensions(width, height, channels, slices, frames);
}

//get background value
do {
	setTool("multipoint");
	run("Select None");
	waitForUser("Place a single point in a background area.");
	getSelectionBounds(x, y, width, height);
	} while (width > 1);

makeOval(x-8, y-8, 16, 16);
roiManager("add");
setSlice(1);
roiManager("multi measure");
result = Table.getColumn("Mean1", "Results");
background = 0;
for (i = 0; i < result.length; i++) {
	background = background + result[i];
}
background = background / result.length;

//calculate fold change cytoplasm over time with background subtraction
while (a == 1) {
	roiManager("reset");
	run("Select None");
	run("Clear Results");
	do {
		setTool("multipoint");
		run("Select None");
		waitForUser("Place a single point in the center of your cell of interest.");
		getSelectionBounds(x, y, width, height);
	} while (width > 1);
	makeOval(x-8, y-8, 16, 16);
	roiManager("add");
	setSlice(1);
	roiManager("multi measure");
	
	//background subtraction
	result = Table.getColumn("Mean1", "Results");
	for (i = 0; i < result.length; i++) {
		result[i] = result[i] - background;
	}
		
	//normalization
	norm = result[0];
	for (i = 0; i < result.length; i++) {
		result[i] = result[i]/norm;
	}
	
	//log fold change
	//for (i = 0; i < result.length; i++) {
	//	result[i] = log(result[i]);
	//}
	Table.setColumn("Mean1", result, "Results");
	
	//save and flow
	String.copyResults;
	waitForUser("Measurement taken. Press okay when ready.");
	Dialog.create("");
	Dialog.addMessage("Another Cell?");
	Dialog.addRadioButtonGroup("", newArray("  Yes  ","  No  "), 1, 2, "");
	Dialog.show();
	answer = Dialog.getRadioButton();
	if (answer == "  Yes  ") {
		a = 1;
	} else {
		a = 2;
	}
}

