# google_timeline_maps
Mapping Google Timeline data with Processing 2 & the Unfolding library

_*INCOMPLETE: PUSHED TO START TO PREVIEW HOW THINGS LOOK.*_

While this started out as a very hacky personal project to map my own data, once I shared [some of my visualizations](https://www.instagram.com/p/Bsl9pEoH_rf/) I started getting requests from friends wanting to make their own. While it's still hacky, this is a rough first pass at streamlining my workflow for more general use. I've listed a few ideas for future development at the bottom of this page. Feel free to use [https://github.com/bdharva/google_timeline_maps/issues](https://github.com/bdharva/google_timeline_maps/issues) to suggest additional updates and flag any bugs you encounter.

![Sample visualization](data/assets/hero.png?raw=true)

## Setup

_Note: These directions are for Mac OS X users. If you're using Windows or Linux, you'll be following a similar process, but will need to reference OS-specific directions at each of the websites indicated below._

### Install Processing 2

To utilize the Unfolding maps library, you'll need to be running Processing 2 (not 3). If you don't already have it installed, go to [https://processing.org/download/](https://processing.org/download/) and scroll down to "Stable Releases". Click the OS-appropriate download link for version 2.2.1. Unzip the archive and move the extracted "Processing" application to your "Applications" folder.

### Install Unfolding library

Go to [http://unfoldingmaps.org/](http://unfoldingmaps.org/) and click the "For Processing 2" button under "Download". Unzip the archive and put the extracted "Unfolding" folder into the `libraries` folder of your Processing directory. By default, the Processing directory will be at `User/Documents/Processing`. If this is your first library, you'll need to create a `libraries` directory within it.

### Clone project repository

Go to [https://github.com/bdharva/google_timeline_maps](https://github.com/bdharva/google_timeline_maps) and select "Download ZIP" in the pop-up dialogue initiated by the green "Clone or Download" button. Unzip the archive and move the extracted "google_timeline_maps" folder into your Processing directory.

Alternately, in Terminal, you can navigate to your Processing directory and execute `git clone https://github.com/bdharva/google_timeline_maps.git` to create a local clone of the repository.

### Download Google Timeline data

Access your Google Takeout at [https://takeout.google.com/settings/takeout](https://takeout.google.com/settings/takeout). De-select everything except "Location History". Be sure that the "JSON format" option is selected. Follow the remaining steps to create and download your archive. Once downloaded, unzip the archive and move the extracted `Location History.json` file to the sketch directory `.../google_timeline_maps/data/google`.

## Map Your Data

### Launch the sketch

Open the `google_timeline_maps.pde` sketch in Processing 2 and launch the sketch with `cmd + r` or by pressing the play icon in the user interface.

### Configuring settings

### Creating views

### Map navigation

### Plot data

## Development Notes

*	__Words__ -- More words.
