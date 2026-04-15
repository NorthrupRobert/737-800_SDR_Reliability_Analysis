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
