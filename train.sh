SEEDS=(0 1)
EPS=(10.0)
GPUS=(0 1 2 3)
TARGET_TYPE="blank"
N_EPOCHS=100
SEP="_"

for eps_idx in ${!EPS[@]}
do
    for seed_idx in ${!SEEDS[@]}
    do
        mkdir -p exp_data_full/mnist_$TARGET_TYPE$SEP$N_EPOCHS/seed${SEEDS[$seed_idx]}/
        gpu_idx=$((4 * eps_idx + seed_idx))
        CUDA_VISIBLE_DEVICES=${GPUS[$gpu_idx]} python3 audit_model.py --data_name mnist --model_name cnn --n_epochs $N_EPOCHS --lr 6.67e-5 --epsilon ${EPS[$eps_idx]} \
            --fixed_init --target_type $TARGET_TYPE --n_reps 256 \
            --seed ${SEEDS[$seed_idx]} --out exp_data/mnist_$TARGET_TYPE$SEP$N_EPOCHS/seed${SEEDS[$seed_idx]}/ --block_size 10000 > exp_data_full/mnist_$TARGET_TYPE$SEP$N_EPOCHS/seed${SEEDS[$seed_idx]}/${EPS[$eps_idx]}.log 2>&1 &
    done
done