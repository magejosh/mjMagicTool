import os
import subprocess
import sys

# Check if sed is available
try:
    result = subprocess.run(['which', 'sed'], capture_output=True, text=True).stdout
except Exception as e:
    print(f'Error while checking for sed: {e}')
    pass

# If sed is not available, install it
if not result:
    try:
        subprocess.run(['apt-get', 'install', '-y', 'sed'])
    except Exception as e:
        print(f'Error while installing sed: {e}')
        pass

# extensions = below is expanded format for adding to the string below it, but the condensed format was easier for me to use. just add more to the end of the string for anything else or do the proper git thing to ask me to add one you think is missing or if you have issues on a particular build we could add an autofix for let me know.
# extensions = [
#     {
#         'name': 'sd-dynamic-prompts',
#         'url': 'https://github.com/adieyal/sd-dynamic-prompts',
#         'install_path': '/workspace/stable-diffusion-webui/extensions/sd-dynamic-prompts',
#         'install_script': '/workspace/stable-diffusion-webui/extensions/sd-dynamic-prompts/install.py',
#     },
#     {
#         'name': 'ABG_extension',
#         'url': 'https://github.com/KutsuyaYuki/ABG_extension',
#         'install_path': '/workspace/stable-diffusion-webui/extensions/ABG_extension',
#         'install_script': '/workspace/stable-diffusion-webui/extensions/ABG_extension/install.py',
#     },
#     {
#         'name': 'Config-Presets',
#         'url': 'https://github.com/Zyin055/Config-Presets',
#         'install_path': '/workspace/stable-diffusion-webui/extensions/Config-Presets',
#         'install_script': '/workspace/stable-diffusion-webui/extensions/Config-Presets/install.py',
#     }
# ]

extensions = [    {        'name': 'sd-dynamic-prompts',        'url': 'https://github.com/adieyal/sd-dynamic-prompts',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd-dynamic-prompts',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd-dynamic-prompts/install.py',    },    {        'name': 'ABG_extension',        'url': 'https://github.com/KutsuyaYuki/ABG_extension',        'install_path': '/workspace/stable-diffusion-webui/extensions/ABG_extension',        'install_script': '/workspace/stable-diffusion-webui/extensions/ABG_extension/install.py',    },    {        'name': 'Config-Presets',        'url': 'https://github.com/Zyin055/Config-Presets',        'install_path': '/workspace/stable-diffusion-webui/extensions/Config-Presets',        'install_script': '/workspace/stable-diffusion-webui/extensions/Config-Presets/install.py',    },    {        'name': 'DreamArtist-sd-webui-extension',        'url': 'https://github.com/7eu7d7/DreamArtist-sd-webui-extension',        'install_path': '/workspace/stable-diffusion-webui/extensions/DreamArtist-sd-webui-extension',        'install_script': '/workspace/stable-diffusion-webui/extensions/DreamArtist-sd-webui-extension/install.py',    },    {        'name': 'SD-latent-mirroring',        'url': 'https://github.com/dfaker/SD-latent-mirroring',        'install_path': '/workspace/stable-diffusion-webui/extensions/SD-latent-mirroring',        'install_script': '/workspace/stable-diffusion-webui/extensions/SD-latent-mirroring/install.py',    },    {        'name': 'StylePile',        'url': 'https://github.com/some9000/StylePile',        'install_path': '/workspace/stable-diffusion-webui/extensions/StylePile',        'install_script': '/workspace/stable-diffusion-webui/extensions/StylePile/README.md',    },    {        'name': 'deforum',        'url': 'https://github.com/deforum-art/deforum-for-automatic1111-webui/',        'install_path': '/workspace/stable-diffusion-webui/extensions/deforum',        'install_script': '/workspace/stable-diffusion-webui/extensions/deforum/README.md',    },    {        'name': 'depthmap2mask',        'url': 'https://github.com/Extraltodeus/depthmap2mask',        'install_path': '/workspace/stable-diffusion-webui/extensions/depthmap2mask',        'install_script': '/workspace/stable-diffusion-webui/extensions/depthmap2mask/install.py',    },    {        'name': 'multi-subject-render',        'url': 'https://github.com/7eu7d7/DreamArtist-sd-webui-extension',        'install_path': '/workspace/stable-diffusion-webui/extensions/multi-subject-render',        'install_script': '/workspace/stable-diffusion-webui/extensions/multi-subject-render/install.py',    },    {        'name': 'sd-webui-riffusion',        'url': 'https://github.com/enlyth/sd-webui-riffusion',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd-webui-riffusion',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd-webui-riffusion/install.py',    },    {        'name': 'sd_auto_fix',        'url': 'https://github.com/d8ahazard/sd_auto_fix',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd_auto_fix',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd_auto_fix/README.md',    },    {        'name': 'sd_dreambooth_extension',        'url': 'https://github.com/d8ahazard/sd_dreambooth_extension',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd_dreambooth_extension',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd_dreambooth_extension/install.py',    },    {        'name': 'sd_save_intermediate_images',        'url': 'https://github.com/AlUlkesh/sd_save_intermediate_images',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd_save_intermediate_images',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd_save_intermediate_images/README.md',    },    {        'name': 'sd_smartprocess',        'url': 'https://github.com/d8ahazard/sd_smartprocess',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd_smartprocess',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd_smartprocess/install.py',    },    {        'name': 'sd_web_ui_preset_utils',        'url': 'https://github.com/Gerschel/sd_web_ui_preset_utils',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd_web_ui_preset_utils',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd_web_ui_preset_utils/README.md',    },    {        'name': 'stable-diffusion-webui-aesthetic-image-scorer',        'url': 'https://github.com/tsngo/stable-diffusion-webui-aesthetic-image-scorer',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-aesthetic-image-scorer',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-aesthetic-image-scorer/README.md',    },    {        'name': 'stable-diffusion-webui-conditioning-highres-fix',        'url': 'https://github.com/klimaleksus/stable-diffusion-webui-conditioning-highres-fix',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-conditioning-highres-fix',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-conditioning-highres-fix/README.md',    },    {        'name': 'stable-diffusion-webui-daam',        'url': 'https://github.com/kousw/stable-diffusion-webui-daam',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-daam',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-daam/install.py',    },    {        'name': 'stable-diffusion-webui-depthmap-script',        'url': 'https://github.com/thygate/stable-diffusion-webui-depthmap-script',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-depthmap-script',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-depthmap-script/install.py',    },    {        'name': 'stable-diffusion-webui-images-browser',        'url': 'https://github.com/yfszzx/stable-diffusion-webui-images-browser',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser/README.md',    },    {        'name': 'stable-diffusion-webui-inspiration',        'url': 'https://github.com/d8ahazard/stable-diffusion-webui-images-browser',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-inspiration',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-inspiration/README.md',    },    {        'name': 'stable-diffusion-webui-randomize',        'url': 'https://github.com/stysmmaker/stable-diffusion-webui-randomize',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-randomize',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-randomize/README.md',    },    {        'name': 'stable-diffusion-webui-tokenizer',        'url': 'https://github.com/AUTOMATIC1111/stable-diffusion-webui-tokenizer',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-tokenizer',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-tokenizer/README.md',    },    {        'name': 'stable-diffusion-webui-visualize-cross-attention-extension',        'url': 'https://github.com/benkyoujouzu/stable-diffusion-webui-visualize-cross-attention-extension',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-visualize-cross-attention-extension',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-visualize-cross-attention-extension/install.py',    },    {        'name': 'stable-diffusion-webui-embedding-editor',        'url': 'https://github.com/CodeExplode/stable-diffusion-webui-embedding-editor',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-embedding-editor',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-embedding-editor/README.md',    },    {        'name': 'stable-diffusion-webui-artists-to-study',        'url': 'https://github.com/camenduru/stable-diffusion-webui-artists-to-study',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-artists-to-study',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-artists-to-study/README.md',    },    {        'name': 'stable-diffusion-webui-dataset-tag-editor',        'url': 'https://github.com/toshiaki1729/stable-diffusion-webui-dataset-tag-editor',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-dataset-tag-editor',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-dataset-tag-editor/install.py',    },    {        'name': 'training-picker',        'url': 'https://github.com/Maurdekye/training-picker',        'install_path': '/workspace/stable-diffusion-webui/extensions/training-picker',        'install_script': '/workspace/stable-diffusion-webui/extensions/training-picker/README.md',    },    {        'name': 'embedding-inspector',        'url': 'https://github.com/tkalayci71/embedding-inspector',        'install_path': '/workspace/stable-diffusion-webui/extensions/embedding-inspector',        'install_script': '/workspace/stable-diffusion-webui/extensions/embedding-inspector/README.md',    },    {        'name': 'ddetailer',        'url': 'https://github.com/dustysys/ddetailer',        'install_path': '/workspace/stable-diffusion-webui/extensions/ddetailer',        'install_script': '/workspace/stable-diffusion-webui/extensions/ddetailer/README.md',    },    {        'name': 'sdweb-merge-board',        'url': 'https://github.com/bbc-mc/sdweb-merge-board',        'install_path': '/workspace/stable-diffusion-webui/extensions/sdweb-merge-board',        'install_script': '/workspace/stable-diffusion-webui/extensions/sdweb-merge-board/install.py',    },    {        'name': 'Prompt Gallery',        'url': 'https://github.com/dr413677671/PromptGallery-stable-diffusion-webui',        'install_path': '/workspace/stable-diffusion-webui/extensions/Prompt Gallery',        'install_script': '/workspace/stable-diffusion-webui/extensions/Prompt Gallery/install.py',    },    {        'name': 'stable-diffusion-webui-Prompt_Generator',        'url': 'https://github.com/imrayya/stable-diffusion-webui-Prompt_Generator',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-Prompt_Generator',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-Prompt_Generator/README.md',    },    {        'name': 'sd-web-ui-quickcss',        'url': 'https://github.com/Gerschel/sd-web-ui-quickcss',        'install_path': '/workspace/stable-diffusion-webui/extensions/sd-web-ui-quickcss',        'install_script': '/workspace/stable-diffusion-webui/extensions/sd-web-ui-quickcss/README.md',    },    {        'name': 'model-keyword',        'url': 'https://github.com/mix1009/model-keyword',        'install_path': '/workspace/stable-diffusion-webui/extensions/model-keyword',        'install_script': '/workspace/stable-diffusion-webui/extensions/model-keyword/README.md',    },    {        'name': 'enhanced-img2img',        'url': 'https://github.com/OedoSoldier/enhanced-img2img',        'install_path': '/workspace/stable-diffusion-webui/extensions/enhanced-img2img',        'install_script': '/workspace/stable-diffusion-webui/extensions/enhanced-img2img/README.md',    },    {        'name': 'aesthetic-gradients',        'url': 'https://github.com/AUTOMATIC1111/stable-diffusion-webui-aesthetic-gradients',        'install_path': '/workspace/stable-diffusion-webui/extensions/aesthetic-gradients',        'install_script': '/workspace/stable-diffusion-webui/extensions/aesthetic-gradients/README.md',    },    {        'name': 'wildcards',        'url': 'https://github.com/AUTOMATIC1111/stable-diffusion-webui-wildcards',        'install_path': '/workspace/stable-diffusion-webui/extensions/wildcards',        'install_script': '/workspace/stable-diffusion-webui/extensions/wildcards/README.md',    },    {        'name': 'Hypernetwork-MonkeyPatch-Extension',        'url': 'https://github.com/aria1th/Hypernetwork-MonkeyPatch-Extension',        'install_path': '/workspace/stable-diffusion-webui/extensions/Hypernetwork-MonkeyPatch-Extension',        'install_script': '/workspace/stable-diffusion-webui/extensions/Hypernetwork-MonkeyPatch-Extension/README.md',    },    {        'name': 'a1111-sd-webui-tagcomplete',        'url': 'https://github.com/DominikDoom/a1111-sd-webui-tagcomplete.git',        'install_path': '/workspace/stable-diffusion-webui/extensions/a1111-sd-webui-tagcomplete',        'install_script': '/workspace/stable-diffusion-webui/extensions/a1111-sd-webui-tagcomplete/install.py',    },    {        'name': 'unprompted',        'url': 'https://github.com/ThereforeGames/unprompted.git',        'install_path': '/workspace/stable-diffusion-webui/extensions/unprompted',        'install_script': '/workspace/stable-diffusion-webui/extensions/unprompted/README.md',    },    {        'name': 'stable-diffusion-webui-sonar',        'url': 'https://github.com/Kahsolt/stable-diffusion-webui-sonar.git',        'install_path': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-sonar',        'install_script': '/workspace/stable-diffusion-webui/extensions/stable-diffusion-webui-sonar/README.md',    },    {        'name': 'var2gif',        'url': 'https://github.com/diaphragm/var2gif.git',        'install_path': '/workspace/stable-diffusion-webui/extensions/var2gif',        'install_script': '/workspace/stable-diffusion-webui/extensions/var2gif/README.md',    }]


# Change to the extensions directory
# os.chdir('/workspace/stable-diffusion-webui/extensions')

# Check if this is running on runpod
# on_runpod = input("Is this running on runpod? (y/n): ").lower()

# if on_runpod == 'y':
    # path = '/workspace/stable-diffusion-webui/extensions'
# else:
    # path = input("Please input the path to the 'webui/extensions' folder: ")

# os.chdir(path)
on_runpod = input("Is this running on runpod? (y/n): ")
if on_runpod == "":
    on_runpod = "n"
else:
    on_runpod = on_runpod.lower()
if on_runpod == 'y':
    path = '/workspace/stable-diffusion-webui/extensions'
elif on_runpod == 'n':
    path = input("Please input the path to the 'webui/extensions' folder: ")
else:
    print("Please enter 'y' or 'n'")
    on_runpod = input("Is this running on runpod? (y/n): ").lower() or "n"
    if on_runpod == 'y':
        path = '/workspace/stable-diffusion-webui/extensions'
    elif on_runpod == 'n':
        path = input("Please input the path to the 'webui/extensions' folder: ")
    else:
        # If the user still enters an invalid response, we will use the default path
        path = '/workspace/stable-diffusion-webui/extensions'

os.chdir(path)


# contingency effects based on extension dependencies
sd_dynamic_prompts_installed = False

for extension in extensions:
    name = extension['name']
    url = extension['url']
    install_path = extension['install_path']
    install_script = extension['install_script']

    # Check if the extension is already installed
    if os.path.isfile(install_script):
        print(f'{name} is already installed, skipping')
        if name == 'sd-dynamic-prompts':
            sd_dynamic_prompts_installed = True
        continue

    # Ask the user if they want to install the extension
    install_prompt = f'Do you want to install the {name} extension? (Y/N): '
    install_response = input(install_prompt)

    if install_response.upper() == 'Y':
        # The user wants to install the extension, so we clone it
        try:
            subprocess.run(['git', 'clone', url, install_path])
        except Exception as e:
            print(f'Error while installing {name}: {e}')
            pass
        else:
            if name == 'sd-dynamic-prompts':
                sd_dynamic_prompts_installed = True
    elif install_response.upper() == 'N':
        # The user does not want to install the extension, so we skip it
        print(f'Skipping {name} installation')
    else:
        # The user entered an invalid response, so we ask again
        for i in range(2):
            install_response = input(install_prompt)
            if install_response.upper() == 'Y':
                try:
                    subprocess.run(['git', 'clone', url, install_path])
                except Exception as e:
                    print(f'Error while installing {name}: {e}')
                    pass
                else:
                    if name == 'sd-dynamic-prompts':
                        sd_dynamic_prompts_installed = True
                    break
            elif install_response.upper() == 'N':
                print(f'Skipping {name} installation')
                break
        else:
            # The user entered an invalid response twice, so we skip the extension
            print(f'Skipping {name} installation')


# The following line checks to see that the Extension from the previous line was installed or not, if it was, it then runs the wildcardDir.py before continuing
if sd_dynamic_prompts_installed:
    try:
        subprocess.run(['/workspace/mjMagicTool/wildcardDir.py'], wait=True)
    except Exception as e:
        print(f'Error while running wildcardDir.py: {e}')
        pass


# Check if the training-picker extension's README file exists
if os.path.isfile('/workspace/stable-diffusion-webui/extensions/training-picker/README.md'):
    # Check if ffmpeg is in the PATH environment variable
    with open('/etc/environment', 'r') as f:
        if 'ffmpeg' not in f.read():
            # Run the getSetPath2ffmpeg.py file and wait for it to finish
            try:
                subprocess.run(['/workspace/mjMagicTool/getSetPath2ffmpeg.py'], wait=True)
            except Exception as e:
                print(f'Error while running getSetPath2ffmpeg.py: {e}')
                pass

# Continue with the rest of the script
# ...


# Check if the Prompt Gallery install.py file exists
if os.path.isfile('/workspace/stable-diffusion-webui/extensions/Prompt Gallery/install.py'):
    # Print a message
    print("Hacky Fix for required commandline args, Transmogrifying Peacefully, one moment please.")

    # Try to run the echo and sed commands using subprocess
    try:
        launch_string = subprocess.run(['echo', launch_string], capture_output=True, text=True).stdout
        launch_string = subprocess.run(['sed', '-e', "s/--xformers/& --cors-allow-origins http://remote-ip:5173 --api --listen --server-name remote-ip/", '-e', "s/--cors-allow-origins http://remote-ip:5173 --cors-allow-origins http://remote-ip:5173/--cors-allow-origins http://remote-ip:5173/", '-e', "s/--api --api/--api/", '-e', "s/--listen --listen/--listen/", '-e', "s/--server-name remote-ip --server-name remote-ip/--server-name remote-ip/"], capture_output=True, text=True).stdout
    except FileNotFoundError:
        # Print an error message and skip the command if sed is not found
        print("Error: sed command not found. Skipping sed command.")
        pass

# Print a message
print("There we go, feeling much better now.")



print('Finished installing extensions')
