#!/usr/bin/env bash

text_file=${1:?'Must specify text file'}
output_file=${2:?'Must specify output file'}
ngram_model=${3:-3}
smoothing=${4:-1}

echo -e "\n\n"
echo -e ">>> Performing word count using file ${text_file}.txt for ${ngram_model}-gram"

ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -addsmooth 0 -lm "${output_file}_${ngram_model}-gram.lm" -write${ngram_model} "${output_file}_${ngram_model}-gram.count" -write-vocab "${output_file}_${ngram_model}-gram.vocab" -memuse
ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -addsmooth ${smoothing} -lm "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.lm" -write${ngram_model} "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.count" -write-vocab "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.vocab" -memuse
ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -wbdiscount -interpolate -lm "${output_file}_${ngram_model}-gram_smoothing-witten-bell.lm" -write${ngram_model} "${output_file}_${ngram_model}-gram_smoothing-witten-bell.count" -write-vocab "${output_file}_${ngram_model}-gram_smoothing-witten-bell.vocab" -memuse
ngram-count -text "${text_file}.txt" -order ${ngram_model} -sort -tolower -ukndiscount -interpolate -lm "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.lm" -write${ngram_model} "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.count" -write-vocab "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.vocab" -memuse

sort -t$'\t' -k2nr -s "${output_file}_${ngram_model}-gram.count" > "${output_file}_${ngram_model}-gram.count_sorted"
cat "${output_file}_${ngram_model}-gram.count_sorted" | grep "<s>" | awk -F "\t" '{print $1}' > "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes"
