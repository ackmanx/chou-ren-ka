### Intro
I want to look at Quizlet flashcards using my TV. I have a Roku. Problem solved.

### To Run
* Being this is not on the Roku Store, you have to side-load it as a dev app. See "To Develop"'s Roku section

### To Develop
* Atom
  * For main development because it has deployment plugins
  * atom-beautify to autoformat XML
  * autosave-onchange because I'm used to how IntelliJ saves files
  * git-plus to enable gutter icons for git changes
  * language-brightscript so you can have syntax highlighting
  * roku-deploy will auto-zip current project and send to Roku with a single hotkey

* IntelliJ
  * For better diffing when looking at what I'm going to commit
  * To occassionally fix atom-beautify poor formatting choices
  * I created a new .brs File Type in settings to enable basic syntax highlighting based on keywords

* Roku
  * Enable Developer Mode
  * Note the IP address and supply to roku-deploy preferences in Atom
  * From Atom menu bar: Packages -> roku-deploy -> Deploy

### To debug
You have to open a terminal and telnet to Roku. The docs have instructions.
https://sdkdocs.roku.com/display/sdkdoc/Debugging+Your+Application

`print` statements in BrightScript will output to the telnet session
