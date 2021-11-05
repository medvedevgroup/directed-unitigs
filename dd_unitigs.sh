if [[ -z $1 || -z $2 ]] ;
then
	echo "required args: <fasta> <k>" 
	exit
fi

F=$1
# K=31
BASEDIR=$(dirname $(realpath $0))
for K in $2
do
   
	### FOR DOUBLE DIRECTED
	jellyfish count -m $K -s 100M -t 10 $F
	jellyfish dump -c mer_counts.jf > mer_counts_dumps.fa


	#cat kmersascii.txt | cut -f 1 -d"" \; > fwd_kmer.txt
	cat mer_counts_dumps.fa | cut -f 1 -d" " |  awk '{print $0" 1"}'  > dbg_fwd.txt
	cat dbg_fwd.txt | tr ACGTacgt TGCAtgca | rev | awk '{print $2 " " $1}' > dbg_bwd.txt
	cat dbg_fwd.txt dbg_bwd.txt | sort | uniq > dbg_both.txt
	echo "$(cat dbg_both.txt | wc -l)" > n_mer$K 
    $BASEDIR/dbcalm  dbg_both.txt dbg$K.txt 2
	
	#cat dbg$K.txt | tr a A | tr c C | tr g G | tr t T | tr -d \; > unid.act.$K.sset

	cat dbg$K.txt | tr a A | tr c C | tr g G | tr t T | tr -d \; > unid$K.sset
	
    #python $BASEDIR/keep_canonical.py unid$K.sset unid$K.canon.sset
	#cat unid$K.canon.sset | sort | uniq > unid$K.sset
    $BASEDIR/sset_to_fa.sh unid$K.sset > uni_dd.fa

	
done


rm unid$K.sset
rm mer_counts.jf 
rm mer_counts_dumps.fa 
rm largest_bucket.dot 
rm dbg_fwd.txt 
rm dbg_bwd.txt
rm dbg_both.txt  
rm dbg$K.txt 

