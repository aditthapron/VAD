#!/bin/sh
for method in 0 1 2 3; do
    for fold in 0 1 2 3; do
        if [ $fold == 0 ] ; then
            echo "validate on set 0"
            echo "command: sbatch -o $fold$method.out -e $fold$method.err turing.sh -f $fold -m $method"
        fi
        if [ $fold == 1 ] ; then
            echo "validate on set 1"
        fi
        if [ $fold == 2 ] ; then
            echo "validate on set 2"
        fi
        if [ $fold == 3 ] ; then
            echo "validate on set 3"
        fi
    done
done
        echo "command: cp ../../out_0"
        echo "command: sbatch --job-name ${method}$(basename "$(dirname "$path")") -o $dirname/training.out -e $dirname/training.err DeepSleep.sh -i $data_dir -o $dirname $@"


for path in $output_dir*; do
    [ -d "${path}" ] || continue # if not a directory, skip
    dirname="$output_dir$(basename "${path}")"
    echo "command: sbatch --job-name ${INDEX}$(basename "$(dirname "$path")") -o $dirname/training.out -e $dirname/training.err DeepSleep.sh -i $data_dir -o $dirname $@"
    sbatch --job-name ${INDEX}$(basename "$(dirname "$path")") -o $dirname/training.out -e $dirname/training.err DeepSleep.sh -i $data_dir -o $dirname $@
    let INDEX=${INDEX}+1
done


# End of file
