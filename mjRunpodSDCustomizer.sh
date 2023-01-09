#!/bin/bash


# First things first, thanks @jesse from the Runpod.io discord server for sharing your own script you use to get me started. You helped speed up this process immensely by giving me better understanding of syntax and context needed for my goals. Secondly, thanks to @Zeen for all the insight on what package manager to use and best practices in the Runpod environtment. Lastly, thanks to chatGPT and everyone else that helped me get this working.


# Check for sed command install by environtment type/package manager type and install both if needed
# [ ! -x "$(command -v yum)" ] && [ ! -x "$(command -v apt-get)" ] && [ ! -x "$(command -v brew)" ] && ([ ! -x "$(command -v wget)" ] && curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash || wget -O - https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash) || [ ! -x "$(command -v yum)" ] && apt-get install sed || [ ! -x "$(command -v apt-get)" ] && yum install sed || brew install sed


# Check for and install updates for pip
pip install --upgrade pip

# Check for outdated packages and update them
outdated_packages=$(pip list --outdated)
if [ -n "$outdated_packages" ]; then
    pip install --upgrade $(pip list --outdated | awk '{print $1}')
fi


# Check for sed command install by environtment type/package manager type and install both if needed
if ! command -v apt-get > /dev/null && ! command -v brew > /dev/null; then
  if ! command -v wget > /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
  else
    wget -O - https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
  fi
fi

# Install git lfs as it's needed later for some things
apt-get update
apt-get install apt-utils
apt-get install git-lfs
git-lfs install



# Some models require a HuggingFace Token so we get that first from the user in the terminal of their jupyter notebook on their runpod instance where they should be running this script from. If a false or invalid token is entered here, any groups of models requiring it to be valid will fail and their downloads aborted. 
# Prompt the user to enter their HuggingFace token and update the script
while true; do echo "Enter your HuggingFace token: " && read token && { sed -i -e "s/HuggingFace_TokenGoesHere/$token/g" -e "s/hf_other_placeholder/$token/g" "$0"; break; } done

# Run other commands using the user-supplied token...

# while true; do echo "Enter your HuggingFace token: " && read token && { sed -i -e "s/HuggingFace_TokenGoesHere/$token/g" -e "s/hf_other_placeholder/$token/g" path/to/script.sh; break; } done



