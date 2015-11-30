#!/usr/bin/env bash

script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[0]}")" && echo X)" && script_dir="${script_dir%$'\nX'}"

ngram_model=${1:-5}
root_dir=${2:-"${script_dir}/../../"}
dataset_filenames=${3:-"dataset alternators engines gearboxes"}

for dataset_name in ${dataset_filenames}; do
	mkdir -p ${root_dir}dataset-analysis/${dataset_name}
	ngram_counter=1
	while [ ${ngram_counter} -le ${ngram_model} ]; do
		${script_dir}/text_analysis.bash ${root_dir}dataset/${dataset_name} ${root_dir}dataset-analysis/${dataset_name}/${dataset_name} ${ngram_counter}
		let ngram_counter+=1
	done
done
 