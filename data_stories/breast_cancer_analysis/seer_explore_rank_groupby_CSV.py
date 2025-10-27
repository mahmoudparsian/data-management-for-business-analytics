import pandas as pd
import sqlite3
import matplotlib.pyplot as plt

# Load CSV (adjust path if needed)
csv_path = "SEER_Breast_Cancer_Dataset.csv"  # put your CSV file name here
df = pd.read_csv(csv_path)

# Load into SQLite in-memory
conn = sqlite3.connect(":memory:")
df.to_sql("seer_breast_cancer", conn, if_exists="replace", index=False)

# Helper to save simple bar chart
def bar_plot(categories, values, title, xlabel, ylabel, outfile, rotation=45):
    plt.figure(figsize=(10, 6))
    plt.bar(categories, values)
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.xticks(rotation=rotation)
    plt.tight_layout()
    plt.savefig(outfile)
    plt.close()

# 1) Alive vs Dead counts
q1 = '''
SELECT status, COUNT(*) AS cnt
FROM seer_breast_cancer
GROUP BY status
ORDER BY cnt DESC;
'''
d1 = pd.read_sql(q1, conn)
bar_plot(d1["status"], d1["cnt"], "Alive vs Dead", "status", "count", "alive_vs_dead.png", rotation=0)

# 2) Avg tumor_size by grade
q2 = '''
SELECT grade, AVG(tumor_size) AS avg_tumor
FROM seer_breast_cancer
GROUP BY grade
ORDER BY avg_tumor DESC;
'''
d2 = pd.read_sql(q2, conn)
bar_plot(d2["grade"], d2["avg_tumor"], "Average Tumor Size by Grade", "grade", "avg_tumor", "avg_tumor_by_grade.png")

# 3) Avg survival_months by marital_status
q3 = '''
SELECT marital_status, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer
GROUP BY marital_status
ORDER BY avg_survival DESC;
'''
d3 = pd.read_sql(q3, conn)
bar_plot(d3["marital_status"], d3["avg_survival"], "Average Survival by Marital Status", "marital_status", "avg_survival", "avg_survival_by_marital.png")

# 4) Avg tumor_size by t_stage
q4 = '''
SELECT t_stage, AVG(tumor_size) AS avg_tumor
FROM seer_breast_cancer
GROUP BY t_stage
ORDER BY avg_tumor DESC;
'''
d4 = pd.read_sql(q4, conn)
bar_plot(d4["t_stage"], d4["avg_tumor"], "Average Tumor Size by T Stage", "t_stage", "avg_tumor", "avg_tumor_by_tstage.png", rotation=0)

# 5) Avg survival_months by race
q5 = '''
SELECT race, AVG(survival_months) AS avg_survival
FROM seer_breast_cancer
GROUP BY race
ORDER BY avg_survival DESC;
'''
d5 = pd.read_sql(q5, conn)
bar_plot(d5["race"], d5["avg_survival"], "Average Survival by Race", "race", "avg_survival", "avg_survival_by_race.png")

# 6) Ranking: Top 3 tumor_size within each grade (save as CSV preview)
q6 = '''
SELECT age, grade, tumor_size,
       RANK() OVER (PARTITION BY grade ORDER BY tumor_size DESC) AS rnk
FROM seer_breast_cancer;
'''
d6 = pd.read_sql(q6, conn)
top3_by_grade = d6[d6["rnk"] <= 3]
top3_by_grade.to_csv("top3_tumor_by_grade.csv", index=False)

# 7) Ranking: Top patient per race by survival (bar of top per race)
q7 = '''
WITH ranked AS (
  SELECT age, race, survival_months,
         RANK() OVER (PARTITION BY race ORDER BY survival_months DESC) AS rnk
  FROM seer_breast_cancer
)
SELECT race, survival_months
FROM ranked
WHERE rnk = 1
ORDER BY survival_months DESC;
'''
d7 = pd.read_sql(q7, conn)
bar_plot(d7["race"], d7["survival_months"], "Top Survival (Months) — Best per Race", "race", "top_survival_months", "top_survival_per_race.png")

# 8) Avg reginol_node_positive by n_stage
q8 = '''
SELECT n_stage, AVG(reginol_node_positive) AS avg_pos
FROM seer_breast_cancer
GROUP BY n_stage
ORDER BY avg_pos DESC;
'''
d8 = pd.read_sql(q8, conn)
bar_plot(d8["n_stage"], d8["avg_pos"], "Average Positive Nodes by N Stage", "n_stage", "avg_positive_nodes", "avg_pos_nodes_by_nstage.png", rotation=0)

conn.close()
print("Finished. Generated 6 PNG charts and 1 CSV summary (top3_tumor_by_grade.csv).")
