<?php
session_start();

if(isset($_POST['teacher-login-btn'])){

    $teacher_number =  $_POST['teacher-number'];
    $teacher_password = $_POST['teacher-password'];

    $connection = mysqli_connect('localhost','root','','yazgeldb1');
    $sql = "SELECT * FROM teacher WHERE teacher_email = '$teacher_number' and role='teacher'";
    $result = mysqli_query($connection, $sql);
    $num_of_row = mysqli_num_rows($result);

    if($num_of_row < 1){
        $_SESSION['t_message'] = 'User Not Found!';
        header('Location: ../teacher_login.php?error=no-user-found');
        exit();
    }else{
        while($row = mysqli_fetch_assoc($result)){
            if(($teacher_password) != $row['teacher_password']){
                $_SESSION['t_message'] = 'The Password You Entered Is Incorrect';
                header('Location: ../teacher_login.php?error=wrong-password');
                exit();
            }else{
                session_start();
                $_SESSION['teacher_id'] = $row['teacher_id'];
                $_SESSION['teacher_name'] = $row['teacher_full_name'];
                $_SESSION['teacher_number'] = $row['teacher_school_no'];
                header('location: ../Teacher/dashboard/index.php?teacher-login=success');
                exit();
            }
        }
    }

}
