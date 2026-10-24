WITH data_analyst_jobs AS (
    SELECT
        job_postings_fact.job_id,
        job_title AS roles,
        company_dim.name AS company_name,
        salary_year_avg AS yearly_salary,
        job_schedule_type,
        job_posted_date
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON company_dim.company_id = job_postings_fact.company_id
    WHERE job_title_short = 'Data Analyst'
      AND job_location = 'Anywhere'
      AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 20
),
skills_jobid AS (
    SELECT
        skills_job_dim.job_id,
        skills_dim.skill_id,
        skills_dim.skills
    FROM skills_job_dim
    LEFT JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
)
SELECT
    skills_jobid.skills AS skill,
    COUNT(DISTINCT data_analyst_jobs.job_id) AS job_count
FROM data_analyst_jobs
LEFT JOIN skills_jobid
    ON skills_jobid.job_id = data_analyst_jobs.job_id
WHERE skills_jobid.skills IS NOT NULL
GROUP BY skills_jobid.skills
ORDER BY job_count DESC
LIMIT 5;