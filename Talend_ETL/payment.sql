
create table user_tbl(users_ID int primary key);
create table book_tbl(booking_ID int primary key);
create table payment_details(payment_ID int not null primary key, 
							userID int,foreign key (userID) references user_tbl(users_ID), 
							bookingID int,
							foreign key(bookingID) references book_tbl(booking_ID), 
							amount int not null, 
							mode varchar(50) not null, 
							status varchar(20) not null, 
							CreatedBy varchar(50) not null,
							CreatedDate datetime not null default getdate(), 
							ModifiedBy varchar(50) not null default 'Divya', 
							ModifiedDate datetime not null default getdate(), 
							RecordStatus bit default 1,
							RowGUID varchar(max) default newid());

drop table payment_details;
drop table user_tbl;
drop table book_tbl;

insert into payment_details (payment_ID,userID,bookingID,amount,mode,status,CreatedBy) values(10,1,2,4500,'DebitCard','Failed','Veena');
select * from payment_details;

insert into user_tbl values(7);
insert into book_tbl values(8);
SELECT * FROM USER_TBL;

-->> CREATE AND INSERT IN SP

CREATE procedure SP_Payment_Details
@payment_ID int, 
@userID int, 
@bookingID int,
@amount int,
@mode varchar(30),
@status varchar(40),
@CreatedBy varchar(40)
as 
begin 
update payment_details set payment_ID=@payment_ID,userID=@userID,bookingID=@bookingID,amount=@amount,status=@status,mode=@mode,CreatedBy=@CreatedBy where status=@status;
end 
exec SP_Payment_Details 10,1,2,4500,'DebitCard','Success','Veena'

select * from payment_details;

drop procedure SP_Payment_Details

--> LIST ALL

alter procedure SP_Payment_Details 
as 
begin
select * from payment_details;
end;
exec SP_Payment_Details

-->>UPDATE
alter procedure SP_Payment_Details
@payment_ID int, 
@userID int, 
@bookingID int,
@amount int,
@mode varchar(30),
@CreatedBy varchar(40),
@status varchar(40)
as 
begin
insert into payment_details (payment_ID,userID,bookingID,amount,mode,status,CreatedBy)values(@payment_ID,@userID,@bookingID,@amount,@mode,@status,@CreatedBy)
end;
EXEC SP_Payment_Details 15,220,320,4500,'DebitCard','Failed','Veena'


-------------------------------------------
ALTER PROCEDURE PAY_CRUD 
(@payment_ID int, 
@userID int, 
@bookingID int,
@amount int,
@mode varchar(30),
@status varchar(40),
@CreatedBy varchar(40),
@StatementType NVARCHAR(20) = '')
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO payment_details (payment_ID,userID,bookingID,amount,mode,status,CreatedBy)values(@payment_ID,@userID,@bookingID,@amount,@mode,@status,@CreatedBy)
        END
      ELSE IF @StatementType = 'Update'
        BEGIN
            UPDATE payment_details set userID=@userID,bookingID=@bookingID,amount=@amount,mode=@mode,status=@status ,CreatedBy=@CreatedBy where payment_ID=@payment_ID;
        END
END       
---UPDATE PAYMENT_DETAILS SET STATUS=@STATUS WHERE payment_ID=@payment_ID,userID=@userID

DROP PROCEDURE PAY_CRUD

EXEC PAY_CRUD 40,7,8,500,'CreditCard','Success','DIVYA','Insert'

EXEC PAY_CRUD 1,10,20,4500,'DebitCard','Success','Veena','Update'

CREATE PROCEDURE CRUD_SELECT
AS
	BEGIN
		SELECT * FROM  payment_details
END

EXEC CRUD_SELECT

SELECT * FROM PAYMENT_DETAILS

use merit
create table pay(payment_id int,mode varchar(40),CreatedBy varchar(50) not null default 'Divya',
							CreatedDate datetime not null default getdate(), 
							ModifiedBy varchar(50) not null default 'Divya', 
							ModifiedDate datetime not null default getdate(), 
							RecordStatus bit default 1,
							RowGUID varchar(max) default newid())
select *from pay

drop table pay


CREATE PROCEDURE PAY_CRUD 
(@payment_ID int, 
@USERID int, 
@bookingID int,
@amount int,
@mode varchar(30),
@status varchar(40),
@CreatedBy varchar(40),
@StatementType NVARCHAR(20) = '')
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO payment_details (payment_ID,userID,bookingID,amount,mode,status,CreatedBy)values(@payment_ID,@userID,@bookingID,@amount,@mode,@status,@CreatedBy)
        END
      ELSE IF @StatementType = 'Update'
        BEGIN
            UPDATE payment_details set USERID=@USERID,bookingID=@bookingID,amount=@amount,mode=@mode,status=@status ,CreatedBy=@CreatedBy where payment_ID=@payment_ID;
        END
END       
---UPDATE  u_id int FOREIGN KEY(u_id) REFERENCES user_table(id),

DROP PROCEDURE PAY_CRUD

EXEC PAY_CRUD 40,7,8,500,'CreditCard','Success','DIVYA','Insert'

EXEC PAY_CRUD 1,10,20,4500,'DebitCard','Success','Veena','Update'

CREATE PROCEDURE CRUD_SELECT
AS
	BEGIN
		SELECT * FROM  payment_details
END

EXEC CRUD_SELECT