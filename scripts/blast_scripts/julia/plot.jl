using Pkg
Pkg.add("Plots")
Pkg.add("JLD2")
Pkg.add("StatsPlots")
Pkg.add("Distributions")


using Plots, JLD2
using StatsPlots, Distributions

load_string = "/dos/WHOI/V6_V8_Analysis/het_bac/results/jld_workspaces/24_Mar_df.jld2"
@load load_string df times usim bact_fullsort


## Interactive Countmap
Pkg.add("Interact")
Pkg.add("Blink")
using StatsPlots, Interact
using Blink

w = Window()
body!(w, dataviewer(seqCounts))

bar(countmap(seqCounts.domain[ind_sim]))
bar(countmap(seqCounts.order[ind_sim])))
countmap(seqCounts.phylum[ind_sim])
countmap(seqCounts.family[ind_sim])
countmap(seqCounts.class[ind_sim])
countmap(seqCounts.species[ind_sim])


##
plot(df.date,df.sum,
    xlabel = "Time (YYYY-MM-DD)",
    ylabel ="Raw Sequence Abundance",
    legend = false,
    markershape = :circle,
    markersize = 4,
    markeralpha = 0.6,
    markercolor = :red,
    markerstrokewidth = 1,
    markerstrokealpha = 0.2,
    markerstrokecolor = :red,
    markerstrokestyle = :dot,
    minorticks = true,
    grid = true
)

savefig("/dos/WHOI/V6_V8_Analysis/het_bac/results/ucyn_a_plots/24_Mar_raw_abundance.png")

plot(df.date,df.sum,
    xlabel = "Time (YYYY-MM-DD)",
    ylabel ="Raw Sequence Abundance",
    legend = false,
    markershape = :circle,
    markersize = 4,
    markeralpha = 0.6,
    markercolor = :red,
    markerstrokewidth = 1,
    markerstrokealpha = 0.2,
    markerstrokecolor = :red,
    markerstrokestyle = :dot,
    minorticks = true,
    xticks = ()
)
savefig("/dos/WHOI/V6_V8_Analysis/het_bac/results/ucyn_a_plots/24_Mar_raw_abundance.png")


plot(df.date,(df.sum./df.cumsum),
    xlabel = "Time (YYYY-MM-DD)",
    ylabel ="Cummulative Sum Scaled Sequence Abundance",
    legend = false,
    markershape = :circle,
    markersize = 4,
    markeralpha = 0.6,
    markercolor = :red,
    markerstrokewidth = 1,
    markerstrokealpha = 0.2,
    markerstrokecolor = :red,
    markerstrokestyle = :dot,
    minorticks = true,
    title = "Chrysocromulina Sequence Abundance"
)

savefig("/dos/WHOI/V6_V8_Analysis/het_bac/results/ucyn_a_plots/24_Mar_css_abundance_chryso.png")




plot(df.date,(df.sum./df.logcumsum),
    xlabel = "Time (YYYY-MM-DD)",
    ylabel ="Log-Transformed Cummulative Sum Scaled Sequence Abundance",
    legend = false,
    markershape = :circle,
    markersize = 4,
    markeralpha = 0.6,
    markercolor = :red,
    markerstrokewidth = 1,
    markerstrokealpha = 0.2,
    markerstrokecolor = :red,
    markerstrokestyle = :dot,
    minorticks = true,
    yguidefontsize=8,
    title = "Chrysocromulina Sequence Abundance"
)

savefig("/dos/WHOI/V6_V8_Analysis/het_bac/results/ucyn_a_plots/24_Mar_log_css_abundance_chryso.png")

CSV.write("/home/miras/df.csv", df)