# Change directory to SD a1111 install on Runpod instance and edit the relauncher.py to append the needed args for your use cases, such as scripts, extensions, and plugins like the Photoshop Plugin by abds.art which will need the --api arg added to work. in case you want that plugin for photoshop you can find it here - https://github.com/AbdullahAlfaraj/Auto-Photoshop-StableDiffusion-Plugin
cd /workspace/stable-diffusion-webui && { read -r -p "Do you want to append --api to the launch string? (Y/N) " api_response; [ "$api_response" = "Y" ] && sed -i '/--listen / s/--listen /&--api /' relauncher.py || true; } && { read -r -p "Do you want to append --allow-code to the launch string? (Caution - Only enable this if you know you need it and you understand the risks associated with it's use.) (Y/N) " allow_code_response; [ "$allow_code_response" = "Y" ] && sed -i '/--listen / s/--listen /&--allow-code /' relauncher.py || true; } && { read -r -p "Do you want to append --no-progressbar-hiding to the launch string? (we hide it because it slows down ML if you have hardware acceleration turned on in your browser and are running SD locally) (Y/N) " no_progressbar_hiding_response; [ "$no_progressbar_hiding_response" = "Y" ] && sed -i '/--listen / s/--listen /&--no-progressbar-hiding /' relauncher.py || true; } && { read -r -p "Do you want to append --theme dark to the launch string? (Y/N) " theme_response; [ "$theme_response" = "Y" ] && sed -i '/--listen / s/--listen /&--theme dark /' relauncher.py || true; }
# cd /workspace/stable-diffusion-webui && { read -r -p "Do you want to append --api to the launch string? (Y/N) " api_response; [ "$api_response" = "Y" ] && sed -i '/--listen/ s/$/ --api/' relauncher.py || true; } && { read -r -p "Do you want to append --allow-code to the launch string? (Caution - Only enable this if you know you need it and you understand the risks associated with it's use.) (Y/N) " allow_code_response; [ "$allow_code_response" = "Y" ] && sed -i '/--listen/ s/$/ --allow-code/' relauncher.py || true; } && { read -r -p "Do you want to append --no-progressbar-hiding to the launch string? (we hide it because it slows down ML if you have hardware acceleration turned on in your browser and are running SD locally) (Y/N) " no_progressbar_hiding_response; [ "$no_progressbar_hiding_response" = "Y" ] && sed -i '/--listen/ s/$/ --no-progressbar-hiding/' relauncher.py || true; } && { read -r -p "Do you want to append --theme dark to the launch string? (Y/N) " theme_response; [ "$theme_response" = "Y" ] && sed -i '/--listen/ s/$/ --theme dark/' relauncher.py || true; }
cd /workspace/stable-diffusion-webui && { read -r -p "Do you want to append --no-half to the launch string? (Y/N) " no_half_response; [ "$no_half_response" = "Y" ] && { read -r -p "This option requires High VRAM, do you wish to proceed? (Y/N) " vram_response; [ "$vram_response" = "Y" ] && sed -i '/--listen / s/--listen /&--no-half /' relauncher.py || true; } || true; } && { read -r -p "Do you want to append --precision full to the launch string? (Y/N) " precision_response; [ "$precision_response" = "Y" ] && { read -r -p "This option requires High VRAM, do you wish to proceed? (Y/N) " vram_response; [ "$vram_response" = "Y" ] && sed -i '/--listen / s/--listen /&--precision full /' relauncher.py || true; } || true; } && { read -r -p "Do you want to append --no-half-vae to the launch string? (Y/N) " no_half_vae_response; [ "$no_half_vae_response" = "Y" ] && { read -r -p "This option requires High VRAM, do you wish to proceed? (Y/N) " vram_response; [ "$vram_response" = "Y" ] && sed -i '/--listen / s/--listen /&--no-half-vae /' relauncher.py || true; } || true; }
# cd /workspace/stable-diffusion-webui && { read -r -p "Do you want to append --no-half to the launch string? (Y/N) " no_half_response; [ "$no_half_response" = "Y" ] && { read -r -p "This option requires High VRAM, do you wish to proceed? (Y/N) " vram_response; [ "$vram_response" = "Y" ] && sed -i '/--listen/ s/$/ --no-half/' relauncher.py || true; } || true; } && { read -r -p "Do you want to append --precision full to the launch string? (Y/N) " precision_response; [ "$precision_response" = "Y" ] && { read -r -p "This option requires High VRAM, do you wish to proceed? (Y/N) " vram_response; [ "$vram_response" = "Y" ] && sed -i '/--listen/ s/$/ --precision full/' relauncher.py || true; } || true; } && { read -r -p "Do you want to append --no-half-vae to the launch string? (Y/N) " no_half_vae_response; [ "$no_half_vae_response" = "Y" ] && { read -r -p "This option requires High VRAM, do you wish to proceed? (Y/N) " vram_response; [ "$vram_response" = "Y" ] && sed -i '/--listen/ s/$/ --no-half-vae/' relauncher.py || true; } || true; }
# cd /workspace/stable-diffusion-webui && { read -r -p "Do you want to append --api to the launch string? (Y/N) " api_response; [ "$api_response" = "Y" ] && sed -i '/--listen/ s/$/ --api/' relauncher.py || true; } && { read -r -p "Do you want to append --allow-code to the launch string? (Caution - Only enable this if you know you need it and you understand the risks associated with it's use.) (Y/N) " allow_code_response; [ "$allow_code_response" = "Y" ] && sed -i '/--listen/ s/$/ --allow-code/' relauncher.py || true; } && { read -r -p "Do you want to append --no-progressbar-hiding to the launch string? (we hide it because it slows down ML if you have hardware acceleration turned on in your browser and are running SD locally) (Y/N) " no_progressbar_hiding_response; [ "$no_progressbar_hiding_response" = "Y" ] && sed -i '/--listen/ s/$/ --no-progressbar-hiding/' relauncher.py || true; }



