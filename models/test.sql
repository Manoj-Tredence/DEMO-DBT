select
* 
from
{{ source('demo', 'WEATHER') }}

limit 10

