---
# A/B Testing & Conversion Optimization
---

## Overview
Analyzed a redesigned digital credit card onboarding flow using an end-to-end A/B testing framework (design → validation → business impact).
**Goal:** Determine if Variant B improves conversion vs Variant A by reducing user friction.

---
## Key Insight
Variant B increased conversion from **11.9% → 14.9% (+3pp)**, driving **~30,000 additional monthly conversions** and **~₹1.5 crore incremental revenue**.

---
## Business Context
The onboarding flow was redesigned to:
* Reduce funnel drop-offs
* Improve user experience
* Increase completed applications
**Core question:**
Does the new experience deliver a statistically and practically significant uplift?

---
## Experiment
* **Control (A):** Existing onboarding
* **Treatment (B):** Redesigned flow

**Primary metric:** Conversion rate
**Guardrails:** No drop in mobile conversion, no increase in form-stage drop-offs

---
## Approach
* Power analysis (α=0.05, power=0.8)
* Simulated ~30K users (device, history, engagement)
* SQL: joins, funnel, segmentation
* Validation: balance checks + **SRM test**
* Statistics: two-proportion z-test + confidence intervals
* Advanced: segmentation, logistic regression, interaction effects
* Visualization: Tableau dashboards

---
## Results
* **+3.0pp conversion uplift (statistically significant)**
* Consistent across devices (no interaction effects)
* Drop-off concentrated at **form → submit stage**
* Uplift driven by UX improvements (not engagement)

---
## Business Impact
* **+30K conversions/month**
* **~₹1.5 crore incremental monthly revenue**

---
## Decision
> **Roll out Variant B to 100% of users**
**Why:** Significant, consistent uplift with a valid experiment setup

---
## Next Steps
* Monitor mobile performance
* Optimize form-stage friction
* Run iterative onboarding experiments

---
## Tech Stack
Python (Pandas, NumPy, Statsmodels) • SQL (SQLite) • Tableau

---
## Skills
A/B Testing • Statistical Inference • SQL (Funnel, Segmentation) • SRM Validation • Logistic Regression • Business Impact Analysis

---
## Summary
End-to-end A/B testing project translating statistical results into a clear product decision with measurable revenue impact.






If you want next level, I can turn this into a **“top 1% data portfolio README” with visuals + storytelling hooks**.
