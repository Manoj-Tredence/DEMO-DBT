with Daily_weather 
as
(

select * from 
{{ source('demo', 'weather') }}


)

--select * from Daily_weather
--limit 10


SELECT *
FROM daily_weather
--LIMIT 10
