-- tables: lineitem,part
SELECT /*+SET_VAR(enable_pipeline_engine=true) */ 100.00 * sum(CASE
                    WHEN p_type LIKE 'PROMO%'
                      THEN l_extendedprice * (1 - l_discount)
                    ELSE 0
                    END) / sum(l_extendedprice * (1 - l_discount)) AS promo_revenue
FROM
  lineitem,
  part
WHERE
  l_partkey = p_partkey
  AND l_shipdate >= DATEV2 '1995-09-01'
  AND l_shipdate < DATEV2 '1995-09-01' + INTERVAL '1' MONTH
