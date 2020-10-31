<?php 

if (isset($_COOKIE['user_type'])) {
    unset($_COOKIE['user_type']);
    unset($_COOKIE['user_id']);
    setcookie('user_type', null, -1, '/');
    setcookie('user_id', null, -1, '/');
     header("Location: http://localhost/labourse/login.php");
                die();
    return true;
} else {
    return false;
}

 ?>
