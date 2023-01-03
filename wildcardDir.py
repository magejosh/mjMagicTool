#!/usr/bin/env python

import subprocess

# create and activate a virtual environment in the /workspace/mjMagicTool directory
subprocess.run(["python", "-m", "venv", "/workspace/mjMagicTool"])
subprocess.run(["source", "/workspace/mjMagicTool/bin/activate"])

# install the jq package in the virtual environment
subprocess.run(["pip", "install", "jq"])

# use the jq command within the virtual environment
subprocess.run(["jq", '.wildcard_dir="/workspace/stable-diffusion-webui/extensions/sd-dynamic-prompts/wildcards"', "--arg", "wildcard_dir", "/workspace/stable-diffusion-webui/extensions/sd-dynamic-prompts/wildcards", '.[$wildcard_dir] |= . + $wildcard_dir', "/workspace/stable-diffusion-webui/config.json", ">", "/workspace/stable-diffusion-webui/config.json.tmp"])
subprocess.run(["mv", "/workspace/stable-diffusion-webui/config.json.tmp", "/workspace/stable-diffusion-webui/config.json"])

# deactivate the virtual environment
subprocess.run(["deactivate"])
