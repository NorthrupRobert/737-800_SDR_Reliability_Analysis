<p align="center">
  <img src="/assets/vectra logo white.png" width="400">
</p>

# 737-800 Maintenance, Reliability, and Supply Chain Analysis (IN PROGRESS)
### *Exploring Failure Patterns, Operator Trends, and Component Reliability Through JASC Taxonomy*

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active-brightgreen"></a>
  <img src="https://img.shields.io/badge/Focus-Aerospace-lightblue"></a>
  <img src="https://img.shields.io/badge/Database/Querying-PostgreSQL-white"></a>
  <img src="https://img.shields.io/badge/Analysis-Python-gold"></a>
  <img src="https://img.shields.io/badge/Visualization-Tableau-hotpink"></a>
  <img src="https://img.shields.io/badge/Updated-Feb%202026-lightgrey"></a>
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
- [Executive_Summary](#executive-summary)
- [Background](#background)
- [Data_Structure_Overview](#data-structure-overview)
- [Insights_Deep_Dive](#insights-deep-dive)
- [Recommended_Actions](#recommended-actions)

---

## EXECUTIVE SUMMARY
VECTRA SPACE (mid‑size U.S. airline) operates a fleet of Boeing 737‑800 aircraft and faces the same maintenance, reliability, and supply‑chain pressures seen across the commercial aviation industry. This project simulates those real‑world challenges by transforming FAA Service Difficulty Reports (SDRs) into a structured, analytics‑ready dataset that models unscheduled maintenance events, component failures, and operational disruptions.

Using SDRs as a proxy for real maintenance activity, the project builds an end‑to‑end pipeline that extracts, cleans, normalizes, and analyzes aircraft reliability data through ATA/JASC taxonomies, operator designators, and component‑level event patterns. The goal is to demonstrate how a modern airline could leverage data engineering and reliability analytics to improve fleet performance, reduce delays, and optimize parts availability.

### Problem Statement
**Analyzing maintenance How can an aviation organization with a fleet of 737-800s reduce unscheduled maintenance events and their operational and supply chain impacts by identifying high‑risk components, predicting failures, and optimizing parts availability?**

### Objectives
To design a realistic, end‑to‑end reliability analytics workflow that transforms raw FAA SDR data into actionable insights for maintenance planning, component risk assessment, and supply‑chain decision‑making.

### Dashboards
- Component‑level failure frequency
- ATA/JASC chapter trends
- Operator‑level event distributions
- Time‑based reliability patterns
- High‑risk components and emerging failure modes

### Key Findings
**(To be completed as analysis progresses)**
- Components with disproportionately high SDR rates
- ATA chapters driving the majority of unscheduled events
- Seasonal or operational patterns in failure occurrence
- Gaps in parts availability contributing to extended AOG time

<div style="font-size: 0.85em">
**Resources**

- Click here to access the Dashboards and Project Data.

</div>

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

## Data Sources
Commercial aviation data is notoriously difficult to obtain. While the FAA publishes SDRs (Service Difficulty Reports), the operational datasets that airlines actually use—work orders, parts catalogs, inventory levels, supplier performance, and maintenance actions—are proprietary and tightly controlled. Because of this, any realistic end‑to‑end maintenance analytics project must blend real public data with carefully designed synthetic layers.

The goal of this project is not to recreate a perfect copy of an airline’s internal database. Instead, the goal is to replicate the structure, relationships, and decision‑making logic that real maintenance, reliability, and supply‑chain analysts work with every day. The synthetic components in this project are built using the same assumptions, constraints, and operational patterns used in commercial M&E systems such as TRAX, AMOS, and Maintenix. That means the learning comes from understanding how the system works—not from the raw data itself.

Working with a realistic synthetic dataset still teaches the core skills that matter in real aviation analytics roles:

- Data modeling: Designing tables that mirror how airlines structure parts catalogs, work orders, ATA/JASC classifications, and inventory systems.
- Normalization and cleaning: Reconciling inconsistent part numbers, merging SDR events with catalog data, and handling missing or ambiguous fields.
- Operational logic: Mapping failures to maintenance actions, estimating repair durations, modeling AOG risk, and simulating supply‑chain delays.
- Reliability and supply‑chain thinking: Understanding how failures drive stocking rules, lead times, criticality levels, and vendor performance.
- End‑to‑end system design: Building a pipeline that connects failures → parts → inventory → work orders → analytics, just like a real airline.

In other words, while some fields are synthesized, the relationships, constraints, and workflows are modeled after real-world aviation operations. This allows the project to demonstrate practical, industry‑aligned skills: designing maintainable data systems, interpreting operational data, and building analytics that support maintenance planning, reliability engineering, and supply‑chain decision‑making.

### Assumptions and Synthetic Logic
This project uses FAA Service Difficulty Reports (SDRs) as the authoritative source for real maintenance events, failure modes, JASC codes, and component descriptions. Because SDRs only capture failures and discrepancies—not the full aircraft bill of materials—the supply‑chain layer (unit cost, lead time, supplier assignment, stocking levels) is intentionally synthetic. All synthetic values are grounded in real aviation patterns: JASC/ATA chapter drives criticality and lead‑time behavior, part names and conditions influence cost heuristics, and failure frequency from SDRs determines stocking logic. The goal is not to recreate Boeing’s proprietary ERP, but to build a realistic, explainable model that mirrors how reliability and supply‑chain analysts reason about parts when full ERP data is unavailable.

### How the System Works
The pipeline ingests the SDR composite file, normalizes Part* and Component* fields, and merges them into a unified “parts universe” representing all components that appeared in real maintenance events. From there, the system generates a parts master table with synthetic but aviation‑grounded attributes (cost, lead time, criticality, supplier). A supplier table is created with performance metrics, and an inventory table is derived by combining failure frequency, criticality, cost, and lead‑time heuristics. These tables form a miniature but coherent maintenance‑and‑supply‑chain ecosystem that can be loaded into SQL for analysis and visualized in Tableau for reliability and logistics insights.

### Work Order Assumptions
#### 1. SDRs provide the failure event, not the maintenance action
SDRs tell you what failed and how it was discovered, but not how long the repair took, whether the aircraft was AOG, or what specific maintenance actions were performed. The synthetic work‑order layer fills this gap using realistic airline logic.

#### 2. Maintenance actions follow real ATA/JASC patterns
Certain ATA chapters strongly correlate with specific maintenance environments and actions. For example, ATA 25 (cabin) is usually line maintenance, while ATA 53/54 (structure) is base maintenance and involves longer repair durations.

#### 3. Fault codes and action codes are inferred from SDR text
PartCondition, ComponentCondition, and the discrepancy narrative are used to infer the likely fault and the corresponding maintenance action. This mirrors how real maintenance systems classify work.

#### 4. Backorder delays and AOG events are probabilistic
Since SDRs do not include supply‑chain data, delays and AOG flags are generated using realistic heuristics based on criticality, lead time, and inventory levels.

#### 5. One work order per SDR event
Airlines typically generate one work order per discrepancy or maintenance event. The synthetic system mirrors this by collapsing multiple SDR rows into a single WO per SDR ID.

### AI‑Generated Components
The synthetic supply‑chain attributes and the logic that produces them were developed with the assistance of an AI system. The AI did not invent real proprietary data; instead, it generated structured, explainable heuristics based on aviation maintenance conventions, ATA/JASC patterns, and reliability engineering principles. All synthetic elements are clearly separated from the real SDR data, and the methodology is fully documented so that assumptions can be inspected, challenged, or extended. This approach allows the project to remain realistic, transparent, and professionally defensible while still enabling end‑to‑end analytics across maintenance, reliability, and supply‑chain domains.

---

## INSIGHTS DEEP DIVE
![img1](/assets/explore_pics/Discrepancies%20vs%20Grounded%20Discrepancies%20by%20JASC.png)
![img2](/assets/explore_pics/failure%20mode%20by%20ata.png)
![img3](/assets/explore_pics/grounding%20atas%20over%20time.png)

### 1. INSIGHT
ONE SENTENCE OVERVIEW
- SUPPORTING STATEMENT 1
- SUPPORTING STATEMENT 2

### 2. INSIGHT
ONE SENTENCE OVERVIEW
- SUPPORTING STATEMENT 1
- SUPPORTING STATEMENT 2

---

## RECOMMENDED ACTIONS
### 1. RECOMMENDATION
- DETAIL 1
- DETAIL 2

### 2. RECOMMENDATION
- DETAIL 1
- DETAIL 2
