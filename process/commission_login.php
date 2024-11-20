<?php
session_start();
if(isset($_POST['commission-login-btn'])){

    $commission_number =  $_POST['commission_number'];
    $commission_password = $_POST['commission_password'];

    $connection = mysqli_connect('localhost','root','','yazgeldb1');
    $sql = "SELECT * FROM teacher WHERE teacher_email = '$commission_number' and role='commission'";
    $result = mysqli_query($connection, $sql);
    $num_of_row = mysqli_num_rows($result);

    if($num_of_row < 1){
        $_SESSION['c_message'] = 'User Not Found!';
        header('Location: ../commission_login.php?error=no-user-found');
        exit();
    }else{
        while($row = mysqli_fetch_assoc($result)){
            if(($commission_password) != $row['teacher_password']){
                $_SESSION['c_message'] = 'The Password You Entered Is Incorrect';
                header('Location: ../commission_login.php?error=wrong-password');
                exit();
            }else{
                session_start();
                $_SESSION['commission_id'] = $row['teacher_id'];
                $_SESSION['commission_name'] = $row['teacher_full_name'];
                $_SESSION['commission_number'] = $row['teacher_school_no'];
                header('location: ../Commission/dashboard/index.php?commission-login=success');
                exit();
            }
        }
    }

}
