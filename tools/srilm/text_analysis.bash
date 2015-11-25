#!/usr/bin/env bash

text_file=${1:?'Must specify text file'}
ngram_model=${2:-3}
smoothing=${3:-1}
number_sentences=${4:-100}
debug=${5:-2}

script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[0]}")" && echo X)" && script_dir="${script_dir%$'\nX'}"

${script_dir}/word_count.bash ${text_file}_train ${ngram_model} ${smoothing}
${script_dir}/perplexity.bash ${text_file} ${ngram_model} ${smoothing} ${debug}
${script_dir}/sentence_generation.bash ${text_file}_train ${ngram_model} ${smoothing} ${number_sentences}

${script_dir}/../nltk/rank_frequency_graph.py -i "${text_file}_train_${ngram_model}-gram.count_sorted" -o "${text_file}_train_${ngram_model}-gram_rank-frequency-graph"
