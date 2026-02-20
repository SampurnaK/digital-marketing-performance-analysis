###### 📊 **Digital Marketing Performance Analysis**





**📈 Dashboard**



https://public.tableau.com/views/DigitalMarketing\_17714346539480/DashboardFinal?:language=en-GB\&:sid=\&:redirect=auth\&:display\_count=n\&:origin=viz\_share\_link





###### 



📌 **Project Overview**



This project analyzes digital marketing performance using Oracle SQL + Excel + Tableau Public to evaluate campaign effectiveness, ROI efficiency, funnel performance, and customer segmentation. The objective was to support data-driven budget allocation decisions by identifying high-performing channels and areas of marketing wastage.







🗂 Dataset



Source: Excel dataset (digitalm)



Records: 8,000 customers



Key Variables:



* CustomerID
* CampaignChannel
* CampaignType
* AdSpend
* Conversion
* ConversionRate
* CTR
* PagesPerVisit
* TimeOnSite
* EmailOpens / EmailClicks
* LoyaltyPoints
* Age







🛠 **Tools Used**



Oracle SQL → Data analysis \& aggregation

Excel → Raw dataset

Tableau Public → Dashboard visualization

GitHub → Project documentation







🔎 **Analysis Performed**



1. **KPI Overview Dashboard** – Provides a **consolidated performance snapshot** by aggregating **total customers, average engagement metrics, and overall conversion** indicators to assess the overall health and effectiveness of marketing campaigns.
2. **Channel Performance Analysis** – Evaluates **acquisition channels** (Referral, PPC, SEO, Email, Social Media) using users acquired, total ad spend, and total conversions to **determine which sources generate the strongest growth and revenue contribution**.
3. **ROI Efficiency Analysis** – Measures **budget efficiency using ROI = SUM(Conversion) / SUM(AdSpend)** to normalize results against investment and identify the **most cost-effective marketing channels.**
4. **Age-Based Customer Segmentation** – Groups customers into **demographic buckets** using CASE logic and compares conversion rates across segments to **identify high-performing age cohorts.**
5. **Campaign Engagement Quality Assessment** – Filters **high-intent traffic using WebsiteVisits > 5** and analyzes average pages per visit, time on site, and conversion rate to measure **engagement depth and behavioral quality.**
6. **Conversion Funnel Analysis** – Applies conditional aggregation to track user progression across funnel stages (Visit → Open → Click → Conversion) and **quantify drop-offs impacting final conversions.**
7. **Email Campaign Effectiveness Evaluation** – Assesses **email-driven performance** by measuring average opens, clicks, and conversion rates to evaluate its **influence on overall campaign success.**
8. **High Spend–Low Conversion Detection** – Identifies **inefficient campaigns where AdSpend > overall average AND ConversionRate < 5%**, highlighting areas of potential **budget wastage and optimization opportunities.**
9. **Customer Value Segmentation** – Uses NTILE(4) OVER (PARTITION BY CampaignChannel ORDER BY LoyaltyPoints DESC) to **classify customers into VIP, High, Medium, and Low value tiers**, enabling targeted **marketing and retention strategies.**







**📊 Key Insights**



📈 Achieved a **10.44% average conversion rate across 8,000 customers**, supported by strong engagement (7.73 mins avg time, 5.55 pages/visit, 15.48% CTR).

💰 **PPC delivers the highest ROI (0.000178)**, outperforming other channels, while **Email records the lowest ROI (0.000172)** — indicating budget reallocation opportunity.

🏆 **Referral drives the highest conversions (1,719)** but also shows the **highest wasted campaigns (195)**, signaling inefficiency despite volume.

👥 The **45+ segment (3,855 users) is the largest and converts at 10.52%**, matching the 35–44 segment (10.52%), making older demographics the most valuable audience.

🔁 **Funnel efficiency is strong**: 7,012 conversions from 8,000 users (87.6%), with the **largest drop between Email Opens (7,597) and Clicks (7,206)** — highlighting CTA optimization scope.

🎯 **Consideration campaigns** deliver the **highest conversion rate (10.55%)**, proving mid-funnel strategy is currently the most **effective performance driver.**

📉 **High-spend campaigns with low conversion (<3%)** account for up to **195 inefficient executions**, suggesting immediate ROI improvement potential through spend rationalization.







🚀 **Recommendations**



* **Reallocate Budget Toward High-ROI Channels** - Gradually shift 10–15% budget from low-ROI channels (Email, inefficient Referral campaigns) toward PPC. Run A/B budget scaling tests for 2–4 weeks to validate incremental lift.
* **Optimize Referral Channel Efficiency** - Audit the bottom 20% performing referral sources. Remove low-converting traffic sources. Shift from volume-focused to conversion-focused referral partners.
* **Double Down on 35+ Audience Segments** - Increase targeting budget for 35+ cohorts. Create tailored creatives for older demographics. Use lookalike audiences based on 45+ high converters.
* **Strengthen Mid-Funnel (Consideration) Campaigns** - Increase spend allocation for Consideration-stage campaigns. Introduce limited-time offers to accelerate mid-funnel conversion.
* **Improve Email Click-Through Performance** - A/B test CTA wording and placement. Use stronger personalization in subject lines. Add urgency triggers (countdowns, limited stock).
* **Eliminate High-Spend, Low-Conversion Campaigns** - Set automated rule like pause campaigns below 5% conversion after threshold spend.
