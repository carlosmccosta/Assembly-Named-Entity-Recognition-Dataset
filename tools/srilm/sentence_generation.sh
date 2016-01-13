#!/usr/bin/env sh

output_file=${1:?'Must specify output file'}
ngram_model=${2:-3}
smoothing=${3:-1}
number_sentences=${4:-100}

echo "\n\n >>> Performing sentence generation using file ${output_file} for ${ngram_model}-gram"

ngram -lm "${output_file}_${ngram_model}-gram.lm" -order ${ngram_model} -gen-prefixes "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" -memuse > "${output_file}_${ngram_model}-gram.sentences"
ngram -lm "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.lm" -order ${ngram_model} -gen-prefixes "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" -memuse > "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.sentences"
ngram -lm "${output_file}_${ngram_model}-gram_smoothing-witten-bell.lm" -order ${ngram_model} -gen-prefixes "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" -memuse > "${output_file}_${ngram_model}-gram_smoothing-witten-bell.sentences"
ngram -lm "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.lm" -order ${ngram_model} -gen-prefixes "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" -memuse > "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.sentences"
ngram -lm "${output_file}_${ngram_model}-gram_smoothing-modified-kneser-ney.lm" -order ${ngram_model} -gen-prefixes "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" -memuse > "${output_file}_${ngram_model}-gram_smoothing-modified-kneser-ney.sentences"

paste -d " " "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" "${output_file}_${ngram_model}-gram.sentences" > "${output_file}_${ngram_model}-gram.sentences_merged"
paste -d " " "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.sentences" > "${output_file}_${ngram_model}-gram_smoothing-${smoothing}.sentences_merged"
paste -d " " "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" "${output_file}_${ngram_model}-gram_smoothing-witten-bell.sentences" > "${output_file}_${ngram_model}-gram_smoothing-witten-bell.sentences_merged"
paste -d " " "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.sentences" > "${output_file}_${ngram_model}-gram_smoothing-kneser-ney.sentences_merged"
paste -d " " "${output_file}_${ngram_model}-gram.count_sorted_sentences_prefixes" "${output_file}_${ngram_model}-gram_smoothing-modified-kneser-ney.sentences" > "${output_file}_${ngram_model}-gram_smoothing-modified-kneser-ney.sentences_merged"
