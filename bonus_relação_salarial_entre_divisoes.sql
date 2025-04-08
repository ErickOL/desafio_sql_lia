-- Média salarial por divisão dentro de cada departamento
SELECT 
    d.nome AS departamento,
    dv.nome AS divisao,
    ROUND(AVG(v.valor), 2) AS media_salarial_divisao
FROM empregado e
INNER JOIN divisao dv ON e.lotacao_div = dv.cod_divisao
INNER JOIN emp_venc ev ON e.matr = ev.matr
INNER JOIN vencimento v ON ev.cod_venc = v.cod_venc
INNER JOIN departamento d ON dv.cod_dep = d.cod_dep
GROUP BY d.nome, dv.nome
ORDER BY d.nome, media_salarial_divisao DESC;