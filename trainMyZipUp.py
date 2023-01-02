import os
import subprocess

# Create a Python virtual environment in the mjMagicTool directory
subprocess.run(["python3", "-m", "venv", os.path.join("/workspace/mjMagicTool", "venv")])

# Activate the virtual environment
activate_this_path = os.path.join(os.path.join("/workspace/mjMagicTool", "venv"), "bin", "activate_this.py")
with open(activate_this_path, "r") as f:
    exec(f.read(), dict(__file__=activate_this_path))

# Install the necessary packages
subprocess.run(["pip", "install", "os", "gdown", "datetime", "zipfile"])

import gdown
import datetime
import zipfile

while True:
    # Prompt the user to import a training data zip file from Google Drive
    ready = input("Are you ready to import a training data zip file from Google Drive (URL must be set to share with anyone with the link)? (Y/N)").lower()
    if ready == "y":
        # Get the current date and create a subdirectory for the zip file
        date = datetime.datetime.now().strftime("%Y-%m-%d")
        subdir = os.path.join("/workspace/stable-diffusion-webui/inputs", date)
        os.makedirs(subdir, exist_ok=True)

        # Prompt the user for a name for the zip file
        zip_name = input("Name for zip file (no .zip): ")
        zip_path = os.path.join(subdir, zip_name + ".zip")

        # Prompt the user for the URL of the zip file
        zip_url = input("URL for zip file: ")

        # Download the zip file
        gdown.download(zip_url, zip_path, quiet=False)

        # Create a directory to unzip the file into
        unzip_dir = os.path.join(subdir, zip_name)
        os.makedirs(unzip_dir, exist_ok=True)

        # Unzip the file
        with zipfile.ZipFile(zip_path, "r") as zip_ref:
            zip_ref.extractall(unzip_dir)

        # Prompt the user to import another zip file
        another = input("Import complete! Do you want to import another Training set .zip file? (Y/N)").lower()
        if another == "n":
            break

# Deactivate the virtual environment
deactivate_this_path = os.path.join(os.path.join("/workspace/mjMagicTool", "venv"), "bin", "deactivate_this.py")
with open(deactivate_this_path, "r") as f:
    exec(f.read(), dict(__file__=deactivate_this_path))
