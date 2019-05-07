using BioAlignments
using BioSequences
using Statistics
using Random

Random.seed!(1)

const seq = "MRAKWRKKRMRRLKRKRRKMRQRSK"
const seq_len = length(seq)
const index = collect(1:seq_len)

const gap_len = 5
to_delete = rand(1:seq_len-gap_len)

const keep = [i for i in 1:seq_len if !(i in to_delete:(to_delete + gap_len))]
const incomplete_seq = seq[keep]

to_delete = to_delete + div(gap_len, 2)

const keep_2 = [i for i in 1:seq_len if !(i in to_delete:(to_delete + gap_len))]
const incomplete_seq_2 = seq[keep_2]

aln = pairalign(GlobalAlignment(), incomplete_seq, incomplete_seq_2, AffineGapScoreModel(match=10,
                    mismatch=-10, gap_open=-2, gap_extend=-1))


aln

errors = 0
pos_i = 0
pos_j = 0
for (i, j) in alignment(aln)
    if i != '-'
        global pos_i += 1
    end
    if j != '-'
        global pos_j += 1
    end
    if j != '-' && i != '-' && keep[pos_i] != keep_2[pos_j]
        global errors += 1
    end
end

errors

using Hyperopt

function do_aln(seq, incomplete_seq, gap_open, gap_extend)
    pairalign(GlobalAlignment(),
              seq,
              incomplete_seq,
              AffineGapScoreModel(match=10,
                                  mismatch=-10,
                                  gap_open=gap_open,
                                  gap_extend=gap_extend))
end

function aln_error(aln, keep, keep_2)
    errors = 0
    pos_i = 0
    pos_j = 0
    for (i, j) in alignment(aln)
        if i != '-'
            pos_i += 1
        end
        if j != '-'
            pos_j += 1
        end
        if j != '-' && i != '-' && keep[pos_i] != keep_2[pos_j]
            errors += 1
        end
    end
    errors / length(keep_2)
end

function to_optimize(incomplete_seq, incomplete_seq_2, keep, keep_2, gap_open, gap_extend)
    aln = do_aln(incomplete_seq, incomplete_seq_2, gap_open, gap_extend)
    aln_error(aln, keep, keep_2)
end

ho = @hyperopt for i=100,
            sampler=RandomSampler(),
            gap_open = -10.0:0.01:0.0,
            gap_extend = -10.0:0.01:0.0

   print(i, "\t", gap_open, "\t", gap_extend, "\t")
   @show to_optimize(incomplete_seq, incomplete_seq_2, keep, keep_2, gap_open, gap_extend)
end

best_params, min_f = minimum(ho)

ho
using Plots
scatter([ x for (x, _) in ho.history], [ y for (_, y) in ho.history], ho.results, xlab="gopen")

using BlackBoxOptim

function to_optimize(x)
    aln = do_aln(incomplete_seq, incomplete_seq_2, x[1], x[2])
    1.0 - aln_error(aln, keep, keep_2)
end

res = bboptimize(to_optimize, SearchRange = [(-10., 0.), (-10., 0.)])
res

best_candidate(res)
best_fitness(res)

using NLopt


function to_optimize(x, g)
    aln = do_aln(incomplete_seq, incomplete_seq_2, x[1], x[2])
    err = aln_error(aln, keep, keep_2)
    println(x[1], " ", x[2], " ", err)
    err
end

const opt = Opt(:GN_CRS2_LM, 2)
opt.lower_bounds = [-10., -10.]
opt.upper_bounds = [-0., -0.]
opt.xtol_rel = 1e-24
opt.maxtime = 60 * 3
opt.min_objective = to_optimize

opt

(minf,minx,ret) = optimize(opt, [-1.0, -1.0])
numevals = opt.numevals # the number of function evaluations
println("got $minf at $minx after $numevals iterations (returned $ret)")

to_optimize([-1.0, -1.0])
to_optimize([best_candidate(res)[1], best_candidate(res)[2]])
