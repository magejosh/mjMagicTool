# Runpod Stable Diffusion automatic1111SD2.1 Template Customizer Script Tool (mjMagicTool) 

A custom script set customization tool designed for use on a Runpod [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) Pod Template for SDv2.1. The tool is accessible through the Jupyter Notebook terminal, allows for efficient and rapid customization and multiconfigurable setup, including automation of downloading desired models/extensions/vae/scripts/embeddings/and hypernetworks as well as wrapping up by passing off to a script for the import of training data from a Google Drive link set to share with anyone of a .zip file with your desired training date zipped up inside it which it will then download and unzip into.


<img src="https://i.imgur.com/YsbKHg1.gif"/>


## Installation

This set of scripts is not meant to be installed into Automatic1111's webui or add any functionality to it directly, at least in it's current form. As such the root /workspace path works just fine for this installation if you plan to install it manually, but it should be installable from any directory in one copy pasted command into a jupyter notebook terminal on your runpod as well by just using the line from the installation section below.

<img src="images/installation.png"/>

The idea is you will simply start up a runpod instance with enough disk space and ram/gpu for your needs and wait for it to finish starting up. Make sure you select the automatic1111 SD 2.1 template as that is what this script set is developed to use with. Once it's running, open the jupyter notebook so you can see the files and open a terminal. Once it's open run the following command:

	git clone https://github.com/user/repo /workspace/mjMagicTool && cd /workspace/mjMagicTool && bash script.sh


<video src="https://i.imgur.com/v6dFs83.mp4" controls></video>


## Customization Script

This script is the one that auto runs in the combo install and run command from the install instructions above. It first downloads a few tools it needs to perform it's tasks. Then it asks the user for their HuggingFace Token, as this will be needed if to download some models. If they do not intend to download the official SD models then a fake Token should work fine as far as this script is concerned. Regardless of what the user enters for that token, by the time the last prompt runs in this script it has already destroyed the copy of the token it was holding. You can check the code yourself, no copy is stored anywhere but in the script while you run it, and before the last command can run I added a command to overwrite the user provided token with the original placeholder token with the goal of ensuring that a user's token is never left insecurely stored somewhere. 
Moving along, then it begins a seriest of prompts to determine if you want to install things, and if the things you want to install have dependencies that are not setup to autoinstall when you restart the webui then the script will download them and where applicable add them to the requirements.txt of the a1111 webui root folder. The order of operations for prompts is large model groups first, followed by older or smaller or individual model sets. After that is Extensions, then Scripts, then Hypernetworks, however VAE models detect if their partner models are installed and install themselves if so, then textual inversion embeddings for use with SD2.X models are all automatically downloaded and installed since they are very small and only matter if used. More embeddings are planned sorted by base model set they work with, as well as making groups of them to prompt the user if they want to use or not. Once all the embeddings are downloaded and installed the script has one final prompt for the user, it asks if they want to import training data and if Y it runs the trainMyZipUp.py script to execute that task.  

## trainMyZipUp.py Script

This script is designed to ask the player if they are ready to download a .zip from Google Drive link set to share with anyone. If no the script ends, if yes it will ask the user for a name for the .zip file as well, and I recommend using the name you intend to use for the embedding trigger. The script will download the file from the gdrive link provided by the user, name it the name provided by the user, store it in a folder named the same as the user provided .zip file. That folder is created inside the root stable-diffusion-webui/inputs pathway. Once the zip has been downloaded and named inside the named input/namedFolder the zip file will have it's contents extracted into that folder so they are ready to be input as training data. 


## Contributing
If you're interested in contributing to the development of this tool, here are some features I would like to implement:

1. **Saved templates** - Basically a set of preanswered commands of models/extensions/scripts/vae/hypernetworks/embeddings/etc. that work well together for different workflows. Make each one it's own script and list the command to run it for now. Would be cool to have an option at the end of the script to export it under a user supplied name as a script template that copies the original script and replaces the prompts with the answers the user gave during the run of the original setup script. That way they can save that exported script and the next time they startup a pod upload it and use it instead of the main script from the tool. They will still need the tool installed on that instance though i believe. 

2. **Improved customization management**. The script currently only operates within the terminal through a series of Y/N responses that could be optimized to reduce total required responses from a user who only wants a few things or who wants most/all things.

3. **Improved UI**. The current UX of the jupyter notebook terminal works, but adding a webui integration for the tool to be usable as a tab extension inside a1111 regardless of install environment would be ideal as long as it doesn't break the use of the tool via the terminal.

<img src="https://i.imgur.com/5DLTSxj.gif"/>
Let me know if there is anything you would be interested in looking into.
