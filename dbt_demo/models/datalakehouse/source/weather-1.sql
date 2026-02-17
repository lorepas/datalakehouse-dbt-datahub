{{ config(materialized='table') }}

select * from Samples."samples.dremio.com"."NYC-weather.csv"