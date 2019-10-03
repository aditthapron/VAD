#!/bin/bash
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --gres=gpu:1
#SBATCH -C K40|K80
#SBATCH -t 48:00:00
#SBATCH --mem 12G
#SBATCH -p long

source activate WASH_GPU

curdir=`pwd`
pylibdir=`realpath $curdir/lib/python`
train=`realpath $pylibdir/train.py`

# rm -rf $curdir/norm_data/*.mat
# rm -rf $curdir/result/*
# rm -rf $curdir/logs/*
# rm -rf $curdir/sample_data/*
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# rm -rf $curdir/data/feat/train/*
# rm -rf $curdir/data/feat/valid/*
# cp ../../MUSAN/noisy_audio/* $curdir/data/raw/train/
# cp ../out/3_* $curdir/data/raw/valid/
python $train -m 4 -e 0 --prj_dir=$curdir



# cp ../out/0_* $curdir/data/raw/train/
# cp ../out/1_* $curdir/data/raw/train/
# cp ../out/2_* $curdir/data/raw/train/
# cp ../out/3_* $curdir/data/raw/valid/

# python $train -m 2 -e 1 --prj_dir=$curdir

# python $train -m 3 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 0 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 1 -e 0 --prj_dir=$curdir

# rm -rf $curdir/norm_data/*.mat
# rm -rf $curdir/result/*
# rm -rf $curdir/sample_data/*
# rm -rf $curdir/data/raw/train/*
# rm -rf $curdir/data/raw/valid/*

# cp ../out/0_* $curdir/data/raw/train/
# cp ../out/1_* $curdir/data/raw/train/
# cp ../out/2_* $curdir/data/raw/valid/
# cp ../out/3_* $curdir/data/raw/train/

# python $train -m 2 -e 1 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 3 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 0 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 1 -e 0 --prj_dir=$curdir

# rm -rf $curdir/norm_data/*.mat
# rm -rf $curdir/result/*
# rm -rf $curdir/sample_data/*
# rm -rf $curdir/data/raw/train/*
# rm -rf $curdir/data/raw/valid/*

# cp ../out/0_* $curdir/data/raw/train/
# cp ../out/1_* $curdir/data/raw/valid/
# cp ../out/2_* $curdir/data/raw/train/
# cp ../out/3_* $curdir/data/raw/train/

# python $train -m 2 -e 1 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 3 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 0 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 1 -e 0 --prj_dir=$curdir

# rm -rf $curdir/norm_data/*.mat
# rm -rf $curdir/result/*
# rm -rf $curdir/sample_data/*
# rm -rf $curdir/data/raw/train/*
# rm -rf $curdir/data/raw/valid/*

# cp ../out/0_* $curdir/data/raw/valid/
# cp ../out/1_* $curdir/data/raw/train/
# cp ../out/2_* $curdir/data/raw/train/
# cp ../out/3_* $curdir/data/raw/train/

# python $train -m 2 -e 1 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 3 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 0 -e 0 --prj_dir=$curdir
# rm -rf $curdir/data/feat/train/npz
# rm -rf $curdir/data/feat/valid/npz
# python $train -m 1 -e 0 --prj_dir=$curdir

