use strict;
use warnings;

my $input = "dsHET_prun.ped";
my $output = "dsHOM_prun.ped";
open(IN,"<",$input);
open(OUT,">",$output);

while (my $line=<IN>){
	chomp $line;
	my ($ind, $geno) = $line =~/(\S+\s?\S+\s?\S+\s?\S+\s?\S+\s?\S+)\s?(.+)/;
	print OUT $ind, "\t";
	my @geno = split /\s/, $geno;
	my $size = scalar(@geno);

	#print $geno[0], $geno[1], $geno[2], "\n"; # checking

	for(my $i=0; $i<$size; $i+=2){
		my $g;
		my $pick;
		my $a1 = $geno[$i];
		my $a2 = $geno[$i+1];
		if($a1 eq $a2){
			$g = $a1;
		} 
		else{
			$pick = int(rand(2));
			my @array;
			push(@array,$a2);
			push(@array,$a1);
			$g = $array[$pick];			
		}		
		
		print OUT $g," ", $g, "\t";
	}
	print OUT "\n";
}