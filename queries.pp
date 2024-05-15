query "s3_bucket_month_created" {
  sql = <<EOQ
    with creation_year_month as (
        select to_char(creation_date, 'yyyy-mm') as year_month
        from aws_s3_bucket
    )
    select year_month, count(*)
    from creation_year_month
    group by year_month order by year_month
  EOQ
}

query "s3_bucket_age" {
  sql = <<EOQ
    select
      name as "Name",
      now()::date - creation_date::date as "Age in Days"
    from
      aws_s3_bucket
    order by
      creation_date
  EOQ
}

query "s3_buckets_by_region" {
  sql = <<EOQ
    select
      region,
      count(*)
    from
      aws_s3_bucket
    group by
      region
    order by
      count
  EOQ
}
