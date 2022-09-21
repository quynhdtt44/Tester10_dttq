-- Ex1: Join
-- Q1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT *
FROM `account` a
JOIN department d ON a.department_id = d.department_id;

-- Q2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account` 
WHERE create_date > '2010/12/10';

-- Q3: Viết lệnh để lấy ra tất cả các developer
SELECT *
FROM `account` a
JOIN `position` p ON a.position_id = p.position_id
WHERE p.position_name = 'dev';

-- Q4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.department_name, d.department_id, count(account_id) AS So_nv
FROM department d
JOIN `account` a ON d.department_id = a.department_id
GROUP BY department_id
HAVING count(account_id) >3;

-- Q5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
-- cách 1:
SELECT *, count(e.exam_id) AS So_lan_duoc_su_dung
FROM question q
JOIN examquestion e ON q.question_id = e.question_id
GROUP BY e.question_id
HAVING count(e.exam_id) >= ALL(SELECT count(exam_id)
								FROM examquestion
								GROUP BY question_id);
                                
-- cách 2:
SELECT *, count(eq.exam_id) AS So_lan_su_dung
FROM question q
JOIN examquestion eq ON q.question_id = eq.question_id
GROUP BY eq.question_id
HAVING count(eq.exam_id) = (SELECT max(So_luong)
							FROM (SELECT count(exam_id) AS So_luong
									FROM examquestion
									GROUP BY question_id) AS question1);

-- Q6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT *, count(q.question_id) AS So_lan_duoc_sd
FROM categoryquestion c
LEFT JOIN question q ON c.category_id = q.category_id
GROUP BY q.category_id;

-- Q7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT *, count(e.exam_id) AS So_lan_duoc_su_dung
FROM question q
LEFT JOIN examquestion e ON q.question_id = e.question_id
GROUP BY e.exam_id;

-- Q8: Lấy ra Question có nhiều câu trả lời nhất
SELECT *, count(a.answer_id) AS So_cau_tl
FROM question q
LEFT JOIN answer a ON q.question_id = a.question_id
GROUP BY a.question_id
HAVING count(a.answer_id) = (SELECT max(So_luong)
							FROM (SELECT count(answer_id) AS So_luong
									FROM answer
									GROUP BY question_id) AS question1);

-- Q9: Thống kê số lượng account trong mỗi group
SELECT *, count(ga.account_id) AS So_ac
FROM `group` g
LEFT JOIN groupaccount ga ON ga.group_id = g.group_id
GROUP BY ga.group_id;

-- Q10: Tìm chức vụ có ít người nhất
SELECT *, count(a.account_id) AS So_nguoi
FROM `position` p
LEFT JOIN `account` a ON p.position_id = a.position_id
GROUP BY a.position_id
HAVING count(a.account_id) = (SELECT min(So_luong)
								FROM (SELECT count(account_id) AS So_luong
										FROM `account`
										GROUP BY position_id) AS position1);

-- Q11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT p.position_id, p.position_name, count(a.account_id) AS So_nv
FROM position p
LEFT JOIN `account` a ON p.position_id = a.position_id
GROUP BY a.position_id;

-- Q12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT *
FROM question q
LEFT JOIN answer a ON q.question_id = a.question_id
LEFT JOIN `account` ac ON q.creator_id = account_id;

-- Q13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT tq.type_id, tq.type_name, count(q.question_id) AS So_cau_hoi
FROM typequestion tq
LEFT JOIN question q ON tq.type_id = q.type_id
GROUP BY q.type_id;

-- Q14: Lấy ra group không có account nào
-- Q15: Lấy ra group không có account nào
SELECT *
FROM `group` g
LEFT JOIN groupaccount ga ON g.group_id = ga.group_id
GROUP BY ga.group_id
HAVING count(ga.account_id) = 0;

-- Q16: Lấy ra question không có answer nào
SELECT *
FROM question q
LEFT JOIN answer a ON a.question_id = q.question_id
WHERE a.answer_id IS NULL;

-- Ex2: Union
-- Q17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT *
FROM `account`
WHERE create_date <= '2021/01/10'
UNION
SELECT *
FROM `account`
WHERE create_date >= '2021/02/09';

-- Q18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT *
FROM `group` g
JOIN groupaccount ga ON g.group_id = ga.group_id
GROUP BY ga.group_id
HAVING count(ga.account_id) >5
UNION
SELECT *
FROM `group` g
JOIN groupaccount ga ON g.group_id = ga.group_id
GROUP BY ga.group_id
HAVING count(ga.account_id) <7;