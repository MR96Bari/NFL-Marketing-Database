📊 Social Media Impact on Sales in the NFL

Course: BMSO601 – Database Management
Project Type: Relational Database Design & Business Analytics
Team Members:
Samarth Tuli, Pearson Roberts, Alyssa Miller, Diana Kim, Justin Mejia, Matthew Robert Rutigliano

📌 Project Overview

This project analyzes how social media engagement across NFL teams, athletes, and coaches impacts ticket and merchandise sales. We designed and implemented a relational database to centralize social media metrics and sales data, then used that data to uncover actionable insights for league-wide and team-level marketing strategies.

The core objective was to determine which types of social media activity most strongly correlate with revenue generation, and how teams can optimize their digital presence to increase sales.

🎯 Mission Statement

The NFL database aims to track social media engagement, uncover insights to drive targeted marketing strategies, and ultimately increase ticket and merchandise sales for both the league and individual teams.

✅ Mission Objectives

Measure social media participation using engagement metrics (likes, comments, shares, views)

Analyze correlations between social media engagement and:

Event ticket sales

Merchandise sales

Monitor follower and engagement benchmarks for:

Teams

Athletes

Coaches

Evaluate whether athlete and coach rank/demographics correlate with fan engagement and sales

Analyze the impact of social media marketing on female merchandise sales

Maintain accurate, centralized data on teams, athletes, coaches, social media accounts, and sales

📐 Database Design
Key Business Rules

Each team, athlete, and coach may own at most one verified social media account

A social media account can publish zero or many posts

Each post belongs to exactly one account

Athletes belong to one team; teams have many athletes

Each team has one coach

Products are classified as either tickets or merchandise

A sale references one team and one product

A product can appear in multiple sales

🧱 Final Relational Schema

Note: Some entities were intentionally denormalized to preserve data integrity.
Stored procedures (UpdateTeamDivision, UpdateDivisionName) were implemented to prevent update anomalies when divisions or team alignments change.

TEAM (TEAM_ID, TEAM_NAME, TEAM_DIVISION, TEAM_CITY, TEAM_STATE, TEAM_STADIUM_NAME, COACH_ID, ACCOUNT_ID)

COACH (COACH_ID, COACH_F_NAME, COACH_L_NAME, COACH_DOB, COACH_RANK, COACH_YRS_EXPERIENCE, ACCOUNT_ID)

ATHLETE (ATHLETE_ID, ATHLETE_F_NAME, ATHLETE_L_NAME, ATHLETE_DOB, ATHLETE_POSITION, ATHLETE_RANK, TEAM_ID, ACCOUNT_ID)

SOCIAL_MEDIA_ACCOUNT (ACCOUNT_ID, ACCOUNT_USERNAME, ACCOUNT_OWNER_TYPE, ACCOUNT_FOLLOWER_COUNT)

POST (POST_ID, POST_DATE, POST_TYPE, POST_LIKE_COUNT, POST_SHARE_COUNT, POST_VIEW_COUNT, POST_COMMENT_COUNT, ACCOUNT_ID)

PRODUCT (PRODUCT_ID, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_TYPE)

TICKET (PRODUCT_ID, TICKET_CLASS, TICKET_DELIVERY, TICKET_DISCOUNT, TICKET_VIP_REWARDS)

MERCHANDISE (PRODUCT_ID, MERCH_TYPE, MERCH_COLOR, MERCH_SIZE, MERCH_GENDER, MERCH_MATERIAL)

SALE (SALE_DATE, TEAM_ID, PRODUCT_ID, UNITS_SOLD)

📊 Analytics & Dashboards
Dashboard 1: Social Media Engagement vs Sales Volume

Objective:
Evaluate how total social media engagement correlates with ticket and merchandise sales at the team level.

Key Metrics:

Total Engagement: Sum of likes, comments, shares, and views across team, coach, and athlete accounts

Sales Value: Units sold × product price

Findings:

❌ Ticket sales show no meaningful correlation with social media engagement

Example: The Philadelphia Eagles had the highest engagement but generated nearly $5M less in ticket revenue than the New York Jets

✅ Merchandise sales show a strong positive correlation with engagement

Teams with higher engagement consistently generated higher merchandise revenue

Dashboard 2: Engagement by Account Type & Merchandise Sales by Product Type

Objective:
Understand which social media account types drive merchandise sales and how product mix varies across teams.

Visualizations Included:

Packed bubble chart: Engagement by account type (Team, Athlete, Coach)

Tree map: Merchandise sales by product type

Bar chart: Total merchandise sales by team (used for interactive filtering)

Key Insights:

Jerseys are the top revenue-generating merchandise item

High-performing teams (e.g., Philadelphia Eagles):

Athlete accounts dominate total engagement

Jersey sales make up a large proportion of merchandise revenue

Low-performing teams (e.g., Houston Texans):

Lower athlete-driven engagement

Smaller proportion of jersey sales

📈 Strategic Recommendations

Based on our findings:

Increasing overall social media engagement leads to higher merchandise sales

Teams should prioritize athlete-driven social media content

Athlete posts should prominently feature team jerseys to maximize merchandise revenue

League-wide marketing efforts should focus less on ticket promotion via social media and more on merchandise-focused digital campaigns

🛠 Tools & Technologies

Database Design: Relational modeling (ERD → SQL schema)

SQL: Table creation, constraints, stored procedures, analytical queries

Data Visualization: BI dashboards (tool-agnostic; adaptable to Tableau / Power BI)

Analytics Focus: Revenue correlation, engagement aggregation, segmentation by account type

📂 Repository Contents (Suggested)
/sql
  ├── schema.sql
  ├── stored_procedures.sql
  ├── queries.sql

/diagrams
  ├── ERD.png

/dashboards
  ├── dashboard_1.pdf
  ├── dashboard_2.pdf

README.md
