#!/usr/bin/env sh

text_file=${1:?'Must specify text file'}
ngram_model=${2:-3}
smoothing=${3:-1}
number_sentences=${4:-100}

ngram -lm "${text_file}_${ngram_model}-gram.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${text_file}_${ngram_model}-gram.sentences"
ngram -lm "${text_file}_${ngram_model}-gram_smoothing-${smoothing}.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${text_file}_${ngram_model}-gram_smoothing-${smoothing}.sentences"
ngram -lm "${text_file}_${ngram_model}-gram_smoothing-witten-bell.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${text_file}_${ngram_model}-gram_smoothing-witten-bell.sentences"
ngram -lm "${text_file}_${ngram_model}-gram_smoothing-kneser-ney.lm" -order ${ngram_model} -gen ${number_sentences} -memuse > "${text_file}_${ngram_model}-gram_smoothing-kneser-ney.sentences"
