<p align="center">
  <img src="/assets/aa logo.png" width="600">
</p>

# American Airlines 737-800 Safety Failure, Maintenance, and Reliability Analysis (IN PROGRESS)
### *Exploring Failure Patterns, Operator Trends, and Component Reliability Through JASC Taxonomy and Natural Language Processing (NLP)*

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active-brightgreen"></a>
  <img src="https://img.shields.io/badge/Focus-Aerospace-lightblue"></a>
  <img src="https://img.shields.io/badge/Database/Querying-PostgreSQL-white"></a>
  <img src="https://img.shields.io/badge/Analysis-Python-gold"></a>
  <img src="https://img.shields.io/badge/Visualization-Tableau-hotpink"></a>
  <img src="https://img.shields.io/badge/Updated-Mar%202026-lightgrey"></a>
</p>

---

## AUTHOR
**Robb Northrup**

Data Analytics | Aerospace | Community Impact

**Date** Feb 10, 2026 - PRESENT

<p align="center">
  <a href="https://linkedin.com/in/robb-northrup-463867382"><img src="https://img.shields.io/badge/LinkedIn-Connect-blue?style=for-the-badge&logo=linkedin"></a>
  <a href="https://github.com/NorthrupRobert"><img src="https://img.shields.io/badge/GitHub-Portfolio-black?style=for-the-badge&logo=github"></a>
  <a href="mailto:robbnorthrup@outlook.com"><img src="https://img.shields.io/badge/Email-Contact-green?style=for-the-badge&logo=gmail"></a>
</p>

---