# Check if Git is installed and if not to install it.
cd /workspace && { command -v git || { wget https://github.com/git/git/archive/master.zip && unzip master.zip && cd git-master && make configure && ./configure --prefix=/usr/local && make install && cd .. && rm -rf git-master master.zip; } }



# Begin Models Downloads by user selection
cd /workspace/stable-diffusion-webui/models/Stable-diffusion

# v2.X Model Files - typically lists GB volume for each group when asking you to confirm download for each so make sure you have enough container/disk space for each one you respond yes to. -mjnote
# comment out each group you don't want to use. each group of ckpt, safetensors, and yaml files are together for ease of reading/use by other users. To comment or uncomment a line in a text editor, add that hash/pound sign to the first character of a line or remove it as appropriate for the intent to comment or uncomment. -mjnote

# v2.1 512 base models and yaml config file.
while true; do echo "Do you want to download the v2.1 512 base models and yaml config files in this group? roughly 10.42GB (Y/N)" && read answer && { [ "$answer" = "Y" ] && { [ ! -f v2-1_512-ema-pruned.ckpt ] && { wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-2-1-base/resolve/main/v2-1_512-ema-pruned.ckpt || curl -H "Authorization: HuggingFace_TokenGoesHere" -O https://huggingface.co/stabilityai/stable-diffusion-2-1-base/resolve/main/v2-1_512-ema-pruned.ckpt || git lfs fetch --header="Authorization: HuggingFace_TokenGoesHere" origin main -- v2-1_512-ema-pruned.ckpt || { echo "Failed to download v2-1_512-ema-pruned.ckpt"; break; }; }; } && { [ ! -f v2-1_512-ema-pruned.safetensors ] && { wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-2-1-base/resolve/main/v2-1_512-ema-pruned.safetensors || curl -H "Authorization: HuggingFace_TokenGoesHere" -O https://huggingface.co/stabilityai/stable-diffusion-2-1-base/resolve/main/v2-1_512-ema-pruned.safetensors || git lfs fetch --header="Authorization: HuggingFace_TokenGoesHere" origin main -- v2-1_512-ema-pruned.safetensors || { echo "Failed to download v2-1_512-ema-pruned.safetensors"; break; }; }; } && { [ ! -f v2-1_512-ema-pruned.yaml ] && { wget --header="Authorization: HuggingFace_TokenGoesHere" https://github.com/Stability-AI/stablediffusion/blob/main/configs/stable-diffusion/v2-inference.yaml --output-document=v2-1_512-ema-pruned.yaml || curl -H "Authorization: HuggingFace_TokenGoesHere" -o v2-1_512-ema-pruned.yaml https://github.com/Stability-AI/stablediffusion/blob/main/configs/stable-diffusion/v2-inference.yaml || git lfs fetch --header="Authorization: HuggingFace_TokenGoesHere" origin main -- v2-1_512-ema-pruned.yaml || { echo "Failed to download v2-1_512-ema-pruned.yaml"; break; }; }; } } || break; done



# v2.0 512 depth models and yaml config file.
while true; do echo "Do you want to download the v2.0 512 depth models and yaml config files in this group? roughly 11.42GB (Y/N)" && read answer && { [ "$answer" = "Y" ] && { [ -f v2-x_512-depth-ema.ckpt ] || { wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-2-depth/resolve/main/512-depth-ema.ckpt --output-document=v2-x_512-depth-ema.ckpt || break; [ -f v2-x_512-depth-ema.safetensors ] || wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-2-depth/resolve/main/512-depth-ema.safetensors --output-document=v2-x_512-depth-ema.safetensors; [ -f v2-x_512-depth-ema.yaml ] || wget https://github.com/Stability-AI/stablediffusion/blob/main/configs/stable-diffusion/v2-midas-inference.yaml --output-document=v2-x_512-depth-ema.yaml; } } || break; } done



# v2.0 512 inpainting models and yaml config file.
while true; do echo "Do you want to download the v2.0 512 inpainting models and yaml config files in this group? roughly 10.42GB (Y/N)" && read answer && { [ "$answer" = "Y" ] && { [ -f v2-X_512-inpainting-ema.ckpt ] || { wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-2-inpainting/resolve/main/512-inpainting-ema.ckpt || break; [ -f v2-X_512-inpainting-ema.safetensors ] || wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-2-inpainting/resolve/main/512-inpainting-ema.safetensors; [ -f v2-X_512-inpainting-ema.yaml ] || wget https://github.com/Stability-AI/stablediffusion/blob/main/configs/stable-diffusion/v2-inpainting-inference.yaml --output-document=v2-X_512-inpainting-ema.yaml; } } || break; } done



# v2.0 x4 upscaling models and yaml config file.
while true; do echo "Do you want to download the v2.0 x4 upscaling models and yaml config files in this group? roughly 7GB (Y/N)" && read answer && { [ "$answer" = "Y" ] && { [ -f v2-X_x4-upscaler-ema.ckpt ] || { wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-x4-upscaler/resolve/main/x4-upscaler-ema.ckpt || break; [ -f v2-X_x4-upscaler-ema.safetensors ] || wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/stabilityai/stable-diffusion-x4-upscaler/resolve/main/x4-upscaler-ema.safetensors; [ -f v2-X_x4-upscaler-ema.yaml ] || wget https://github.com/Stability-AI/stablediffusion/blob/main/configs/stable-diffusion/x4-upscaling.yaml --output-document=v2-X_x4-upscaler-ema.yaml; } } || break; } done



# v1.X Model Files
while true; do echo "Do you want to download the v1.X Model files in this group? roughly 4.27GB (Y/N)" && read answer && { [ "$answer" = "Y" ] && { [ -f v1-5-pruned-emaonly.ckpt ] || { wget --header="Authorization: HuggingFace_TokenGoesHere" https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt || break; [ -f v1-5-pruned-emaonly.yaml ] || wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-inference.yaml --output-document=v1-5-pruned-emaonly.yaml; } } || break; } done



# vOther.X Model Files
while true; do read -p "Do you want to download the SimpMaker3k1 model file? $(curl -sI https://huggingface.co/AmethystVera/SimpMaker-3K1/resolve/main/SimpMaker%203k1.ckpt | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/SimpMaker3k1.ckpt ] && wget https://huggingface.co/AmethystVera/SimpMaker-3K1/resolve/main/SimpMaker%203k1.ckpt --output-document=SimpMaker3k1.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N"; done



while true; do read -p "Do you want to download the HassanAnything model file? $(curl -sI https://civitai.com/api/download/models/1451 | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/HassanAnything.ckpt ] && wget https://civitai.com/api/download/models/1451 --output-document=HassanAnything.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the mdjrny-v4 model file? $(curl -sI https://huggingface.co/prompthero/openjourney/resolve/main/mdjrny-v4.ckpt | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/mdjrny-v4.ckpt ] && wget https://huggingface.co/prompthero/openjourney/resolve/main/mdjrny-v4.ckpt --output-document=mdjrny-v4.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the rpg model file? $(curl -sI https://civitai.com/api/download/models/1124 | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/rpg.ckpt ] && wget https://civitai.com/api/download/models/1124 --output-document=rpg.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the eldenring model file? $(curl -sI https://civitai.com/api/download/models/29 | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/eldenring.ckpt ] && wget https://civitai.com/api/download/models/29 --output-document=eldenring.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the dungeondiffusion model file? $(curl -sI https://civitai.com/api/download/models/1359 | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/dungeondiffusion.ckpt ] && wget https://civitai.com/api/download/models/1359 --output-document=dungeondiffusion.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the Lucid model file? $(curl -sI https://civitai.com/api/download/models/1450 | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/Lucid.safetensors ] && wget https://civitai.com/api/download/models/1450 --output-document=Lucid.safetensors && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the retrolucid model file? $(curl -sI https://civitai.com/api/download/models/1575 | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/retrolucid.safetensors ] && wget https://civitai.com/api/download/models/1575 --output-document=retrolucid.safetensors && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the SimpMaker2k model file? $(curl -sI https://huggingface.co/AmethystVera/SimpMaker2000/resolve/main/2_AloeVera%20SimpMaker2000.ckpt | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/SimpMaker2k.ckpt ] && wget https://huggingface.co/AmethystVera/SimpMaker2000/resolve/main/2_AloeVera%20SimpMaker2000.ckpt --output-document=SimpMaker2k.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the wd-v1-3-full model file? $(curl -sI https://huggingface.co/hakurei/waifu-diffusion-v1-3/resolve/main/wd-v1-3-full.ckpt | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/wd-v1-3-full.ckpt ] && wget https://huggingface.co/hakurei/waifu-diffusion-v1-3/resolve/main/wd-v1-3-full.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the 3DKX_1.0b model file? $(curl -sI https://huggingface.co/HavoAloe/3DKX_1.0b/resolve/main/3DKX_1.0b.safetensors | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/3DKX_1.0b.safetensors ] && wget https://huggingface.co/HavoAloe/3DKX_1.0b/resolve/main/3DKX_1.0b.safetensors && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done



while true; do read -p "Do you want to download the dreamlike-diffusion-1.0 model file? $(curl -sI https://civitai.com/api/download/models/1356 | grep Content-Length | awk '{print $2}' | tr -d '\r') bytes (Y/N)" answer && [ "$answer" = "Y" ] && [ ! -f /workspace/stable-diffusion-webui/models/Stable-diffusion/dreamlike-diffusion-1.0.ckpt ] && wget https://civitai.com/api/download/models/1356 --output-document=dreamlike-diffusion-1-0.ckpt && break || ([ "$answer" = "N" ]) && break || ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && echo "Please enter Y or N" && ([ "$answer" != "Y" ] && [ "$answer" != "N" ]) && break; done




#Hypernetworks
cd /workspace/stable-diffusion-webui/models/hypernetworks

if [ -f /workspace/stable-diffusion-webui/models/hypernetworks/djzCyberSocietyV21_0.pt ]; then echo "Skipping"; else read -p "Do you want to install the djzCyberSocietyV21_0 hypernetwork? (Relies on v2.x models) (Y/N): " answer && ([ "$answer" = "Y" ] && wget https://civitai.com/api/download/models/3003 --output-document=djzCyberSocietyV21_0.pt || [ "$answer" = "N" ]) || (echo "Please enter Y or N" && read -p "Do you want to install the djzCyberSocietyV21_0 hypernetwork? (Y/N): " answer && ([ "$answer" = "Y" ] && wget https://civitai.com/api/download/models/3003 --output-document=djzCyberSocietyV21_0.pt || [ "$answer" = "N" ]) || (echo "Please enter Y or N" && read -p "Do you want to install the djzCyberSocietyV21_0 hypernetwork? (Y/N): " answer && ([ "$answer" = "Y" ] && wget https://civitai.com/api/download/models/3003 --output-document=djzCyberSocietyV21_0.pt || [ "$answer" = "N" ]) || echo "Skipping"))); fi



#VAE Files
cd /workspace/stable-diffusion-webui/models/VAE
[ -f /workspace/stable-diffusion-webui/models/Stable-diffusion/SimpMaker3k1.ckpt ] && [ ! -f /workspace/stable-diffusion-webui/models/VAE/aloeVeraSSimpMaker3K1.vae.pt ] && wget http://www.kinnetik.net/aloeVeraSSimpMaker3K1.vae.pt

[ -f /workspace/stable-diffusion-webui/models/Stable-diffusion/HassanAnything.ckpt ] && [ ! -f /workspace/stable-diffusion-webui/models/VAE/Anything-V3.0.vae.pt ] && wget https://huggingface.co/Linaqruf/anything-v3.0/resolve/main/Anything-V3.0.vae.pt



#Aesthetic Gradient Embeddings
# cd /workspace/stable-diffusion-webui/extensions/aesthetic-gradients/aesthetic_embeddings
# [ -f Kipaki-150.pt ] && echo "Skipping" || wget https://huggingface.co/Conflictx/Kipaki-EgyptianSciFi/resolve/main/Kipaki-150.pt
# [ -f Style-Glorious.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2258 --output-document=Style-Glorious.pt



#Embeddings
cd /workspace/stable-diffusion-webui/embeddings
[ -f Kipaki-150.pt ] && echo "Skipping" || wget https://huggingface.co/Conflictx/Kipaki-EgyptianSciFi/resolve/main/Kipaki-150.pt
[ -f Style-Glorious.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2258 --output-document=Style-Glorious.pt
[ -f TungstenDispo.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/3826 --output-document=TungstenDispo.pt
[ -f InkPunk768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1371 --output-document=InkPunk768.pt
[ -f SCG768-Euphoria.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/3510 --output-document=SCG768-Euphoria.pt
[ -f SCG768-Nebula.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/3468 --output-document=SCG768-Nebula.pt
[ -f InkPunkLandscapes768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1367 --output-document=InkPunkLandscapes768.pt
[ -f InkPunkHeavy768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1368 --output-document=InkPunkHeavy768.pt
[ -f InkPunkLite768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1369 --output-document=InkPunkLite768.pt
[ -f dblx.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2625 --output-document=dblx.pt
[ -f Cinema768-Digital.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1691 --output-document=Cinema768-Digital.pt
[ -f Cinema768-Analog.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1692 --output-document=Cinema768-Analog.pt
[ -f Cinema768-Classic.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1694 --output-document=Cinema768-Classic.pt
[ -f Cinema768-BW.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2297 --output-document=Cinema768-BW.pt
[ -f Cinema768-SilentFilm.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2333 --output-document=Cinema768-SilentFilm.pt
[ -f no_unrealistic768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1695 --output-document=no_unrealistic768.pt
[ -f ScaryMonstersV2.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2259 --output-document=ScaryMonstersV2.pt
[ -f mdjrny-ppc.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1155 --output-document=mdjrny-ppc.pt
[ -f SDA768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1389 --output-document=SDA768.pt
[ -f GTA768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1561 --output-document=GTA768.pt
[ -f Chadeisson.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1570 --output-document=Chadeisson.pt
[ -f cartoonish_doll.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1761 --output-document=cartoonish_doll.pt
[ -f CinemaHelper.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2062 --output-document=CinemaHelper.pt
[ -f HyperNuke.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1991 --output-document=HyperNuke.pt
[ -f UlukInkSketch2.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1651 --output-document=UlukInkSketch2.pt
[ -f Smoose-22.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/4042 --output-document=Smoose-22.pt
[ -f Zootopiav4.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2774 --output-document=Zootopiav4.pt
[ -f SocialistRealism.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2374 --output-document=SocialistRealism.pt
[ -f CarHelper.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1944 --output-document=CarHelper.pt
[ -f KittyPic.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2064 --output-document=KittyPic.pt
[ -f vray-render.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1164 --output-document=vray-render.pt
[ -f laxpeint.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/3379 --output-document=laxpeint.pt
[ -f painted_landscape.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1168 --output-document=painted_landscape.pt
[ -f DaveSpaceFour.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1597 --output-document=DaveSpaceFour.pt
[ -f DaveSpaceOne.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1502 --output-document=DaveSpaceOne.pt
[ -f AnalogFilm768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2611 --output-document=AnalogFilm768.pt
[ -f AnalogFilm768-Old-School.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2613 --output-document=AnalogFilm768-Old-School.pt
[ -f AnalogFilm768-BW-Modern.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2614 --output-document=AnalogFilm768-BW-Modern.pt
[ -f AnalogFilm768-BW-Classic.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2615 --output-document=AnalogFilm768-BW-Classic.pt
[ -f AnalogFilm768-BW-Vintage.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2616 --output-document=AnalogFilm768-BW-Vintage.pt
[ -f AnalogFilm768-BW-Tintype.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2617 --output-document=AnalogFilm768-BW-Tintype.pt
[ -f ActionHelper.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2063 --output-document=ActionHelper.pt
[ -f painted_abstract.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1383 --output-document=painted_abstract.pt
[ -f pixelart-1.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1277 --output-document=pixelart-1.pt
[ -f PhotoHelper.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2028 --output-document=PhotoHelper.pt
[ -f PortraitHelper.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2065 --output-document=PortraitHelper.pt
[ -f neg_Colorizer768-neutral.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2367 --output-document=neg_Colorizer768-neutral.pt
[ -f neg_Colorizer768-Cool.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2368 --output-document=neg_Colorizer768-Cool.pt
[ -f neg_Colorizer768-Warm.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2369 --output-document=neg_Colorizer768-Warm.pt
[ -f Neg_Colorizer768-Vibrant.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2370 --output-document=Neg_Colorizer768-Vibrant.pt
[ -f Neg_Colorizer768-Vivid.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2371 --output-document=Neg_Colorizer768-Vivid.pt
[ -f Neg_Colorizer768-Intense.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2372 --output-document=Neg_Colorizer768-Intense.pt
[ -f Neg_Facelift768.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2623 --output-document=Neg_Facelift768.pt
[ -f WEBUI.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2786 --output-document=WEBUI.pt
[ -f Remix.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1216 --output-document=Remix.pt
[ -f FloralMarble.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1990 --output-document=FloralMarble.pt
[ -f HyperFluid.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1993 --output-document=HyperFluid.pt
[ -f fragmenv2.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2444 --output-document=fragmenv2.pt
[ -f PaintStyle1.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/1796 --output-document=PaintStyle1.pt
[ -f PaintStyle3.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2182 --output-document=PaintStyle3.pt
[ -f UrbanJungle.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2626 --output-document=UrbanJungle.pt
[ -f VintageHelper.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2029 --output-document=VintageHelper.pt
[ -f IpScifi.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2741 --output-document=IpScifi.pt
[ -f IpScifiHelper.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2867 --output-document=IpScifiHelper.pt
[ -f ThisHonor.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2999 --output-document=ThisHonor.pt
[ -f GigaChad.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2027 --output-document=GigaChad.pt
[ -f latteart.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2831 --output-document=latteart.pt
[ -f EMB_JWTT-150.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2866 --output-document=EMB_JWTT-150.pt
[ -f HorrorByDave.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2700 --output-document=HorrorByDave.pt
[ -f PMondrian.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2479 --output-document=PMondrian.pt
[ -f clown-world.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2958 --output-document=clown-world.pt
[ -f Cyber-Samurai.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/2951 --output-document=Cyber-Samurai.pt
[ -f LysergianDreams-3000.pt ] && echo "Skipping" || wget https://huggingface.co/tolerantpancake/LysergianDreams/resolve/main/LysergianDreams-3000.pt
[ -f LysergianDreams-3200.pt ] && echo "Skipping" || wget https://huggingface.co/tolerantpancake/LysergianDreams/resolve/main/LysergianDreams-3200.pt
[ -f LysergianDreams-3400.pt ] && echo "Skipping" || wget https://huggingface.co/tolerantpancake/LysergianDreams/resolve/main/LysergianDreams-3400.pt
[ -f LysergianDreams-3600.pt ] && echo "Skipping" || wget https://huggingface.co/tolerantpancake/LysergianDreams/resolve/main/LysergianDreams-3600.pt
[ -f LysergianDreams-3800.pt ] && echo "Skipping" || wget https://huggingface.co/tolerantpancake/LysergianDreams/resolve/main/LysergianDreams-3800.pt
[ -f LysergianDreams-4000.pt ] && echo "Skipping" || wget https://huggingface.co/tolerantpancake/LysergianDreams/resolve/main/LysergianDreams-4000.pt
[ -f BOM.pt ] && echo "Skipping" || wget https://huggingface.co/tolerantpancake/BeastsOfMidsommar/resolve/main/BOM.pt --output-document=BOM.pt
[ -f NegLowRes-100.pt ] && echo "Skipping" || git clone https://huggingface.co/tolerantpancake/NegativeLowResolution /workspace/stable-diffusion-webui/embeddings
[ -f NegMutation-100.pt ] && echo "Skipping" || git clone https://huggingface.co/tolerantpancake/NegativeMutation /workspace/stable-diffusion-webui/embeddings
[ -f CyberJourneyv4-100.pt ] && echo "Skipping" || git clone https://huggingface.co/tolerantpancake/CyberJourneyv4 /workspace/stable-diffusion-webui/embeddings

# Next line is just easy copypasta template for adding new embeddings to be downloaded to the list.
# [ -f TungstenDispo.pt ] && echo "Skipping" || wget https://civitai.com/api/download/models/3826 --output-document=TungstenDispo.pt


# Restore the placeholder token therefore destroying the user provided one so it's not being stored insecurely.
sed -i -e "s/$token/HuggingFace_TokenGoesHere/g" -e "s/$token/hf_other_placeholder/g" "$0"



# read -p "Do you want to import training data via a .zip file from a Google Drive link you set to share with anyone? (Y/N): " answer; if [ "$answer" = "Y" ]; then python /workspace/mjMagicTool/trainMyZipUp.py; elif [ "$answer" = "N" ]; then :; else for i in {1..2}; do read -p "Invalid response. Do you want to import training data via a .zip file from a Google Drive link you set to share with anyone? (Y/N): " answer; if [ "$answer" = "Y" ]; then python /workspace/mjMagicTool/trainMyZipUp.py; break; elif [ "$answer" = "N" ]; then :; break; fi; done; if [ "$answer" != "Y" ] && [ "$answer" != "N" ]; then :; fi; fi
read -p "Do you want to import training data via a .zip file from a Google Drive link you set to share with anyone? (Y/N): " answer; if [ "$answer" = "Y" ]; then
    python /workspace/mjMagicTool/trainMyZipUp.py &
    wait %1
elif [ "$answer" = "N" ]; then
    :
else
    for i in {1..2}; do
        read -p "Invalid response. Do you want to import training data via a .zip file from a Google Drive link you set to share with anyone? (Y/N): " answer;
        if [ "$answer" = "Y" ]; then
            python /workspace/mjMagicTool/trainMyZipUp.py &
            wait %1
            break
        elif [ "$answer" = "N" ]; then
            :
            break
        fi
    done
    if [ "$answer" != "Y" ] && [ "$answer" != "N" ]; then
        :
    fi
fi



# read -p "Do you want to add Extensions? (Y/N): " answer; if [ "$answer" = "Y" ]; then python /workspace/mjMagicTool/getExtLoopy.py; elif [ "$answer" = "N" ]; then :; else for i in {1..2}; do read -p "Invalid response. Do you want to add Extensions? (Y/N): " answer; if [ "$answer" = "Y" ]; then python /workspace/mjMagicTool/getExtLoopy.py; break; elif [ "$answer" = "N" ]; then :; break; fi; done; if [ "$answer" != "Y" ] && [ "$answer" != "N" ]; then :; fi; fi
read -p "Do you want to add Extensions? (Y/N): " answer; if [ "$answer" = "Y" ]; then
    python /workspace/mjMagicTool/getExtLoopy.py &
    wait %2
elif [ "$answer" = "N" ]; then
    :
else
    for i in {1..2}; do
        read -p "Invalid response. Do you want to add Extensions? (Y/N): " answer;
        if [ "$answer" = "Y" ]; then
            python /workspace/mjMagicTool/getExtLoopy.py &
            wait %2
            break
        elif [ "$answer" = "N" ]; then
            :
            break
        fi
    done
    if [ "$answer" != "Y" ] && [ "$answer" != "N" ]; then
        :
    fi
fi

# read -p "Do you want to import Custom Scripts? (Y/N): " answer; if [ "$answer" = "Y" ]; then python /workspace/mjMagicTool/magicScripts.py; elif [ "$answer" = "N" ]; then :; else for i in {1..2}; do read -p "Invalid response. Do you want to import Custom Scripts? (Y/N): " answer; if [ "$answer" = "Y" ]; then python /workspace/mjMagicTool/magicScripts.py; break; elif [ "$answer" = "N" ]; then :; break; fi; done; if [ "$answer" != "Y" ] && [ "$answer" != "N" ]; then :; fi; fi
# read -p "Do you want to import Custom Scripts? (Y/N): " answer && ([ "$answer" = "Y" ] && bash /workspace/mjMagicTool/magicScripts.sh || [ "$answer" = "N" ]) || (echo "Please enter Y or N" && read -p "Invalid response. Do you want to import Custom Scripts? (Y/N): " answer && ([ "$answer" = "Y" ] && bash /workspace/mjMagicTool/magicScripts.sh || [ "$answer" = "N" ]) || (echo "Please enter Y or N" && read -p "Invalid response. Do you want to import Custom Scripts? (Y/N): " answer && ([ "$answer" = "Y" ] && bash /workspace/mjMagicTool/magicScripts.sh || [ "$answer" = "N" ]) || :))
read -p "Do you want to import Custom Scripts? (Y/N): " answer && ([ "$answer" = "Y" ] && bash /workspace/mjMagicTool/magicScripts.sh & wait %3 || [ "$answer" = "N" ]) || (echo "Please enter Y or N" && read -p "Invalid response. Do you want to import Custom Scripts? (Y/N): " answer && ([ "$answer" = "Y" ] && bash /workspace/mjMagicTool/magicScripts.sh & wait %3 || [ "$answer" = "N" ]) || (echo "Please enter Y or N" && read -p "Invalid response. Do you want to import Custom Scripts? (Y/N): " answer && ([ "$answer" = "Y" ] && bash /workspace/mjMagicTool/magicScripts.sh & wait %3 || [ "$answer" = "N" ]) || :))

echo "Mischief Managed"
echo " .-. "
echo " .'=^=`. "
echo " /(0 0)` "
echo " \/-,--' "
echo " (/ \` "
echo " /\ | "
echo " / / "
echo " / // "
echo " / / | \` "
echo " \`/ \`| | "
echo " //`/ / "
echo " // / / "
echo " / / / / "
echo " \`/ / / "
echo " / / / "
echo " | | | "
echo " \`/ / "
echo " \/ "

echo "Don't forget to restart the webui now that these changes have been made so all dependencies will finish installing."