--- 1. Percentage of courses where students are doing well
SELECT
  ROUND((
    SELECT COUNT(*)
    FROM (
      SELECT AVG(uoh.pct) AS averageScore
      FROM UserOnlineHistory uoh
      JOIN OnlineCourses oc ON uoh.onlineCourseUid = oc.onlineCourseUid
      GROUP BY oc.onlineCourseUid
      HAVING AVG(uoh.pct) > 0.8
    ) AS WellPerformingCourses
  ) / (
    SELECT COUNT(*)
    FROM OnlineCourses
  ) * 100, 2) AS percentageOfCoursesDoingWell;

--- 2. Percentage of subjects where students are doing poorly
SELECT
  ROUND((
    SELECT COUNT(*)
    FROM (
      SELECT oc.onlineCourseSubjectUid
      FROM UserOnlineHistory uoh
      JOIN OnlineCourses oc ON uoh.onlineCourseUid = oc.onlineCourseUid
      GROUP BY oc.onlineCourseSubjectUid
      HAVING AVG(uoh.pct) < 0.8
    ) AS PoorlyPerformingSubjects
  ) / (
    SELECT COUNT(*)
    FROM Subjects
  ) * 100, 2) AS percentageOfSubjectsDoingPoorly;

--- 3. Average grade for each course
SELECT
  oc.onlineCourseTitle,
  ROUND(AVG(uoh.grade), 2) AS averageGrade
FROM UserOnlineHistory uoh
JOIN OnlineCourses oc ON uoh.onlineCourseUid = oc.onlineCourseUid
GROUP BY oc.onlineCourseTitle;

--- 4. Average grade for each subject
SELECT 
    Subjects.subjectName,
    ROUND(AVG(UserOnlineHistory.grade), 2) AS average_grade
FROM 
    UserOnlineHistory
JOIN 
    OnlineCourses ON UserOnlineHistory.onlineCourseUid = OnlineCourses.onlineCourseUid
JOIN 
    Subjects ON OnlineCourses.onlineCourseSubjectUid = Subjects.subjectUid
GROUP BY 
    Subjects.subjectName;
   
--- 5. Determine if there are any courses not being completed
SELECT
  oc.onlineCourseTitle
FROM OnlineCourses oc
LEFT JOIN UserOnlineHistory uoh ON oc.onlineCourseUid = uoh.onlineCourseUid
WHERE uoh.onlineCourseUid IS NULL;