## TABLE OF CONTENTS
1. [Executive Summary](#executive-summary)
2. [Background](#background)
3. [Data Structure Overview](#data-structure-overview)
4. [Insights Deep Dive](#insights-deep-dive)
5. [Recommended Actions](#recommended-actions)

---

## EXECUTIVE SUMMARY
**American Airlines** operates a fleet of Boeing 737‑800 aircraft and faces maintenance and reliability pressures that impact operational efficencies in grounded flights, diversions, and more. This repo anlyzes the systems on this airframe that are the primary drivers for high severity safety reports and unexpected maintenance procedures, and provides remedies to American Airlines to increase operational efficiency.

Using the FAA's Service Difficulty Reporting System (SDRS) as a proxy for American Airlines' (AA) real maintenance activity, this project builds an end‑to‑end pipeline that extracts, cleans, normalizes, and analyzes aircraft reliability data through ATA/JASC taxonomies, operator designators, and component‑level event patterns. The goal is to demonstrate how modern airlines can leverage data engineering and reliability analytics to improve fleet performance, reduce delays, and anticipate component failures.

### Problem Statement
**What maintenance actions can American Airlines implement in their 737‑800 fleet to target systems and failure modes that drive high operational disruption by reducing the operational impact of severe maintenance events through ATA and JASC taxonomy?**

### Objectives
To design a realistic, end‑to‑end reliability analytics workflow that transforms raw FAA SDR (Service Discrepancy Report) data into actionable insights for maintenance planning andcomponent risk assessment.

### Dashboards
- Component‑level failure frequency
- ATA/JASC chapter trends
- Operator‑level event distributions
- Time‑based reliability patterns
- High‑risk components and emerging failure modes

### Key Findings
**(To be completed as analysis progresses)**
- Most sev 3 discrepancies were CND'd and the component that caused the failure could not be identified
- Door failures comprise of the most component-specific failures, accounting for ___ failures in the last 3 years, __% of severity level 3 failures.
- The AC/Pressurization (-21) system is the biggest driver for Aircraft on Ground (AOG), diversions, and in Flight Emergency (IFE) events, closely followed by Landing Gear (-32).
- For every system writeup, AC (-21) has the highest concentration of high severity and grounding events.
- Failure modes for AC primarily centered around fault and fire.
- 47% of level 3 severity events were due to the AC Distribution System (JASC 2120)
- Failures for the AC system trended around the summer season
- Odor-related events in flight (burning smell, wet dog, etc.) contributed to the most AC grounding writeups
- Failures overwhelming could not be duplicated by maintenance, primarily for odor discrepancies, though the most

### Recommendations
1. **Request Engineering review for 2120** 
2. Review A, B, C checks for filters and other common grounding writeups... replace filters outright?
3. Impose internal limits on key valves during op chks to limit failures in these critical components for high severity events.

For further details, please see [Recommended Actions](#recommended-actions).

**Click here to access the Dashboards and Project Data**

---

## BACKGROUND
## SDRS overview
The FAA Service Difficulty Reporting System (SDRS) collects mandatory reports from Part 121, 125, 135, and 145 certificate holders on in‑service failures, malfunctions, and defects that endangered or could have endangered the aircraft. These reports include aircraft details, component information, time‑in‑service metrics, and narrative descriptions of the event. Routine maintenance actions are not reported; SDRs represent only safety‑significant failures. General Aviation submissions are voluntary and therefore under‑represented.

---

## DATA STRUCTURE OVERVIEW

### Tables
#### Core tables
| **Name** | **Features** |
| --- | --- |
| aircraft	| Tail numbers, model, age, cycles, hours |
| components |	Serialized components, ATA chapters, install/remove history |
| maintenance_events	| Work orders, discrepancies, corrective actions |
| failures	| Failure events tied to components |
| inventory	| Stock levels, reorder points, locations |
| suppliers	| Vendor info, performance metrics |
| purchase_orders |	Lead times, delays, backorders |

#### Analytical tables (materialized views or ETL outputs) 
| **Name** | **Features** |
| --- | --- |
| reliability_kpis | MTBF, MTTR, availability, repeat failures |
| supply_chain_kpis | Lead time, fill rate, backorder rate |
| maintenance_kpis | Scheduled vs unscheduled, downtime, labor hours |

### Data Model
![ERD](/data/00_ERDs/erd.png)

<p align="center">
  <span style="font-size:0.85em;"><em>Figure 1. ERD Model </em></span>
</p>

To view the full ERD, click [here](/data/00_ERDs/erd.png).

### Why Normalization Was Needed

The FAA SDR dataset is a real operational dataset, but it was never designed for analytics. Each SDR entry is a free‑form narrative written by a technician or flight crew member, and the structure varies widely across operators, aircraft, and time periods. Fields such as discrepancy text, part names, and failure descriptions contain inconsistent terminology, abbreviations, and formatting. Even structured fields like JASC codes, ATA chapters, and part identifiers often appear with missing values, typos, or operator‑specific conventions.

To perform meaningful reliability analysis, the data had to be normalized so that similar events could be compared consistently. This included:
- Standardizing ATA and JASC codes to ensure subsystem‑level grouping was accurate.
- Cleaning and harmonizing part numbers and part names to remove placeholders, blanks, and operator‑specific formatting.
- Normalizing discrepancy text through NLP‑assisted keyword extraction to classify failure modes and symptoms.
- Converting boolean flags and categorical fields into consistent, analysis‑ready formats.

Without normalization, patterns such as “loss of pressure,” “pack trip,” or “smoke/odor events” would be fragmented across dozens of inconsistent text variations. Normalization allowed the dataset to behave like a coherent maintenance record system, enabling subsystem‑level insights, severity modeling, and failure‑mode clustering that mirror real airline reliability workflows.

### Data Sources
The analysis in this project is built entirely on the FAA’s Service Difficulty Reports (SDRs), which are one of the few publicly available datasets that capture real operational maintenance issues from U.S. commercial aircraft. SDRs are submitted by airlines, repair stations, and operators whenever a component, system, or structure experiences a failure, malfunction, or abnormal condition that could affect safety or airworthiness. Each report includes structured fields—such as ATA chapter, JASC code, aircraft type, and severity—as well as unstructured discrepancy text written by technicians or flight crews.

SDRs were selected as the sole data source for three reasons. First, they provide genuine, real‑world failure events from Part 121 operations, making them far more realistic than synthetic or simulated maintenance data. Second, they contain both structured and narrative fields, which allows for a blend of SQL‑based analysis and NLP‑assisted failure‑mode extraction. This combination mirrors the way airline reliability teams work: structured data for trend analysis, and narrative text for understanding how failures actually manifested. Third, SDRs are publicly accessible, making them one of the only datasets that allow a realistic deep dive into aircraft reliability without relying on proprietary airline systems such as work orders, shop findings, or parts tracking databases.

While SDRs are not a complete maintenance history—and often lack part numbers, corrective actions, or detailed troubleshooting—they are the industry’s standard public dataset for identifying high‑severity systems, clustering failure modes, and understanding operationally disruptive events. Their limitations are part of what makes them valuable: they force the analyst to normalize inconsistent fields, extract meaning from narrative text, and build a coherent reliability picture from imperfect but authentic operational data.

---

## INSIGHTS DEEP DIVE
![img1](/assets/explore_pics/Discrepancies%20vs%20Grounded%20Discrepancies%20by%20JASC.png)
![img2](/assets/explore_pics/failure%20mode%20by%20ata.png)
![img3](/assets/explore_pics/grounding%20atas%20over%20time.png)

### overview
- Most sev 3 discrepancies were CND'd and the component that caused the failure could not be identified
- Door failures comprise of the most component-specific failures, accounting for ___ failures in the last 3 years, __% of severity level 3 failures.
- Nearly half of all severity‑3 events were CND (Could Not Duplicate), indicating widespread intermittent faults, ambiguous indications, and systemic troubleshooting gaps across multiple ATA chapters.
- The AC/Pressurization system (ATA 21) is the largest driver of AOGs, diversions, and in‑flight emergency declarations, with high concentrations of pack, valve, duct, fan, and filter failures. ATA 21 also shows the highest CND rate of any system.
- Engine‑related systems (ATA 72/73/75) are the second‑largest contributor to severe events, driven by bleed‑air interactions, oil contamination, temperature/pressure anomalies, and sensor/valve faults.
- Indication systems (switches, sensors, probes) are a systemic weakness, appearing in the top 10 most common failed part types. These components frequently produce intermittent or false indications, contributing heavily to CND totals.
- Fuel quantity and fuel system components (ATA 28) show high failure concentrations, especially compensators, probes, and pumps — a classic signature of aging fuel indication systems.
- Landing Gear (ATA 32) is a major contributor to severe events, dominated by brake, wheel, tire, and strut failures. These failures are mechanically clean and rarely CND, indicating true component wear rather than troubleshooting ambiguity.

### ac
- The AC/Pressurization (-21) system is the biggest driver for Aircraft on Ground (AOG), diversions, and in Flight Emergency (IFE) events, closely followed by Landing Gear (-32).
- For every system writeup, AC (-21) has the highest concentration of high severity and grounding events.
- Failure modes for AC primarily centered around fault and fire.
- 47% of level 3 severity events were due to the AC Distribution System (JASC 2120)
- Failures for the AC system trended around the summer season
- Odor-related events in flight (burning smell, wet dog, etc.) contributed to the most AC grounding writeups
- Failures overwhelming could not be duplicated by maintenance, primarily for odor discrepancies, though the most

### door
- Door‑related failures (ATA 52 + ATA 25 slide/girt‑bar interactions) are the single largest component‑specific reliability issue, accounting for 182 severity‑3 events over three years — approximately X% of all severe events (you can compute the exact % once you know the total count). These failures include guide arms, radius links, rollers, gust locks, seals, and rigging drift.
- 47% of severity‑3 AC events originate from the Air Distribution System (JASC 2120), confirming subsystem‑level concentration within ATA 21.
- Odor/smoke/burning‑smell events are the most common in‑flight AC symptoms, often leading to diversions or emergency declarations. These events frequently result in CND outcomes, suggesting intermittent bleed contamination or pack‑bay environmental issues.
- Door failures show strong flight‑phase patterns — handle migration during climb or descent, seal leaks in cruise, and indication lights during takeoff roll — indicating pressurization‑load sensitivity and rigging drift.
- Repeat write‑ups are common for door and AC systems, indicating incomplete troubleshooting, rigging drift, or component wear not fully addressed during initial maintenance actions.
- Seasonal trends appear in AC/pack/duct failures, with higher event counts during summer months, consistent with thermal load and pack‑capacity stress.
- Windows (ATA 56) appear unexpectedly high in the top‑10 part types, driven by crazing, delamination, and seal failures — a known reliability issue on aging narrow‑body fleets.
- Valves are the most cross‑ATA failure mode, appearing in ATA 21, 27, 28, 32, and 36. This indicates that valve reliability is a fleet‑wide concern, not isolated to a single system.
- Door failures are a rigging‑dominated failure landscape: Guide arms, handles, latches, locks, rollers, and control rods all point to: rigging drift, linkage wear, tolerance stack‑up, misadjusted stop pins, repeat write‑ups. This is the #1 reliability theme for doors.
- Door Slide/girt bar issues are a separate operational problem. These failures are often: crew‑induced, caused by catering, due to improper stowage, related to worn clips or brackets. This is a training + hardware issue.
- Door Structural failures (hinge, sill drain, torque tube) are present but not dominant... These are: predictable, mechanical, not intermittent, often caught during heavy checks. They are not the main driver of groundings.
- AA's fleet has a systemic door rigging drift problem that is a combination of: guide arm (47) handle (46) latch (11) lock (11) roller (7) hinge (9) …is a textbook signature of rigging drift across the fleet.
- Door Slide/girt bar failures are the second major reliability cluster These are high‑impact because they: cause AOG, require slide replacement involve safety equipment, often trigger emergency declarations
- Door Drain/sill issues are a hidden driver of odor‑related diversions. Your logs show multiple diversions due to: rotten egg smell, foul odor, fluid leaks, All traced to sill drains.


---

## RECOMMENDED ACTIONS
### 1. Improve troubleshooting guidance for odor/smoke events
Because CND dominates odor/smoke/burning smell, maintenance is not isolating root causes.
- Update troubleshooting steps for odor/smoke events.
- Require inspection of recirc fans, filters, and pack bays.
- Add guidance for bleed air contamination checks.
- Review wiring and connectors for fan motors.

### 2. Review outflow valve and pressure regulator maintenance intervals
Valve failures produce the strongest, cleanest pattern: loss of pressure.
- Review lubrication/functional check intervals.
- Check SB applicability for outflow valves.
- Review shop findings for valve actuators.
- Look for tail‑number clustering (wiring harness issues).

### 3. Investigate pack controller and ACM reliability
Pack failures produce: odor, overheat, smoke, pressure issues, temperature failures
Actions:
- Review pack controller fault history.
- Check ACM shop findings for oil contamination.
- Evaluate pack bay cooling airflow.

### 4. Address recirculation fan and filter reliability
Fan and filter failures produce: burning smell, odor, smoke
- Review recirc fan motor reliability.
- Inspect for electrical arcing or bearing wear.
- Review filter replacement intervals.
- Check for contamination sources upstream.

### 5. Reduce CND rates through structured troubleshooting
(CND is the biggest problem in the dataset)
- Add mandatory steps for ATA 21 severe events.
- Require documentation of pack controller resets, valve checks, sensor readings.
- Improve discrepancy writeup quality through flight crew training.
- Add a “CND review” step in reliability meetings.

### 1. Implement a fleet‑wide door rigging audit
Focus on: guide arm tolerances, handle linkage slack, stop pin adjustment, roller/hinge wear, latch/lock engagement
This will reduce the top 4 categories simultaneously.

### 2. Introduce a slide/girt bar inspection and training program
This will reduce slide assembly + girt bar failures.
- inspect girt bar clips for wear
- reinforce proper stowage procedures
- review catering interference points
- add lubrication/cleaning steps

### 3. Add sill drain cleaning to line checks
This directly prevents:
- odor events
- diversions
- corrosion
- repeat write‑ups

### 4. Add door sensor calibration to rigging tasks
The logs show many indication faults that are not counted here.

### 5. Track repeat write‑ups by tail number
Guide arm/handle failures often repeat on the same aircraft.
