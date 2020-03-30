## Loading in Data
using Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("Bio")
Pkg.add("BioTools")
Pkg.add("FastaIO")

using DataFrames, CSV
using Bio,BioTools,FastaIO

#INPUT
#base_path = "D:/WHOI/V6_V8_Analysis/het_bac/"
base_path = "/dos/WHOI/V6_V8_Analysis/het_bac/"
source = string(base_path, "/data/mvco_seqcounts.tsv")
seqCounts = DataFrame(CSV.File(source; delim = '\t'))

#OUTPUT
fasta_path = string(base_path,"/data/fasta_data/mvco_blast_num_test_run.fasta")

fs = Dict()
for (n, f) in enumerate(seqCounts.Sequence)
   fs["$(n)"] = f
end

FastaWriter(fasta_path) do fw
    for (n,f) in fs
        writeentry(fw, n, f)
    end
end

