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
- Most sev 3 discrepancies were CND'd and the component that caused the failure could not be identified
- Door failures comprise of the most component-specific failures, accounting for ___ failures in the last 3 years, __% of severity level 3 failures.
- The AC/Pressurization (-21) system is the biggest driver for Aircraft on Ground (AOG), diversions, and in Flight Emergency (IFE) events, closely followed by Landing Gear (-32).
- For every system writeup, AC (-21) has the highest concentration of high severity and grounding events.
- Failure modes for AC primarily centered around fault and fire.
- 47% of level 3 severity events were due to the AC Distribution System (JASC 2120)
- Failures for the AC system trended around the summer season
- Odor-related events in flight (burning smell, wet dog, etc.) contributed to the most AC grounding writeups
- Failures overwhelming could not be duplicated by maintenance, primarily for odor discrepancies, though the most

For further details, please see [Insights Deep Dive](#insights-deep-dive).

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

### Overview
Severe events in the AA 737‑800 fleet are dominated by three systems: AC/Pressurization (ATA 21), Doors (ATA 52/25), and Fuel Indication (ATA 28). Door failures are overwhelmingly rigging‑driven, AC failures are dominated by odor/pressure anomalies with high CND rates, and fuel indication failures are driven by aging probes/compensators.

**For a technical, in-depth analysis of fleet discoveries and methodology, please review the [exploratory notebook](./_data_design_and_exploration/06_explore_aa.ipynb).**

### General Findings
#### 1. Intermittent faults and CND outcomes dominate severe events
  - Nearly half of all severity‑3 events were Could Not Duplicate, indicating intermittent faults, ambiguous indications, and systemic troubleshooting gaps.
  - Indication systems (switches, sensors, probes) frequently produce false or intermittent signals and appear in the top 10 failed part types.
  - Valve failures appear across ATA 21, 27, 28, 32, and 36, reinforcing a fleet‑wide pattern of intermittent or ambiguous indications.
#### 2. Component‑specific failures cluster heavily in Doors and AC systems
  - Door failures are the largest component‑specific cluster, accounting for the highest number of severity‑3 events in the fleet.
  - AC/Pressurization (ATA 21) is the largest system‑level driver of AOGs, diversions, and in‑flight emergencies.
  - Both systems show high rates of repeat write‑ups, indicating incomplete troubleshooting or unresolved underlying mechanical issues.
#### 3. Aging systems show predictable mechanical wear patterns
  - Fuel Indication (ATA 28) failures cluster around compensators, probes, and pumps — classic aging‑fleet components.
  - Landing Gear (ATA 32) failures are mechanically clean and rarely CND, dominated by brakes, wheels, tires, and struts.
  - Windows (ATA 56) appear unexpectedly high due to crazing, delamination, and seal failures — another aging‑fleet signature.
#### 4. Engine‑related systems are the second‑largest contributor to severe events
  - ATA 72/73/75 failures are driven by bleed‑air interactions, oil contamination, temperature/pressure anomalies, and sensor/valve faults.
  - These failures often cascade into ATA 21 symptoms (odor, smoke, pack trips), reinforcing cross‑system coupling.

---

### AC System — Highest Severity System
#### 1. ATA 21 is the fleet’s most operationally disruptive system
- It is the top driver of AOGs, diversions, and in‑flight emergencies.
- Nearly all AC events are severity‑3, with very few lower‑severity discrepancies.
- 47% of severity‑3 AC events originate from JASC 2120 (Air Distribution System), showing a clear subsystem hotspot.
#### 2. Odor/smoke events dominate AC write‑ups and drive high CND rates
- Burning‑smell, smoke, and odor events are the most common in‑flight symptoms and frequently lead to diversions or emergency declarations.
- ATA 21 has the highest CND rate of any system, especially for odor‑related discrepancies.
- These patterns suggest intermittent bleed contamination, pack‑bay environmental issues, or duct leakage.
#### 3. AC failures show strong environmental and seasonal patterns
- Pack, duct, and distribution failures spike in summer months due to thermal load and pack‑capacity stress.
- Failure modes cluster around fault, fire, and environmental contamination indications.

---

### Door System — Highest Component‑Specific Failure Area
#### 1. Door failures are dominated by rigging drift and linkage wear
- Failures involving guide arms, handles, latches, locks, rollers, and control rods all point to rigging drift, tolerance stack‑up, and misadjusted stop pins.
- This is the #1 reliability theme for doors and the primary driver of repeat write‑ups.
- The distribution of failed components (guide arm, handle, latch, lock, roller, hinge) is a textbook signature of systemic rigging drift.
#### 2. Door‑related failures form the largest component‑specific severity‑3 cluster
- ATA 52 + ATA 25 slide/girt‑bar failures account for 182 severity‑3 events over three years — the largest component‑specific cluster in the fleet.
- These failures include guide arms, radius links, rollers, gust locks, seals, and rigging drift.
#### 3. Door failures show strong operational and flight‑phase sensitivity
- Handle migration during climb/descent, seal leaks in cruise, and takeoff‑roll indication lights all indicate pressurization‑load sensitivity.
- Slide/girt bar failures form a second major cluster, often caused by crew handling, catering interference, improper stowage, or worn clips/brackets.
- Structural failures (hinge, sill drain, torque tube) occur but are predictable and not major drivers of groundings.

---

## RECOMMENDED ACTIONS
### 1. Strengthen Troubleshooting and Reduce CND Rates
#### a. Improve troubleshooting guidance for odor/smoke events
Because CND dominates odor/smoke/burning smell, maintenance is not isolating root causes.
- Update troubleshooting steps for odor/smoke events.
- Require inspection of recirc fans, filters, and pack bays.
- Add guidance for bleed air contamination checks.
- Review wiring and connectors for fan motors.
#### b. Reduce CND rates through structured troubleshooting
(CND is the biggest problem in the dataset)
- Add mandatory steps for ATA 21 severe events.
- Require documentation of pack controller resets, valve checks, sensor readings.
- Improve discrepancy writeup quality through flight crew training.
- Add a “CND review” step in reliability meetings.

---

### 2. Address Specific Parts reliability
#### a. Investigate pack controller and ACM reliability
Pack failures produce: odor, overheat, smoke, pressure issues, temperature failures
Actions:
- Review pack controller fault history.
- Check ACM shop findings for oil contamination.
- Evaluate pack bay cooling airflow.
#### b. Address recirculation fan and filter reliability
Fan and filter failures produce: burning smell, odor, smoke
- Review recirc fan motor reliability.
- Inspect for electrical arcing or bearing wear.
- Review filter replacement intervals.
- Check for contamination sources upstream.

---

### 3. Address Door rigging issues
#### a. Implement a fleet‑wide door rigging audit
Focus on: guide arm tolerances, handle linkage slack, stop pin adjustment, roller/hinge wear, latch/lock engagement
This will reduce the top 4 categories simultaneously.
#### b. Introduce a slide/girt bar inspection and training program
This will reduce slide assembly + girt bar failures.
- inspect girt bar clips for wear
- reinforce proper stowage procedures
- review catering interference points
- add lubrication/cleaning steps
#### c. Add sill drain cleaning to line checks
This directly prevents:
- odor events
- diversions
- corrosion
- repeat write‑ups

---

### 4. Track Additional Maintenance Procedures moving forward
#### a. Review outflow valve and pressure regulator maintenance intervals
Valve failures produce the strongest, cleanest pattern: loss of pressure.
- Review lubrication/functional check intervals.
- Check SB applicability for outflow valves.
- Review shop findings for valve actuators.
- Look for tail‑number clustering (wiring harness issues).
#### b. Track repeat write‑ups by tail number
Guide arm/handle failures often repeat on the same aircraft.
#### c. Evaluate aging‑fleet components (ATA 28, ATA 56)
- Review probe/compensator replacement intervals
- Add window seal/crazing inspections to heavy checks
