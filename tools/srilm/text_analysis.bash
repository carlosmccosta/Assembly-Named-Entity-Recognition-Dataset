#!/usr/bin/env bash

text_file=${1:?'Must specify text file'}
output_file=${2:?'Must specify output file'}
ngram_model=${3:-3}
smoothing=${4:-1}
number_sentences=${5:-100}
debug=${6:-2}

script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[0]}")" && echo X)" && script_dir="${script_dir%$'\nX'}"

${script_dir}/word_count.sh ${text_file}_train ${output_file}_train ${ngram_model} ${smoothing}
${script_dir}/perplexity.sh ${text_file} ${output_file} ${ngram_model} ${smoothing} ${debug}
${script_dir}/sentence_generation.sh ${output_file}_train ${ngram_model} ${smoothing} ${number_sentences}

${script_dir}/../rank_frequency_graph.py -i "${output_file}_train_${ngram_model}-gram.count_sorted" -o "${output_file}_train_${ngram_model}-gram_rank-frequency-graph"
