### Intro
I want to look at Quizlet flashcards using my TV. I have a Roku. Problem solved.

### To Run
* Being this is not on the Roku Store, you have to side-load it as a dev app. See "To Develop"'s Roku section

### To Develop
* Atom
  * Option 1 for main development if you use plugins below
  * atom-beautify to autoformat XML
  * autosave-onchange because I'm used to how IntelliJ saves files
  * git-plus to enable gutter icons for git changes
  * language-brightscript so you can have syntax highlighting
  * roku-deploy will auto-zip current project and send to Roku with a single hotkey

* IntelliJ
  * Option 2 for main development if you create new File Type below
  * For better diffing when looking at what I'm going to commit
  * To occassionally fix atom-beautify poor formatting choices
  * I created a new .brs File Type in settings to enable basic syntax highlighting based on keywords

* Atom and IntelliJ
  * I like use to IntelliJ for everything except deploys because I don't know how
  * So I keep Atom open just to go to, hit deploy shortcut, then go back to IntelliJ

* Roku
  * Enable Developer Mode
  * Note the IP address and supply to roku-deploy preferences in Atom
  * From Atom menu bar: Packages -> roku-deploy -> Deploy

### To debug
You have to open a terminal and telnet to Roku. The docs have instructions.
https://sdkdocs.roku.com/display/sdkdoc/Debugging+Your+Application

`print` statements in BrightScript will output to the telnet session

### Misc

Font files are from Google's Noto font: https://www.google.com/get/noto/#sans-hans

This was designed specifically for a 1920-1080 experience. Smaller resolutions may look bad due to dynamic font sizing.
