#!/usr/bin/env bash

text_file=${1:?'Must specify text file'}
ngram_model=${2:-3}
smoothing=${3:-1}

ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -addsmooth 0 -lm "${text_file}_${ngram_model}-gram.lm" -write${ngram_model} "${text_file}_${ngram_model}-gram.count" -write-vocab "${text_file}_${ngram_model}-gram.vocab" -memuse
ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -addsmooth ${smoothing} -lm "${text_file}_${ngram_model}-gram_smoothing-${smoothing}.lm" -write${ngram_model} "${text_file}_${ngram_model}-gram_smoothing-${smoothing}.count" -write-vocab "${text_file}_${ngram_model}-gram_smoothing-${smoothing}.vocab" -memuse
ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -wbdiscount -interpolate -lm "${text_file}_${ngram_model}-gram_smoothing-witten-bell.lm" -write${ngram_model} "${text_file}_${ngram_model}-gram_smoothing-witten-bell.count" -write-vocab "${text_file}_${ngram_model}-gram_smoothing-witten-bell.vocab" -memuse
ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -ukndiscount -interpolate -lm "${text_file}_${ngram_model}-gram_smoothing-kneser-ney.lm" -write${ngram_model} "${text_file}_${ngram_model}-gram_smoothing-kneser-ney.count" -write-vocab "${text_file}_${ngram_model}-gram_smoothing-kneser-ney.vocab" -memuse

sort -t$'\t' -k2nr -s "${text_file}_${ngram_model}-gram.count" > "${text_file}_${ngram_model}-gram.count_sorted"
