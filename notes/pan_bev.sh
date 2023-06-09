#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 20
#SBATCH --mem 180G
#SBATCH --partition gpu
#SBATCH --gres gpu:1
#SBATCH --qos dlav
#SBATCH --account civil-459-2023

module load gcc/8.4.0-cuda python/3.7.7 cuda/11.1.1
source ../../panoptic_bev/bin/activate

CUDA_VISIBLE_DEVICES=0,1 \
python3 -m torch.distributed.launch --nproc_per_node=2 --master_addr=172.19.19.51 --master_port=37599 train_panoptic_bev.py \
                                    --run_name=run9 \
                                    --project_root_dir=/home/ceren/PanopticBEV \
                                    --seam_root_dir=/home/ceren/PanopticBEV/data/nuScenes_panopticbev\
                                    --dataset_root_dir=/work/scitas-share/datasets/Vita/civil-459/NuScenes_full/US \
                                    --mode=train \
                                    --train_dataset=nuScenes \
                                    --val_dataset=nuScenes \
                                    --config=nuscenes.ini