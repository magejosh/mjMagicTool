import os
import subprocess

# Change the current working directory to /workspace/stable-diffusion-webui/scripts
# Check if this is running on runpod
on_runpod = input("Is this running on runpod? (y/n): ").lower()

if on_runpod == 'y':
    path = '/workspace/stable-diffusion-webui/scripts'
else:
    path = input("Please input the path to the 'webui/scripts' folder: ")

os.chdir(path)

# Check if txt2img2img.py already exists in the current working directory
if not os.path.isfile('txt2img2img.py'):
    # Prompt the user to install txt2img2img.py
    install_response = input("Do you want to install the txt2img2img script? (Y/N): ")

    # If the user wants to install txt2img2img.py, clone the repository
    if install_response.upper() == 'Y':
        try:
            subprocess.run(['git', 'clone', '--depth', '1', '--single-branch', 'https://github.com/ThereforeGames/txt2img2img', path])
        except Exception as e:
            print(f'Error while installing txt2img2img: {e}')
            pass
    # If the user does not want to install txt2img2img.py or entered an invalid response, skip the installation
    elif install_response.upper() != 'N':
        print("Invalid response. Skipping txt2img2img installation.")


# Check if improved_prompt_matrix.py already exists in the current working directory
if not os.path.isfile('improved_prompt_matrix.py'):
    # Prompt the user to install improved_prompt_matrix.py
    install_response = input("Do you want to install the improved_prompt_matrix script? (Y/N): ")

    # If the user wants to install improved_prompt_matrix.py, clone the repository
    if install_response.upper() == 'Y':
        try:
            subprocess.run(['git', 'clone', '--depth', '1', '--single-branch', 'https://github.com/ArrowM/auto1111-improved-prompt-matrix/blob/main/improved_prompt_matrix.py', path])
        except Exception as e:
            print(f'Error while installing improved_prompt_matrix: {e}')
            pass
    # If the user does not want to install improved_prompt_matrix.py or entered an invalid response, skip the installation
    elif install_response.upper() != 'N':
        print("Invalid response. Skipping improved_prompt_matrix installation.")

# Check if txt2img2img.py already exists in the current working directory
if not os.path.isfile('txt2img2img.py'):
    # Prompt the user to install txt2img2img.py
    install_response = input("Do you want to install the txt2img2img script? (Y/N): ")

    # If the user wants to install txt2img2img.py, clone the repository
    if install_response.upper() == 'Y':
        try:
            subprocess.run(['git', 'clone', '--depth', '1', '--single-branch', 'https://github.com/ThereforeGames/txt2img2img', path])
        except Exception as e:
            print(f'Error while installing txt2img2img: {e}')
            pass
    # If the user does not want to install txt2img2img.py or entered an invalid response, skip the installation
    elif install_response.upper() != 'N':
        print("Invalid response. Skipping txt2img2img installation.")


# Check if txt2img2img.py already exists in the current working directory
if not os.path.isfile('txt2img2img.py'):
    # Prompt the user to install txt2img2img.py
    install_response = input("Do you want to install the txt2img2img script? (Y/N): ")

    # If the user wants to install txt2img2img.py, clone the repository
    if install_response.upper() == 'Y':
        try:
            subprocess.run(['git', 'clone', '--depth', '1', '--single-branch', 'https://github.com/ThereforeGames/txt2img2img', path])
        except Exception as e:
            print(f'Error while installing txt2img2img: {e}')
            pass
    # If the user does not want to install txt2img2img.py or entered an invalid response, skip the installation
    elif install_response.upper() != 'N':
        print("Invalid response. Skipping txt2img2img installation.")


# Check if txt2img2img.py already exists in the current working directory
if not os.path.isfile('txt2img2img.py'):
    # Prompt the user to install txt2img2img.py
    install_response = input("Do you want to install the txt2img2img script? (Y/N): ")

    # If the user wants to install txt2img2img.py, clone the repository
    if install_response.upper() == 'Y':
        try:
            subprocess.run(['git', 'clone', '--depth', '1', '--single-branch', 'https://github.com/ThereforeGames/txt2img2img', path])
        except Exception as e:
            print(f'Error while installing txt2img2img: {e}')
            pass
    # If the user does not want to install txt2img2img.py or entered an invalid response, skip the installation
    elif install_response.upper() != 'N':
        print("Invalid response. Skipping txt2img2img installation.")



