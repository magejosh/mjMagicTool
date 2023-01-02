import os,subprocess
venv_dir = os.path.join("/workspace/mjMagicTool", "venv")
subprocess.run(["python3", "-m", "venv", venv_dir])
activate_path = os.path.join(venv_dir, "bin", "activate_this.py")
exec(open(activate_path).read(), dict(__file__=activate_path))
!pip install os gdown datetime zipfile
import gdown,datetime,zipfile
while True:
    if input("Are you ready to import a training data zip file from Google Drive (URL must be set to share with anyone with the link)? (Y/N)").lower() == "y":
        date = datetime.datetime.now().strftime("%Y-%m-%d")
        subdir = os.path.join("/workspace/stable-diffusion-webui/inputs", date)
        os.makedirs(subdir, exist_ok=True)
        zip_name = input("Name for zip file (no .zip): ")
        zip_path = os.path.join(subdir, zip_name + ".zip")
        gdown.download(input("URL for zip file: "), zip_path, quiet=False)
        unzip_dir = os.path.join(subdir, zip_name)
        os.makedirs(unzip_dir, exist_ok=True)
        with zipfile.ZipFile(zip_path, "r") as zip_ref:
            zip_ref.extractall(unzip_dir)
        print("Import complete! Do you want to import another Training set .zip file? (Y/N)")
        if input().lower() == "n":
            break
deactivate_path = os.path.join(venv_dir, "bin", "deactivate_this.py")
exec(open(deactivate_path).read(), dict(__file__=deactivate_path))
        with zipfile.ZipFile(zip_path, "r") as zip_ref:
            zip_ref.extractall(unzip_dir)
        print("Import complete! Do you want to import another Training set .zip file? (Y/N)")
        if input().lower() == "n":
            break

# Deactivate the virtual environment
deactivate_path = os.path.join(venv_dir, "bin", "deactivate_this.py")
exec(open(deactivate_path).read(), dict(__file__=deactivate_path))
