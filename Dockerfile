FROM runpod/worker-comfyui:5.1.0-base

# FIXME: when runpod releases the new version with ComfyUI 0.5.9, use it instead of manually installing it here
# Remove any pre-bundled ComfyUI and install the exact ComfyUI version you need
# Replace v0.3.59 with the tag/commit you want to pin.
RUN cd /comfyui && git fetch --tags && git checkout v0.3.59 && pip install -r requirements.txt

# download models using comfy-cli
# the "--filename" is what you use in your ComfyUI workflow
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2509_fp8_e4m3fn.safetensors --relative-path models/diffusion_models --filename qwen_image_edit_2509_fp8_e4m3fn.safetensors
RUN comfy model download --url https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-4steps-V1.0.safetensors --relative-path models/loras --filename Qwen-Image-Lightning-4steps-V1.0.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors --relative-path models/text_encoders --filename qwen_2.5_vl_7b_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors

# Copy local static input files into the ComfyUI input directory (delete if not needed)
# Assumes you have an 'input' folder next to your Dockerfile
#COPY input/ /comfyui/input/