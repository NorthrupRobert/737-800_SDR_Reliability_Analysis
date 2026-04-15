🔥 1. Repeat Write‑Up Analysis (Tail‑Number Clustering)

This is the #1 thing reliability engineers look for.

Visualization:

    A bar chart or heatmap showing tail number × ATA or tail number × component

    Highlighting aircraft with repeat failures

Why it matters:

    Shows chronic aircraft

    Shows rigging drift

    Shows environmental bleed issues

    Shows aging aircraft patterns

This is the missing piece that would make your analysis feel real.
🔥 2. MTBF‑Style Trend (Failure Rate Over Time)

Even if you don’t have flight hours, you can approximate:

    failures per month

    failures per 100 SDRs

    failures per ATA per month

Visualization:

    Line graph: ATA 21 / ATA 52 / ATA 28 failure rate over time

Why it matters:

    Reliability teams think in rates, not raw counts

    Shows whether the system is improving or degrading

🔥 3. Failure Mode Pareto Chart (AC)

You already have failure modes — now show them as a Pareto.

Visualization:

    Bar chart sorted descending

    Cumulative % line

Why it matters:

    This is the single most common reliability visualization

    Shows the “vital few” failure modes

    Perfect for AC odor/smoke, door rigging, fuel indication





# Dashboard 1 — Fleet Overview
- * Sev‑3 pie chart (AC 13%, Landing gear 10.5%, fuel 10%, Doors 10%, Other 57%)
- * ATA trend line (Top Grounding Systems Do Not Show Seasonality)
- * Failed Parts by Frequency (shows MOST grouding events are CND'd across fleet)
-  * Highest grounding and discrepancy atas bar chart (shows ac as top)
- * CND scorecard (9%, -1% from last year)
- * Grounding events scorecard (748, up from 655 in 2024 and 421 in 2023 -- doesn't show relationship to # of flights?)
- MTBF‑style failure rate line
- KPIs 
    * CND Rate
    * MTBF
    * Sev-3 Rate (grounding rate)
    * Grounds/year
2. Anchor AOGs in operational/monetary impact
You’re right to want this, but you don’t need a perfect dollar figure to make it meaningful.
You can do:
Qualitative framing:
“Each AOG event typically drives reroutes, missed connections, crew disruptions, and customer recovery costs.”
Order‑of‑magnitude estimate:  
Use a conservative industry rule of thumb (e.g., “AOG events often cost airlines several thousand dollars per occurrence”) and phrase it as:
“Assuming a conservative $X per AOG event, this trend represents an estimated $Y in avoidable operational exposure.”
You don’t need exact accounting—just show you understand that AOG ≈ expensive.
3. Find where CNDs are concentrated
Your idea:
“heatmap of part failure by ata”
Yes. Make it:
Rows: ATA
Columns: Failure category (CND vs non‑CND, or part group)
Color: CND rate or CND count
Then you can say:
“CNDs are heavily concentrated in AC and [other ATAs], indicating intermittent or hard‑to‑reproduce faults.”
That ties directly into your AC deep dive.
4. Better way to show grounding/discrepancy ratio + frequency
You’re looking for a single visual that shows both:

how often a system is written up
how often it actually grounds the aircraft
That’s a scatter plot:
X‑axis: Discrepancy count (how often it’s written up)
Y‑axis: Grounding count (how often it actually AOGs)
Each point: ATA
Color/size: CND rate or severity mix (optional)
Then you can immediately see:
Top‑right: high discrepancy, high AOG → operationally painful systems
High X, low Y: noisy but not grounding → nuisance systems
Low X, high Y: rare but severe → high‑impact systems
This gives you exactly what you want: ratio + frequency + prioritization in one view.
5. KPIs for bird’s‑eye fleet health
Your list is good:
CND rate
MTBF (and vs last year)
AOG count (and vs last year)
Two tweaks:
Normalize where you can.  
If you can’t get flights or block hours, you can still say:
“All metrics are shown as raw counts; in production, these would be normalized by flight hours or departures.”
That shows you know what should be done, even if you don’t have the data.
Make the KPIs comparative.  
Instead of just “CND rate: 35%”, show:
CND rate: 35% (+X% vs last year)
AOGs: N (+Y vs last year)
MTBF: Z days (–W vs last year)
Even if “last year” is just the first half of your time series vs the second half, you can define it clearly.
6. MTBF trend—how to do it
Conceptually:
MTBF = total operating time / number of failures
You don’t have flight hours, but you can approximate:
Use days between Sev‑3 events fleet‑wide or per ATA
Or use event index as a pseudo‑time axis and compute average gap
Simpler: for portfolio purposes, you can:
Compute rolling 3‑month failure rate (events per month)
invert it conceptually as “effective MTBF trend” and label it clearly:
“Fleet‑level Sev‑3 event rate over time (proxy for MTBF; lower is better).”
You don’t need textbook MTBF to show you understand the concept and trend.
7. Key, head‑turning beautiful insight
For Dashboard 1, that insight should be system‑level, not tail‑level.
Something like:
“Four systems (AC, doors, landing gear, fuel) account for X% of all grounding events, despite representing only Y% of discepancies.”
Or:
“AC and doors generate a disproportionate share of grounding events relative to their discrepancy volume, making them high‑leverage targets for reliability improvement.”
That’s the kind of line you can literally bold in your README.
8. List of outlier tails to address
You’re right: that belongs in the tail‑hotspot dashboard, not the fleet overview.
For Dashboard 1, you can just tease it:
“Fleet‑level analysis reveals a small number of tail‑specific outliers, explored in Dashboard 4.”
That keeps Dashboard 1 focused on systems, not individual aircraft.

# Dashboard 2 — AC Deepdive
- * AC treemap of failure parts (lots of CND)
- * AC subsystem heatmap x severity x frequency (46% of grounding caused by ac dist)
- * AC subsystem fialure Pareto (high ac dist)
- * CND Scorecard for grounding (35%)

# Dashboard 3 — Door System Deepdive
- * Bar chart of highest overall occuring grounding JASC (shows passenger/crew door highest)
- * Door part failure x failure mode heatmap
- * Door part failures pareto chart
  * Door jasc failures pareto chart
- Sev‑3 failed part bar chart
- ATA → JASC treemap
- Sankey (optional)
- Additional Pareto charts

# Dashboard 4 — Tail‑Number Hotspots
- * Aircraft × ATA heatmap (only show top failing planes for that ata)
- * Bar chart of all tails in fleet by grounding fuel discrepancies, highlighting two tails with 22x fleet average
- Fleet average column
- Top hotspot aircraft table
- Tail‑specific drill‑downs
- A. Tail‑specific rate vs fleet average (the strongest story)
    This is the punchline:
        Each aircraft has ~23× more Sev‑3 fuel issues than the fleet average.
    This is the kind of insight that gets engineering attention immediately.
    How to show it:
    A simple bar chart:
        X‑axis: Aircraft tail
        Y‑axis: Sev‑3 fuel issues
        Highlight the two tails in red
        Add a reference line at the fleet average (0.62)
    This visually screams “outlier.”
- B. Contribution to total fuel issues (secondary story)
    This is the waffle chart story:
        Two aircraft represent 15% of all Sev‑3 fuel issues.
    This is visually powerful but less operationally meaningful than the rate ratio.
    Still worth showing.
- C. Distribution shape (statistical story)
    Plot a histogram of Sev‑3 fuel issues per aircraft.
    You will see:
        95% of aircraft at 0–1
        A long tail
        Two extreme outliers at 14
    This is reliability gold.
1. Identify aircraft that are “fleet liabilities”
This is the core purpose of a tail‑hotspot dashboard.
You already have the fuel outliers (14 events each).
But you can expand the concept:
Tails with high Sev‑3 counts across ANY system
Tails with high CND rates
Tails with repeat writeups
Tails with multi‑system failures
Tails with age‑correlated issues
Tails with increasing failure trend over time
This is the “problem aircraft” dashboard — the one engineering managers care about most.
2. Show cross‑system tail behavior (the thing your system dashboards cannot do)
Your AC dashboard shows AC tail patterns.
Your Door dashboard shows Door tail patterns.
Your Fuel dashboard shows Fuel tail patterns.
But none of them answer:
“Which tails are bad across multiple systems?”
This is where the tail‑hotspot dashboard shines.
You can build:
Tail × ATA heatmap (already in your list)
This is gold.
It shows:
Tails with multi‑system issues
Tails that are “noisy” across the fleet
Tails that are “quiet” (healthy aircraft)
This is a fleet‑level reliability fingerprint.
3. Show tail‑level risk concentration
This is where you can add real value:
% of total Sev‑3 events contributed by top 5 tails
% of total CNDs contributed by top 5 tails
% of total AOGs contributed by top 5 tails
This answers:
“Is the fleet problem systemic or tail‑specific?”
If 5 tails cause 30% of AOGs → that’s a tail problem.
If every tail contributes evenly → that’s a system problem.
This is a strategic insight hiring managers love.
4. Tail Profile Cards (YES — but only here)
You were right to consider this.
A tail‑profile card belongs only in the tail‑hotspot dashboard because:
It’s aircraft‑centric
It summarizes multi‑system behavior
It gives engineering a “case file” for each bad actor
A good tail profile card includes:
Tail number
Age / serial number
Total Sev‑3 events
Sev‑3 by ATA
CND rate
Repeat writeups
Trend over time
“Most problematic system”
“Most common failure mode”
“Recommended next action”
This is the closest thing to a reliability engineering deliverable in your entire project.
5. Root‑Cause Hypotheses (YES — but only for tails, not systems)
System dashboards show system‑level patterns.
Tail dashboards show aircraft‑specific hypotheses, like:
Age‑related wiring degradation
Fuel probe/compensator drift
Recurrent pack controller faults
Door sensor misalignment
Hydraulic leak patterns
Engine bleed air contamination
These hypotheses belong in the tail dashboard because they’re aircraft‑specific, not system‑wide.
6. Show “fleet health distribution”
This is where your histogram shines:
95% of aircraft at 0–1 Sev‑3 fuel issues
Long tail
Two extreme outliers at 14
This is a statistical story, not a system story.
It belongs in the tail dashboard.
⭐ So what is the unique purpose of the Tail‑Hotspot dashboard?
Here’s the clean, portfolio‑ready answer:
“The Tail‑Hotspot dashboard reframes the fleet through the lens of aircraft‑specific reliability risk. While system dashboards identify which ATA/JASC combinations drive failures, the tail dashboard identifies which individual aircraft disproportionately contribute to operational disruptions. This enables targeted engineering interventions, inspections, and maintenance actions.”
That’s the justification.
That’s the differentiator.
That’s why it belongs.
