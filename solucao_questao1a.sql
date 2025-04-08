SELECT 
    escolas.name AS escola,
    alunos.enrolled_at AS dia,
    COUNT(alunos.id) AS alunos_matriculados,
    ROUND(COALESCE(SUM(cursos.price), 0), 2) AS total_matriculas
FROM students alunos
INNER JOIN courses cursos ON alunos.course_id = cursos.id
INNER JOIN schools escolas ON cursos.school_id = escolas.id
WHERE cursos.name LIKE 'data%' -- Filtra cursos que começam com "data"
GROUP BY escolas.name, alunos.enrolled_at
ORDER BY dia DESC; -- Ordena do dia mais recente para o mais antigo