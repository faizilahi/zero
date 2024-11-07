-- models/khedmat_responses_transformed.sql
with responses as (
    select
        *,
        parse_timestamp('%m/%d/%Y %H:%M:%S', Timestamp) as timestamp_parsed,
        lower(trim(`Email address`)) as email_address,
        lower(trim(`Email id`)) as email_id,
        regexp_replace(`Mobile Number`, r'[^0-9]', '') as mobile_number,
        parse_date('%m/%d/%Y', DOB) as date_of_birth,
        case
            when lower(`Location(State and City you are located at)`) like '%delhi%' then 'Delhi'
            else `Location(State and City you are located at)`
        end as standardized_location
    from `chatpipeline.google_sheets.khedmat_responses`
)

select
    timestamp_parsed as timestamp,
    email_address,
    name,
    email_id,
    mobile_number,
    date_of_birth,
    standardized_location as location
from responses
