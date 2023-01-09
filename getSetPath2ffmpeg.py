import os
import subprocess

# Check if the training-picker extension's README file exists
if os.path.isfile('/workspace/stable-diffusion-webui/extensions/training-picker/README.md'):
    # Install ffmpeg
    try:
        subprocess.run(['apt-get', 'install', 'ffmpeg'])
    except Exception as e:
        print(f'Error while installing ffmpeg: {e}')
        pass

    # Add ffmpeg to the PATH environment variable
    try:
        with open('/etc/environment', 'a') as f:
            f.write('\nPATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/ffmpeg/bin"')
    except Exception as e:
        print(f'Error while modifying /etc/environment: {e}')
        pass
    
    # Add ffmpeg to the requirements.txt file
    try:
        with open('/workspace/stable-diffusion-webui/requirements.txt', 'a') as f:
            f.write('ffmpeg')
    except Exception as e:
        print(f'Error while modifying /workspace/stable-diffusion-webui/requirements.txt: {e}')
        pass
