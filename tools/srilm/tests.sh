ngram-count -text corpus.txt -order 2 -write corpus.count
ngram-count -text corpus.txt -order 2 -addsmooth 0 -lm corpus.lm
ngram -lm corpus.lm -ppl test_corpus.txt -debug 2
ngram -lm corpus.lm -ppl test_corpus2.txt -debug 2
ngram-count -text corpus.txt -order 2 -addsmooth 1 -write corpus_laplace.count -lm corpus_laplace.lm
ngram -lm corpus_laplace.lm -ppl test_corpus.txt
ngram -lm corpus_laplace.lm -ppl test_corpus2.txt
ngram-count -text /home/linux/ieng6/ln165w/public/data/wsj_1994_train.txt -vocab /home/linux/ieng6/ln165w/public/data/wsj_1994_lexicon.txt -order 2 -addsmooth 1 -lm wsj2.lm
ngram-count -text /home/linux/ieng6/ln165w/public/data/wsj_1994_train.txt -vocab /home/linux/ieng6/ln165w/public/data/wsj_1994_lexicon.txt -order 1 -addsmooth 0.0001 -lm wsj1.lm
ngram -lm wsj2.lm -mix -lm wsj1.lm -lambda 0.5 -ppl /home/linux/ieng6/ln165w/public/data/wsj_1994_dev.txt

wc Mechanical-Gearbox-repair-manual.txt



function generate_discount_args {
	args="$1""1"
	argn=2
	while [ $argn -le $2 ]; do
		args="$args $1$argn"
		let argn+=1
	done
	echo $args
}

wb_discount=$(generate_discount_args '-wbdiscount' ${ngram_model})
kn_discount=$(generate_discount_args '-ukndiscount' ${ngram_model})



--------------------------------------------- smoothing
We see that maximum likelihood estimation gives zero probabilities for word sequences that have not occurred in the training data. In speech recognition this may be a problem, because sentences with zero probability can not be recognized. That is the reason why smoothing is used.
The idea of smoothing is to give some probability mass to n-grams that have not occurred in the training data. Thus, probability mass has to be taken from n-grams that occur in the training data. There are several smoothing methods, but here we consider absolute discounting with interpolation


-count-lm
Jelinek-Mercer

-addsmooth 1
gaussian

-cdiscountn
Ney's absolute discounting






regex:

