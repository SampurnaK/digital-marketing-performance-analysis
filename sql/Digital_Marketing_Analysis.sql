/* ============================================================
   DIGITAL MARKETING PERFORMANCE ANALYSIS
   Author: Sampurna Kundu
   Tool: Oracle SQL
   Dataset: Digital_Marketing_Data

   Objective:
   To measure marketing impact through KPI analysis, funnel tracking, ROI assessment, and customer segmentation to support data-driven budget allocation decisions.
============================================================ */


/* ------------------------------------------------------------
   1. OVERALL KPIs
   This query calculates overall engagement and conversion KPIs to provide a high-level snapshot of marketing  performance across all customers. It uses aggregate functions (COUNT and AVG) to summarize behavioral metrics like time on site, pages per visit, CTR, and conversion rate.
------------------------------------------------------------ */
SELECT 
    COUNT(CustomerID) AS total_customers,
    ROUND(AVG(TimeOnSite),2) AS avg_time_on_site,
    ROUND(AVG(PagesPerVisit),2) AS avg_pages_per_visit,
    ROUND(AVG(CTR),2) AS avg_ctr,
    ROUND(AVG(ConversionRate),2) AS avg_cvr
FROM digitalm;


/* ------------------------------------------------------------
   2. CHANNEL PERFORMANCE
   This query compares marketing channels based on users acquired, total ad spend, and total conversions generated. It groups data by CampaignChannel and aggregates spend and conversions to evaluate channel-level effectiveness.
------------------------------------------------------------ */
SELECT 
    CampaignChannel,
    COUNT(CustomerID) AS total_users,
    SUM(AdSpend) AS total_spend,
    SUM(Conversion) AS total_conversions
FROM digitalm
GROUP BY CampaignChannel
ORDER BY total_conversions DESC;


/* ------------------------------------------------------------
   3. ROI ANALYSIS
   This query measures the return on investment (ROI) of each marketing channel to assess budget efficiency. ROI is calculated as SUM(Conversion) / SUM(AdSpend), which normalizes conversions against total spend to compare performance fairly across channels.
------------------------------------------------------------ */
SELECT 
    CampaignChannel,
    SUM(Conversion) AS total_conversions,
    SUM(AdSpend) AS total_spend,
    ROUND(SUM(Conversion)/SUM(AdSpend),6) AS roi
FROM digitalm
GROUP BY CampaignChannel
ORDER BY roi DESC;


/* ------------------------------------------------------------
   4. AGE SEGMENTATION
   This query segments customers into age buckets to identify which demographic groups convert better. A CASE statement dynamically categorizes ages into predefined groups and calculates average conversion rate per segment.
------------------------------------------------------------ */
SELECT
    CASE 
        WHEN Age < 25 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END AS age_group,
    COUNT(CustomerID) AS total_users,
    ROUND(AVG(ConversionRate),2) AS avg_conversion_rate
FROM digitalm
GROUP BY 
    CASE 
        WHEN Age < 25 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END;


/* ------------------------------------------------------------
   5. CAMPAIGN ENGAGEMENT
   This query analyzes engagement quality across campaign types for users who showed meaningful activity. It filters users with WebsiteVisits > 5 to focus on engaged users and averages behavior metrics per campaign type.
------------------------------------------------------------ */
SELECT
    CampaignType,
    ROUND(AVG(PagesPerVisit),2) AS avg_pages_per_visit,
    ROUND(AVG(TimeOnSite),2) AS avg_time_on_site,
    ROUND(AVG(ConversionRate),2) AS avg_conversion_rate
FROM digitalm
WHERE WebsiteVisits > 5
GROUP BY CampaignType;


/* ------------------------------------------------------------
   6. FUNNEL ANALYSIS
   This query evaluates drop-offs across different marketing funnel stages from website visit to final conversion. It uses conditional aggregation with CASE WHEN to count users at each stage, allowing funnel progression comparison.
------------------------------------------------------------ */
SELECT
    COUNT(DISTINCT CustomerID) AS total_users,
    SUM(CASE WHEN WebsiteVisits > 0 THEN 1 ELSE 0 END) AS visit_users,
    SUM(CASE WHEN EmailOpens > 0 THEN 1 ELSE 0 END) AS open_users,
    SUM(CASE WHEN EmailClicks > 0 THEN 1 ELSE 0 END) AS click_users,
    SUM(CASE WHEN Conversion = 1 THEN 1 ELSE 0 END) AS converted_users
FROM digitalm;


/* ------------------------------------------------------------
   7. EMAIL PERFORMANCE
   This query measures how effective email campaigns are in driving engagement and conversions. It calculates average opens, clicks, and conversion rate per campaign type to assess email performance quality.
------------------------------------------------------------ */
SELECT
    CampaignType,
    ROUND(AVG(EmailOpens),2) AS avg_email_opens,
    ROUND(AVG(EmailClicks),2) AS avg_email_clicks,
    ROUND(AVG(ConversionRate),2) AS avg_conversion_rate
FROM digitalm
GROUP BY CampaignType;


/* ------------------------------------------------------------
   8. HIGH SPEND – LOW CONVERSION
   This query identifies inefficient campaigns where high ad spend does not translate into adequate conversion rates. It filters campaigns with AdSpend > overall average and ConversionRate < 5%, highlighting potential budget wastage.
------------------------------------------------------------ */
SELECT
    CampaignChannel,
    COUNT(*) AS wasted_campaigns,
    ROUND(AVG(AdSpend),2) AS avg_spend,
    ROUND(AVG(ConversionRate),2) AS avg_conversion_rate
FROM digitalm
WHERE AdSpend > (SELECT AVG(AdSpend) FROM digitalm)
  AND ConversionRate < 5
GROUP BY CampaignChannel
ORDER BY wasted_campaigns DESC;


/* ------------------------------------------------------------
   9. CUSTOMER VALUE SEGMENTATION
   This query segments customers into value tiers within each campaign channel to support targeted marketing strategies. It uses the NTILE(4) window function to divide customers into four equal groups based on LoyaltyPoints, creating VIP, High, Medium, and Low value categories.
------------------------------------------------------------ */
SELECT
    CampaignChannel,
    loyalty_bucket,
    COUNT(*) AS customers,
    ROUND(AVG(LoyaltyPoints),0) AS avg_loyalty_points
FROM (
    SELECT
        CampaignChannel,
        LoyaltyPoints,
        CASE
            WHEN NTILE(4) OVER (PARTITION BY CampaignChannel ORDER BY LoyaltyPoints DESC) = 1 THEN 'VIP Customers'
            WHEN NTILE(4) OVER (PARTITION BY CampaignChannel ORDER BY LoyaltyPoints DESC) = 2 THEN 'High Value'
            WHEN NTILE(4) OVER (PARTITION BY CampaignChannel ORDER BY LoyaltyPoints DESC) = 3 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS loyalty_bucket
    FROM digitalm
)
GROUP BY
    CampaignChannel,
    loyalty_bucket
ORDER BY
    CampaignChannel,
    customers DESC;
