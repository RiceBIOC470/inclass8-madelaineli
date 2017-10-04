%AW: looks good. See comment below. 1/1.

%Inclass assignment 8

%Using the swalign function
% A. Create a random DNA sequence of length 100. 
randomseq = randseq(100);
% B. Create a second sequence from the first one by changing the middle 20 basepairs (at positions 41-60)
randomseq_mid = randseq(20);
randomseq_mt = strcat(randomseq(1:40),randomseq_mid,randomseq(61:100));
% C. run swalign on the two sequences with the default parameters
[score, align, start] = swalign(randomseq,randomseq_mt,'Alphabet','nt','Showscore',true);
score
align
start
% D. run swalign with much higher and lower values of the GapOpen parameter
% and explain the results. 
% higher
[score, align, start] = swalign(randomseq,randomseq_mt,'Alphabet','nt','GapOpen',20,'Showscore',true);
score
align
start
% lower
[score, align, start] = swalign(randomseq,randomseq_mt,'Alphabet','nt','GapOpen',2,'Showscore',true);
score
align
start

%AW: this is ok, but what is important is that one configuration favors
% placing gaps in teh sequence and the other favors mismatching without gaps. 

% Having a high penalty limits the algorithm to match the base pairs
% from 41-60 bp because we would have to skip a base pair/delete a base
% pair in order to match 41-60bp between the two sequences, which leads to 
% high penalty. Because of the high penalty, the algorithm opts for not 
% matching these bp, and thus the score turns out to be lower than that of 
% default. The scoring space has less area under red. For low penalty, the 
% algorithm has more flexibility, and tends to skip/delete more base pairs in 
% order to match more bp in 41-60 bp. Thus, the score is 
% higher than that of the default, and the scoring space has more area under red.

% E. run swalign with a low value of GapOpen but a high value of ExtendGap,
% explain the result
[score, align, start] = swalign(randomseq,randomseq_mt,'Alphabet','nt','GapOpen',2,...
    'ExtendGap',10,'Showscore',true);
score
align
start
% Here, instead of having consecutive gaps in 41-60bp, we have more base
% pairs that are in the "matched, unmatched, matched, unmatched" pattern.
% Because having a gap of 1bp only leads to the low penalty(GapOpenValue),
% while having a gap of 2bp leads to low penalty + high
% penalty(GapOpenValue + ExtendGapValue), the algorithm tends to find a
% match following a 1bp gap. Thus, we don't have big gaps as we did in
% default, instead, we have more small gaps of 1bp. And thus we wouldn't
% have a winning path with gaps as big as that of low penalty. The winning
% path is more continuous than the low penalty one, while the score doesn't
% differ as much from that of low penalty. 

% F. run swalign align with the default value of GapOpen and a low value
% of ExtendGap and explain the result. 
[score, align, start] = swalign(randomseq,randomseq_mt,'Alphabet','nt',...
    'ExtendGap',2,'Showscore',true);
score
align
start
% This set of value means that once the algorithm starts a gap, it tends to
% continue the gap, but it wouldn't want to start a gap unless it
% absolutely has to, and there's no way around it. We get larger gaps in
% 41-60 as compared to previous condition. The score is not very far away
% from the previous one as well, but the scoring space has larger area in
% red compared to the previous one, because it doesn't hurt as much to walk
% away from the winning path, since once the gap is already started, the
% next penalties are much lower than the first one. So walking away from
% the winning path wouldn't return a score as low as the previous one,
% which gives the larger shade of red around the winning path. 
