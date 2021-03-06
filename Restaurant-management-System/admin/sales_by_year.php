<?php
include('../connection.php');

 $result = array();
if(isset($_REQUEST['submit']))
{

    $fromdate = $_REQUEST['fromdate'];
    $todate = $_REQUEST['todate'];


    $sql = "call la_bourse.Sales_by_Year('".$fromdate."','".$todate."');";
    //echo $sql;
    $result = mysqli_query($conn, $sql);



    if (!$result){
    trigger_error('Invalid query: ' . $conn->error);    

}
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A fully featured admin theme which can be used to build CRM, CMS, etc.">
    <meta name="author" content="Coderthemes">

    <link rel="shortcut icon" href="../theme/assets/images/favicon.ico">

    <title>RESTAURENT APP</title>

    <!-- App css -->
    <link href="../theme/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../theme/assets/css/core.css" rel="stylesheet" type="text/css" />
    <link href="../theme/assets/css/components.css" rel="stylesheet" type="text/css" />
    <link href="../theme/assets/css/icons.css" rel="stylesheet" type="text/css" />
    <link href="../theme/assets/css/pages.css" rel="stylesheet" type="text/css" />
    <link href="../theme/assets/css/menu.css" rel="stylesheet" type="text/css" />
    <link href="../theme/assets/css/responsive.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../plugins/switchery/switchery.min.css">

    <!-- HTML5 Shiv and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <script src="../theme/assets/js/modernizr.min.js"></script>

</head>


<body>


    <!-- Navigation Bar-->
    <header id="topnav">
        <div class="topbar-main">
            <div class="container">

                <!-- Logo container-->
                <div class="logo">
                    <!-- Text Logo -->
                    <!--<a href="index.html" class="logo">-->
                        <!--Zircos-->
                        <!--</a>-->
                        <!-- Image Logo -->
                        <a href="index.html" class="logo">
                            <img src="../theme/assets/images/logo.png" alt="" height="30">
                        </a>

                    </div>
                    <!-- End Logo container-->




                </div> <!-- end container -->
            </div>
            <!-- end topbar-main -->

            <?php 

            include("admin_navbar.php");

            ?>

            <div class="wrapper">
                <div class="container">

                    <!-- Page-Title -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="page-title-box">
                                <div class="btn-group pull-right">

                                </div>
                                <h4 class="page-title">Sales of year if order date is between starting and end date of the year</h4>


                                <div class="col-lg-4">
                                    <div class="panel panel-color panel-success">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Input</h3>
                                            <p class="panel-sub-title font-13 text-muted">Sub title goes here with small font</p>
                                        </div>
                                        <div class="panel-body">


                                            <form action="">
                                             <div class="form-group" >
                                                <div id="Sales_by_Year_div" >
                                                    From  <input type="Date" class="form-control" name="fromdate"><br>
                                                    To  <input type="Date"  class="form-control" name="todate">
                                                </div>
                                                <hr/>
                                                <button type="submit" name="submit" class="btn btn-md btn-success">submit </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                            </div>





                            <div class="col-lg-8">
                                <div class="panel panel-color panel-success">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Sales by year</h3>
                                        <p class="panel-sub-title font-13 text-muted">Sub title goes here with small font</p>
                                    </div>
                                    <div class="panel-body">


                                        <table class="table m-0 table-colored table-primary">
                                            <thead>
                                                <tr>
                                                    <th>Order_date</th>
                                                    <th>order_id</th>
                                                    <th>amount</th>
                                                    <th>year</th>                                                  
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php
                                                if(isset($_REQUEST['submit'])){
                                                if (mysqli_num_rows($result)  > 0) {

                                                while($row = $result->fetch_assoc()) {

                                                echo ' <tr>
                                                  <td>'.$row['order_date'].'</td>
                                                  <td>'.$row['order_id'].'</td>
                                                  <td>'.$row['amount'].'</td>
                                                  <td>'.$row['Year'].'</td>
                                              </tr>';
                                          
                                      }
                                  }
                              }
                                  else
                                  {
                                    echo "<tr><td>no data available</td></tr>";
                                }
                                ?>


                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- end page title end breadcrumb -->


    <!-- Footer -->
    <footer class="footer text-right">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 text-center">
                    © 2016 - 2018 Zircos.
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer -->

</div> <!-- end container -->
</div>
<!-- end wrapper -->


<!-- jQuery  -->
<script src="../theme/assets/js/jquery.min.js"></script>
<script src="../theme/assets/js/bootstrap.min.js"></script>
<script src="../theme/assets/js/detect.js"></script>
<script src="../theme/assets/js/fastclick.js"></script>
<script src="../theme/assets/js/jquery.blockUI.js"></script>
<script src="../theme/assets/js/waves.js"></script>
<script src="../theme/assets/js/jquery.slimscroll.js"></script>
<script src="../theme/assets/js/jquery.scrollTo.min.js"></script>
<script src="../plugins/switchery/switchery.min.js"></script>

<!-- App js -->
<script src="../theme/assets/js/jquery.core.js"></script>
<script src="../theme/assets/js/jquery.app.js"></script>

</body>
</html>


