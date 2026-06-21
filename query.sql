WITH cleaned_data as (select 
     `Customer ID`,
     InvoiceDate,
     Quantity*Price as revenue
From 
    online_retail_II
Where 
    Quantity > 0 and
    Price > 0 and
    `Customer ID` != ''
),

cohort as (Select
    `Customer ID`,
    toStartOfMonth (min(InvoiceDate)) as cohort_month
From
    cleaned_data
Group BY 1)

Select 
    c.cohort_month,
    toStartOfMonth(InvoiceDate) as invoice_month,
    dateDiff ('month', c.cohort_month, toStartOfMonth(cd.InvoiceDate)) as month_number,
    count(distinct(cd.`Customer ID`)),
    sum (cd.revenue)
From 
    cleaned_data as cd 
Join 
    cohort as c 
on cd.`Customer ID` = c.`Customer ID`
Group by 1,2,3
