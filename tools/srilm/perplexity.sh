#!/usr/bin/env sh

text_file=${1:?'Must specify text file'}
output_file=${2:?'Must specify output file'}
ngram_model=${3:-3}
smoothing=${4:-1}
debug=${5:-0}

echo "\n\n >>> Computing perplexity using files ${text_file}_train.txt and ${text_file}_test.txt for ${ngram_model}-gram"

ngram -lm "${output_file}_train_${ngram_model}-gram.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${output_file}_test_${ngram_model}-gram.ppl"
ngram -lm "${output_file}_train_${ngram_model}-gram_smoothing-${smoothing}.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${output_file}_test_${ngram_model}-gram_smoothing-${smoothing}.ppl"
ngram -lm "${output_file}_train_${ngram_model}-gram_smoothing-witten-bell.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${output_file}_test_${ngram_model}-gram_smoothing-witten-bell.ppl"
ngram -lm "${output_file}_train_${ngram_model}-gram_smoothing-kneser-ney.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${output_file}_test_${ngram_model}-gram_smoothing-kneser-ney.ppl"
