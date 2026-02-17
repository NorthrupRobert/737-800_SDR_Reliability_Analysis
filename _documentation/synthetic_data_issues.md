# Synthetic Data Issues

Defining issues and planning for creation of synthetic data, to be imported into the Vectra database (managed by the PostgreSQL RDBMS).

## work_orders.csv
- parts are back-ordered for work-orders where the corrective action (see action_code, task_type, mel_code?) does not require a new part, such as "Corrosion Removal" or "Repair"
- work orders are (currently) only limited to one work order per SDR... this does not seem in-line with work-order logic, at least how the military treats "jobs" (JCNs, were we have multiple jobs tied to a single issue. One job could include troubleshooting).

---

## inventory.csv


---

## parts_master.csv


---

## suppliers.csv


---

## benchstock
### 1. Doesn't exist right now (20260214)
- Necessary for drafting the 'bench_stock' entity in the database
- work orders don't need to be dependent on this (maybe?) I think there just needs to be some variable given to how likely it is to be found on base from either the benchstock OR the serialized_base_inventory, and this impacts whether or not the part was backordered. that seems fair.