select
job_id,
job_title as role,
company_dim.name as company_name,
salary_year_avg as yearly_salary,
job_schedule_type,

job_posted_date
from
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id=job_postings_fact.company_id    
WHERE
    job_title_short='Data Analyst' AND job_location='Anywhere' AND salary_year_avg is not null

ORDER BY
     salary_year_avg   DESC 

LIMIT 10      
