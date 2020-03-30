##loading packages
using Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("Statistics")
Pkg.add("JLD2")
Pkg.add("TimeSeries")

using DataFrames, CSV, Statistics,JLD2, TimeSeries

#input
base_path = "/dos/WHOI/V6_V8_Analysis/het_bac/"

seq_source = string(base_path, "/data/mvco_seqcounts.tsv")
seqCounts = DataFrame(CSV.File(seq_source; delim ='\t'))

blast_path = string(base_path, "/results/results_mvco_seq_22_mar.out")
blast_result = DataFrame(CSV.File(blast_path,delim ='\t',header = false))
blast_col = ["qseqid", "sseqid" ,"pident" ,"length", "mismatch","gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore"];
names!(blast_result, Symbol.(blast_col))

time_path = string(base_path, "/data/time/MVCO_Filter_and_Processed_Log.csv")
times  = DataFrame(CSV.File(time_path,delim =',',header = true))

first(times)
bact_fullsort=0
save_string = string(base_path,"results/jld_workspaces/24_Mar_ws.jld2")
@save save_string
