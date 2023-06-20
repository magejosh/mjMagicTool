import requests
import os

urls = [
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11e_sd15_ip2p.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11e_sd15_shuffle.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1p_sd15_depth.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_inpaint.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_lineart.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_mlsd.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_normalbae.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_scribble.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_seg.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_softedge.pth',
    'https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15s2_lineart_anime.pth',
    'https://huggingface.co/DionTimmer/controlnet_qrcode/resolve/main/control_v1p_sd15_qrcode.safetensors',
    'https://huggingface.co/DionTimmer/controlnet_qrcode/resolve/main/control_v11p_sd21_qrcode.safetensors'
]

for url in urls:
    file_name = os.path.basename(url)
    if not os.path.exists(file_name):
        response = requests.get(url)
        with open(file_name, 'wb') as f:
            f.write(response.content)
    yaml_url = url.replace('.pth', '.yaml').replace('.safetensors', '.yaml')
    yaml_file_name = file_name.replace('.pth', '.yaml').replace('.safetensors', '.yaml')
    if not os.path.exists(yaml_file_name):
        yaml_response = requests.get(yaml_url)
        with open(yaml_file_name, 'wb') as f:
            f.write(yaml_response.content)