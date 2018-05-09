# A-Guided-Tour-of-R
A self-paced version of an introductory R workshop taught at SPSP 2018. Will probably take 4-10 hours to work through, depending on experience and pacing. 

### Format
The PDF in this directory contains a copy of the slides used to present the concepts in this workshop live and may be useful to get an overview, but all necessary detail is contained in instructions within the .R files themselves. In order to work through these files, just follow the setup instructions below. 

### Setup
In order to work through the exercises and intructions, you'll first need to go through a few quick steps.

1. First off, you'll need to install R and RStudio. Instructions on how to do this can be found [here](https://www.ics.uci.edu/~jutts/110/InstallingRandRStudio.pdf).

2. Next, you'll need to install a few packages (basically R addons) that we'll be working with in the workshop. To do so, open RStudio (just double-click the icon), and then paste the below line of code into the window that says 'Console', then hit Enter. 

  install.packages(c("tidyverse", "gapminder"))

Ideally, you should see a series of 'downloading' messages, followed by a completion message. To check if this has worked, you can paste the following line into the console:

  library(tidyverse)

If you see an 'Attaching packages' message, everything has worked (don't worry about the Conflicts message). 

  3. Download this repository to your local computer to work on. To do this, click 'Clone or Download' then 'Download Zip', on this page. One that's done, you'll need to unzip the downloaded file into a folder. Once that's done, you're good to go - Open Workshop code 1. Introduction.R (in RStudio) and get started!
