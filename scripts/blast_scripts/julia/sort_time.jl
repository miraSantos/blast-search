using Pkg
Pkg.add("JLD2")
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("StatsBase")
Pkg.add("TimeSeries")
Pkg.add("IterableTables")
using JLD2, DataFrames, CSV
using StatsBase
using TimeSeries
using IterableTables

base_path = "/dos/WHOI/V6_V8_Analysis/het_bac/"
load_string = string(base_path,"results/jld_workspaces/23_Mar_ws.jld2")
@load load_string seqCounts blast_result times

sim_threshold = 97.0;

ucyn_match = findall(blast_result.sseqid .=="MH807559.1")#UCYNA
big_match = findall(blast_result.sseqid .=="AB847985.2") #Bigelowii chloroplast
sim_match = findall((blast_result.pident .>= sim_threshold))

usim_match = intersect(ucyn_match,sim_match)
bsim_match =  intersect(big_match,sim_match)

usim = blast_result.qseqid[usim_match];
bsim= blast_result.qseqid[bsim_match]; #row indices of matches

ind_sim = bsim
bar(countmap(seqCounts.domain[ind_sim]))
bar(countmap(seqCounts.phylum[ind_sim]))
bar(countmap(seqCounts.class[ind_sim]))
bar(countmap(seqCounts.order[ind_sim]))
bar(countmap(seqCounts.family[ind_sim]))
bar(countmap(seqCounts.genus[ind_sim]))
bar(countmap(seqCounts.species[ind_sim]))

from lter sequence data do these sequences show up offshore
is mvco prone do that much stratification

##
names(seqCounts)[1:end-13]
#extracting original indices of sorted event number column names
ii_sorted = sortperm(names(seqCounts)[1:end-13])
bact_evntsort = seqCounts[:,ii_sorted]
bact_events = names(bact_evntsort)
#appending sorted index list with indcies of categorical column names that weren't sorted
jj_sorted = append!(ii_sorted,collect(length(names(seqCounts))-12:length(names(seqCounts))))
#creating new sorted object
bact_fullsort = seqCounts[:,jj_sorted]


## incorporating time
dformat = Dates.DateFormat("mm/dd/yyyy");
typeof(times.date)
size(times.date)
times.date = Dates.Date.(times.date, dformat)

df = DataFrame()
df.events = Vector{String}(undef,length(bact_events))
df.evnum = Vector{Float64}(undef,length(df.events))
df.date = Vector{Date}(undef,length(df.events))


df.sum = Vector{Float64}(undef,length(df.events))
df.cumsum = Vector{Float64}(undef,length(df.events))
df.logcumsum =Vector{Float64}(undef,length(df.events))
df.css_scaled = Vector{Float64}(undef,length(df.events))
df.log_css_scaled = Vector{Float64}(undef,length(df.events))


for ii in 1:length(names(bact_evntsort))
    df.events[ii] = string(names(bact_evntsort)[ii])
end

for ii in 1:length(names(bact_evntsort))
    df.sum[ii] = sum(bact_evntsort[ind_sim,ii])
end

##
seqCounts = 0
for ii in 1:length(bact_events)
    a = bact_evntsort[:,ii]
    b = a[a.!=0.0]
    c =cumsum(b)
    df.cumsum[ii] = quantile(c,.75)
end

for ii in 1:length(bact_events)
    a = bact_evntsort[:,ii]
    b = a[a.!=0.0]
    c =cumsum(log.(b))
    df.logcumsum[ii] = quantile(c,.75)
end
a = bact_evntsort[:,1]
b = a[a.!=0.0]
c =cumsum(b)
plot(cumsum(log.(b)))
quantile(c,.75)

plot(cumsum(b))
length(cumsum(b))
cumsum(b)[length(cumsum(b)*.75)]

##
for ii in 1:length(df.events)
    df.evnum[ii] = parse(Int,SubString(df.events[ii],3,5))
end

first(df)
length(df.sum)
length(times.event)
first(times)
last(times)

ind = findall(x -> x == df.evnum[106],times.event)
df.date[1]= times.date[ind[1],1]

for i in 1:139
    ind = findall(x -> x == df.evnum[i],times.event)
    df.date[i]= times.date[ind[1],1]
end

df.css_scaled = df.sum./df.cumsum
df.log_css_scaled = df.sum./df.logcumsum

## Saving JLD Workspace
@save "/dos/WHOI/V6_V8_Analysis/het_bac/results/jld_workspaces//25_Mar_df.jld2" df times usim bsim bact_fullsort

save_string1 = string(base_path,"results/jld_workspaces/23_Mar_bact_evntsort.jld2")
@save save_string1 bact_evntsort

save_string2 = string(base_path,"results/jld_workspaces/23_Mar_bact_fullsort.jld2")
@save save_string2 bact_fullsort
