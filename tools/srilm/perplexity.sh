#!/usr/bin/env sh

text_file=${1:?'Must specify text file'}
ngram_model=${2:-3}
smoothing=${3:-1}
debug=${4:-0}

ngram -lm "${text_file}_train_${ngram_model}-gram.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${text_file}_test_${ngram_model}-gram.ppl"
ngram -lm "${text_file}_train_${ngram_model}-gram_smoothing-${smoothing}.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${text_file}_test_${ngram_model}-gram_smoothing-${smoothing}.ppl"
ngram -lm "${text_file}_train_${ngram_model}-gram_smoothing-witten-bell.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${text_file}_test_${ngram_model}-gram_smoothing-witten-bell.ppl"
ngram -lm "${text_file}_train_${ngram_model}-gram_smoothing-kneser-ney.lm" -order ${ngram_model} -ppl "${text_file}_test.txt" -debug ${debug} -memuse > "${text_file}_test_${ngram_model}-gram_smoothing-kneser-ney.ppl"
