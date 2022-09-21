-- Q1: Thêm ít nhất 10 record vào mỗi table

-- Q2: Lấy ra tất cả các phòng ban
SELECT * FROM department;

-- Q3: Lấy ra id của phòng ban "Sale"
SELECT department_id 
FROM department
WHERE department_name = 'Sale';

-- Q4: Lấy ra thông tin account có full name dài nhất và sắp xếp chúng theo thứ tự giảm dần
SELECT *
FROM `account`
WHERE char_length(full_name) = (SELECT MAX(char_length(full_name)) 
							FROM `account`);

-- Q5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT *
FROM `account`
WHERE char_length(full_name) = (SELECT MAX(char_length(full_name)) 
							FROM `account`)
		AND department_id = 3;

-- Q6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT group_name
FROM `group`
WHERE create_date <= '2019/12/20';

-- Q7: Lấy ra ID của question có >= 4 câu trả lời
SELECT question_id, count(answer_id) as So_cau_tra_loi
FROM answer
GROUP BY question_id
HAVING count(answer_id) >= 4;

-- Q8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT `code`
FROM exam
WHERE duration >= '60:00' AND create_date < '2019/12/20';

-- Q9: Lấy ra 5 group được tạo gần đây nhất
SELECT group_name
FROM `group`
ORDER BY create_date DESC
LIMIT 5;

-- Q10: Đếm số nhân viên thuộc department có id = 2
SELECT count(account_id) AS So_nv_thuoc_department_id_2
FROM `account`
WHERE department_id = 2;

-- Q11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT *
FROM `account`
WHERE full_name LIKE 'D%o';

-- Q12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE
FROM exam
WHERE create_date < '2019/12/20';

-- Q13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE
FROM question
WHERE content LIKE 'Câu hỏi%';

-- Q14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `account`
SET full_name = 'Nguyễn Bá Lộc', email = 'loc.nguyenba@vti.com.vn'
WHERE account_id = 5;

-- Q15: Update account có id = 5 sẽ thuộc group có id = 4
UPDATE groupaccount
SET group_id = 4
WHERE account_id = 5;
