#=====================================================
         # Loan Approval Analysis
#=====================================================


use Loan_Approval_Analysis;


#=====================================================
              # 1. DATA EXPLORATION
#=====================================================

select * 
from data;

desc data;

select * 
from data limit 3;

select count(*) as Total_count
from data;



#=====================================================
              # 2. Data Cleaning
#=====================================================

SELECT
   sum(trim(Gender) = '' or Gender is NULL) as null_count,
   sum(trim(Married) = '' or Married is NULL) as null_count,
   sum(trim(Dependents) = '' or Dependents is NULL) as null_count,
   sum(trim(Education) = '' or Education is NULL) as null_count,
   sum(trim(Employment_Status) = '' or Employment_Status is NULL) as null_count,
   sum(trim(Applicant_Income) = '' or Applicant_Income is NULL) as null_count,
   sum(trim(Coapplicant_Income) = '' or Coapplicant_Income is NULL) as null_count,
   sum(trim(Loan_Term) = '' or Loan_Term is NULL) as null_count,
   sum(trim(Property_Area) = '' or Property_Area is NULL) as null_count,
   sum(trim(Age) = '' or Age is NULL) as null_count,
   sum(trim(Loan_Status) = '' or Loan_Status is NULL) as null_count
from data;

update data
set Gender = 'Unknown'
where Gender = '';

update data
set Married = 'Unknown'
where Married = '' or Married is NULL;


update data
set  Dependents = NULL
where  Dependents = '' ;

update data
set Education = 'Unknown'
where Education = '' or Education is NULL;

update data
set Employment_Status = 'Unknown'
where Employment_Status = '' or Employment_Status is NULL;



#=====================================================
         # 3. CUSTOMER DISTRIBUTION
#=====================================================



select 
Gender,count(*) as count
from data
group by Gender;

select 
Gender,Married,count(*) as count
from data
group by Gender,Married;

select 
Education ,
count(*) as count
from data
group by Education;
    
select Employment_Status,
count(*) as count
from data
group by Employment_Status;

select avg(Age) as avg_age
from data;

select 
Property_Area,
count(*) as count
from data
group by Property_Area
order by count desc;



#=====================================================
         # 4. OVERALL Loan Status
#=====================================================



select 
Loan_Status,
round(
	count(Loan_Status) / 
    (select count(*) from data) * 100,
2
) as percentage
from data
group by Loan_Status;



#=====================================================
	  # 5. Loan Approval Analysis
#=====================================================
     

     
select 
Gender,
Loan_Status ,
count(*) as Approved_count
from data
where Loan_Status = 'Approved'
group by Gender
order by Approved_count desc;

select 
Married ,
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*)  * 100,
    2 ) as percentage
from data
group by Married
order by count_of_Approval desc;

select 
Dependents, 
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*)  * 100,
    2 ) as percentage
from data
group by Dependents
order by count_of_Approval desc;

select 
Education ,
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*) * 100,
    2 ) as percentage
from data
group by Education
order by count_of_Approval desc;

select 
Employment_Status ,
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*) * 100,
    2 ) as percentage
from data
group by Employment_Status
order by count_of_Approval desc;

select 
Gender,
Married ,
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*) * 100,
    2 ) as percentage
from data
group by Gender,Married
order by count_of_Approval desc;

select 
Gender,
Dependents ,
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*) * 100,
    2 ) as percentage
from data
group by Gender,Dependents
order by count_of_Approval desc;

select 
Gender,
Education ,
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*) * 100,
    2 ) as percentage
from data
group by Gender,Education
order by count_of_Approval desc; 

select 
Gender,
Employment_Status ,
count(Loan_Status) as count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) / 
    count(*) * 100,
    2 ) as percentage
from data
group by Gender,Employment_Status
order by count_of_Approval desc; 

select Education , 
avg(Applicant_Income) as avg_Applicant_Income,
avg(Loan_Amount) as avg_Loan_amount
from data
where Loan_Status = 'Approved'
group by Education
order by avg_Loan_amount desc  ;


select Employment_Status , 
avg(Applicant_Income) as avg_Applicant_Income,
avg(Loan_Amount) as avg_Loan_amount
from data
where Loan_Status = 'Approved'
group by Employment_Status
order by avg_Loan_amount desc  ;

select Loan_Term , count(Loan_Term) as count
from data
group by Loan_Term
order by count desc;

 select 
Credit_History,
count(Loan_Status) as Total_count,
sum(case when Loan_Status = 'Approved' then 1 else 0 end) as approval_count,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) /
	count(*)  * 100,2) as Approved_percentage,
sum(case when Loan_Status = 'Rejected' then 1 else 0 end ) as Rejection_count,
round(
	sum(case when Loan_Status = 'Rejected' then 1 else 0 end ) /
	count(*) * 100,2)as Rejected_percentage
from data
group by Credit_History;

select 
Property_Area,
count(Loan_Status) as  count_of_applicants,
sum(case when Loan_Status = 'Approved' then 1 else 0 end )  as count_of_Approval,
round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end ) /
	count(*)  * 100,
2
)  as percentage
from data
group by Property_Area
order by percentage desc;

