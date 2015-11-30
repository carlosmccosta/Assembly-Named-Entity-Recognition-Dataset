#!/usr/bin/env sh

output_file=${1:?'Must specify output file'}
ngram_model=${2:-3}
smoothing=${3:-1}
number_sentences=${4:-100}

echo "\n\n >>> Performing sentence generation using file ${output_file} for ${ngram_model}-gram"

ngram -lm "${output_file}_${ngram_model}-gram.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${output_file}_${ngram_model}-gram.sentences"
ngram -lm "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.sentences"
ngram -lm "${output_file}_${ngram_model}-gram_smoothing-witten-bell.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${output_file}_${ngram_model}-gram_smoothing-witten-bell.sentences"
ngram -lm "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.sentences"