select min(Age) as minimum_age,
round(avg(Age)) as avg_age , 
round(max(Age)) as maximum_age
from data;
 
 select *
from data
where Age > (select avg(Age) from data where Loan_Amount > 250000 )
 and Loan_Amount > 250000;
 
 select
avg(Loan_Amount)
from data
where Age > (select avg(Age) from data) ;
 
 

 
 
 #=====================================================
         # 6. CTE & Window Function Analysis
#=====================================================




with Applicant_Income as (
SELECT
    *,
    CASE
        WHEN Applicant_Income <= AVG(Applicant_Income) OVER () * 0.75
            THEN 'Low_income'
        WHEN Applicant_Income <= AVG(Applicant_Income) OVER () * 1.25
            THEN 'Medium_income'
        ELSE 'High_income'
    END AS income_category
FROM data
)
select income_category, 
count(*) as Total_applicants ,
 round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end) /
		count(*) *100,2) as Approved_percentage,
    round(
	sum(case when Loan_Status = 'Rejected' then 1 else 0 end) /
		count(*)  *100,2) as Rejected_percentage
from Applicant_Income
group by income_category
order by Approved_percentage desc;



with Coapplicant_Income as(
select *,
	case
		when Coapplicant_Income < avg(Coapplicant_Income) over() * 0.75 
			then 'low_income'
		when Coapplicant_Income < avg(Coapplicant_Income) over() * 1.25
			then 'medium_income'
	else 'high_income' 
    end as income_category
from data
)
select income_category,
count(*) as Total_applicants ,
 round(
	sum(case when Loan_Status = 'Approved' then 1 else 0 end) /
		count(*) *100,2) as Approved_percentage,
    round(
	sum(case when Loan_Status = 'Rejected' then 1 else 0 end) /
		count(*)  *100,2) as Rejected_percentage
from Coapplicant_Income
group by income_category
order by Approved_percentage desc;



with Applicant_Income as (
SELECT
    *,
    CASE
        WHEN Applicant_Income <= AVG(Applicant_Income) OVER () * 0.75
            THEN 'Low_income'
        WHEN Applicant_Income <= AVG(Applicant_Income) OVER () * 1.25
            THEN 'Medium_income'
        ELSE 'High_income'
    END AS income_category
FROM data
)
select 
income_category ,
avg(Applicant_Income),
avg(Loan_Amount)
from Applicant_Income
group by income_category;


with age_category as (
select *,
	case 
		when Age  between 18 and 30
			then 'Young'
		when Age  between 31 and 50
			then 'Middle'
		else 'Senior'
	end as age_classification
from data
)
select age_classification, avg(Loan_Amount)
from age_category
group by age_classification;



with Property as (
select Property_Area, count(*) as Approved_count
from data
where Loan_Status = 'Approved'
group by Property_Area
)
select Property_Area,
Approved_count,
rank() over( order by Approved_count desc) as rank_
from Property;



with age_category as(
select *,
	case 
		when Age between 18 and 30
			then 'Young'
		when Age between 31 and 50
			then 'Middle'
		else 'Senior'
	end as age_classification
from data
),
ranking as (
select * ,
row_number() over( partition by age_classification order by Loan_Amount desc) as rank_
from age_category)
select age_classification,Age,Loan_Amount
from ranking
where rank_ = 1;



#=====================================================
         # 7. HAVING ANALYSIS
#=====================================================



select 
Dependents,
count(*) as Approved_count
from data
where Loan_Status = 'Approved'
group by Dependents
having Approved_count > 500;

select 
Education,
count(*) as Approved_count
from data
where Loan_Status = 'Approved'
group by Education
having Approved_count > 500;

select 
Employment_Status,
count(*) as Approved_count
from data
where Loan_Status = 'Approved'
group by Employment_Status
having Approved_count > 500;

select 
Property_Area,
count(*) as Approved_count
from data
where Loan_Status = 'Approved'
group by Property_Area
having Approved_count > 500;


#=====================================================
         # 7. VIEWS
#=====================================================



create view Applicants as
select
Loan_ID,
Gender,
Married,
Dependents,
Education,
Employment_Status,
Property_Area,
Age
from data;

create view Applicants_loan_details as
select
Loan_ID,
Applicant_Income,
Coapplicant_Income,
Loan_Amount,
Credit_History,
Loan_Status
from data;



#=====================================================
              # 8. JOINS
#=====================================================



select 
Gender,
Education,
Employment_Status,
Applicant_Income,
Loan_Amount,
Credit_History,
Loan_Status
from Applicants as a
	join Applicants_loan_details as b
	on a.Loan_ID = b.Loan_ID;


select * from data limit 3; 


#=====================================================
              # 9. Business Insights
#=====================================================
-Credit History has a strong relationship with Loan Status.
-Other customer attributes show no strong relationship with Loan Status.
-Urban areas have the highest number of approved loans.
-Lower-income applicants have a higher average loan amount.
-Young applicants (18–30) have the highest average loan amount.
-Higher income does not necessarily mean a higher chance of loan approval.

## **Applicants with a favorable credit history have a higher chance of getting their loans approved.**

