<?php


include("connection.php");

$proc_name = '';
$result = array();
if(isset($_REQUEST['submit']))
{
    $proc_name = $_REQUEST['proc_name'];
    $fromdate = $_REQUEST['fromdate'];
    $todate = $_REQUEST['todate'];
    $year = $_REQUEST['year'];
    $order_id_input = $_REQUEST['order_id_input'];
    $members = $_REQUEST['members'];
    $reserve_id = $_REQUEST['reserve_id'];
    if('Sales_by_Year' == $proc_name){
        $sql = "call la_bourse.Sales_by_Year('".$fromdate."','".$todate."');";
        //echo $sql;
        $result = mysqli_query($conn, $sql);



        if (!$result)
            trigger_error('Invalid query: ' . $conn->error);    
        
    }else if('Customer_max_orders' == $proc_name){
        $sql = "call la_bourse.Customer_max_orders('".$year."');";
        //echo $sql;
        $result = mysqli_query($conn, $sql);

        if (!$result)
            trigger_error('Invalid query: ' . $conn->error);
    
    }else if('get_amount' == $proc_name){
        $sql = "call la_bourse.get_amount('".$order_id_input."');";
        //echo $sql;
        $result = mysqli_query($conn, $sql);

        if (!$result)
            trigger_error('Invalid query: ' . $conn->error);
    }else if('Ten_Most_Expensive_Dishes' == $proc_name){
        $sql = "call la_bourse.Ten_Most_Expensive_Dishes();";
        //echo $sql;
        $result = mysqli_query($conn, $sql);

        if (!$result)
            trigger_error('Invalid query: ' . $conn->error);
    
    }else if('allocate_table' == $proc_name){
        $sql = "call la_bourse.allocate_table('".$members."','".$reserve_id."');";
        //echo $sql;
        $result = mysqli_query($conn, $sql);

        if (!$result)
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

    <link rel="shortcut icon" href="theme/assets/images/favicon.ico">

    <title>La Bourse </title>

    <!-- App css -->
    <link href="theme/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="theme/assets/css/core.css" rel="stylesheet" type="text/css" />
    <link href="theme/assets/css/components.css" rel="stylesheet" type="text/css" />
    <link href="theme/assets/css/icons.css" rel="stylesheet" type="text/css" />
    <link href="theme/assets/css/pages.css" rel="stylesheet" type="text/css" />
    <link href="theme/assets/css/menu.css" rel="stylesheet" type="text/css" />
    <link href="theme/assets/css/responsive.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="theme/plugins/switchery/switchery.min.css">

    <!-- HTML5 Shiv and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <script src="theme/assets/js/modernizr.min.js"></script>

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
                            <img src="theme/assets/images/logo.png" alt="" height="30">
                        </a>

                    </div>
                    <!-- End Logo container-->




                </div> <!-- end container -->
            </div>
            <!-- end topbar-main -->

            <div class="navbar-custom">
                <div class="container">
                    <div id="navigation">
                        <!-- Navigation Menu-->
                        <?php
                       // include("navigation.php");
                        ?>
                        <!-- End navigation menu -->
                    </div> <!-- end #navigation -->
                </div> <!-- end container -->
            </div> <!-- end navbar-custom -->
        </header>
        <!-- End Navigation Bar-->


        <div class="wrapper">
            <div class="container">

                <!-- Page-Title -->
                <div class="row">



                    <div class="col-sm-12">
                        <div class="page-title-box">

                            <h4 class="page-title">check availaibility</h4>



                            <div class="col-md-12">
                                <div class="demo-box">
                                    <h4 class="m-t-0 header-title"><b>Primary Table</b></h4>

                                    <form action="">
                                         <div class="form-group" >
                                        <div id="Sales_by_Year_div" style="display: none;">
                                            From Date -> <input type="Date" name="fromdate"><br>
                                            To Date -> <input type="Date" name="todate">
                                        </div>
                                        <div id="Customer_max_orders_div" style="display: none;">
                                            Input Year -> <input type="Year" name="year"><br>
                                        </div>
                                         <div id="get_amount_div" style="display: none;">
                                            Order ID -> <input type="text" name="order_id_input"><br>
                                        </div>
                                        <div id="allocate_table_div" style="display: none;">
                                            members -> <input type="text
                                            " name="members"><br>
                                            reserve_id -> <input type="text" name="reserve_id">
                                        </div>
                                            <select name="proc_name" onchange="proc_name_fn(this.value)" id="proc_name">
                                            <option value="Selct Any One">Select</option>
                                            <option value="Sales_by_Year">Sales_by_Year</option>
                                            <option value="Customer_max_orders">
                                            Customer_max_orders</option>
                                            <option value="Ten_Most_Expensive_Dishes">Ten_Most_Expensive_Dishes</option>
                                            <option value="get_amount">get_amount</option>
                                            <option value="allocate_table">allocate_table</option>

                                        </select>               

                                        <button type="submit" class="btn btn-md btn-success" name="submit"> check product details </button>

                                               </div>
                                    </form>


                                </div>



                                <div class="table-responsive">
                                    <?php
                                    if('Sales_by_Year' == $proc_name){
                                        echo '<table class="table m-0 table-colored table-primary">
                                        <thead>
                                        <tr>
                                        <th>Order_date</th>
                                        <th>order_id</th>
                                        <th>amount</th>
                                        <th>year</th>                                                  
                                        </tr>
                                        </thead>
                                        <tbody>';
                                    }
                                    else if('Customer_max_orders' == $proc_name){
                                        echo                          '<table class="table m-0 table-colored table-primary">
                                        <thead>
                                        <tr>

                                        <th>total order</th>
                                        <th>bill_date_</th>
                                        <th>user_id_max</th>




                                        </tr>
                                        </thead>
                                        <tbody>';   
                                    }
                                    else if('get_amount' == $proc_name){
                                        echo '                                            <table class="table m-0 table-colored table-primary">
                                        <thead>
                                        <tr>

                                        <th>order_id_input</th>
                                        <th>billamount</th>
                                        
                                        </tr>
                                        </thead>
                                        <tbody>';
                                    }else if('Ten_Most_Expensive_Dishes' == $proc_name){
                                        echo '                                            <table class="table m-0 table-colored table-primary">
                                        <thead>
                                        <tr>

                                        <th>TenMostExpensiveProducts</th>
                                        <th>item_price</th>


                                        </tr>
                                        </thead>
                                        <tbody>';   
                                    
                                    }else if('allocate_table' == $proc_name){
                                        echo '                                            <table class="table m-0 table-colored table-primary">
                                        <thead>
                                        <tr>

                                        
                                        <th>reserve_id</th>
                                        <th>members</th>
                                        <th>assigned_tableid</th>
                                        <th>table_status</th>    
                                        </tr>
                                        </thead>
                                        <tbody>';   
                                    } 

                                        ?>
                                        <?php

                                        if(isset($_REQUEST['submit'])){


                                         if ($result->num_rows > 0) {
                    													
                                            while($row = $result->fetch_assoc()) {
                                             
                                            if('Sales_by_Year' == $proc_name){
                                              echo ' <tr>
                                              <td>'.$row['order_date'].'</td>
                                              <td>'.$row['order_id'].'</td>
                                              <td>'.$row['amount'].'</td>
                                              <td>'.$row['Year'].'</td>
                                              </tr>';
                                          }else if('Customer_max_orders' == $proc_name){
                                            echo ' <tr>
                                            <td>'.$row['total_order'].'</td>
                                            <td>'.$row['bill_date_'].'</td>
                                            <td>'.$row['user_id_max'].'</td>

                                            </tr>';
                                        }else if('get_amount' == $proc_name){
                                            echo ' <tr>
                                            <td>'.$row['order_id_input'].'</td>
                                            <td>'.$row['billamount'].'</td>
                                            </tr>';       
                                            
                                        }
                                        else if('Ten_Most_Expensive_Dishes' == $proc_name){
                                            echo ' <tr>
                                            <td>'.$row['TenMostExpensiveProducts'].'</td>
                                            <td>'.$row['item_price'].'</td>
                                            
                                            </tr>';
                                        }else if('allocate_table' == $proc_name){
                                              echo ' <tr>
                                              <td>'.$row['reserve_id'].'</td>
                                              <td>'.$row['members'].'</td>
                                              <td>'.$row['assigned_tableid'].'</td>
                                              <td>'.$row['table_status'].'</td>
                                              </tr>';
                                          }
                                        else {
                                          echo "results 0";
                                      }
                                  }	    // output data of each row



                              }
                          }
                          else 
                            echo " <td> please select values from form</td>";
                        ?>       
                    </tbody>
                </table>
            </div>
        </div>
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
                ©2019 by LA BOURSE 
            </div>
        </div>
    </div>
</footer>
<!-- End Footer -->

</div> <!-- end container -->
</div>
<!-- end wrapper -->


<!-- jQuery  -->
<script src="https://code.jquery.com/jquery-3.4.0.js"></script>
<script src="theme/assets/js/bootstrap.min.js"></script>
<script src="theme/assets/js/detect.js"></script>
<script src="theme/assets/js/fastclick.js"></script>
<script src="theme/assets/js/jquery.blockUI.js"></script>
<script src="theme/assets/js/waves.js"></script>
<script src="theme/assets/js/jquery.slimscroll.js"></script>
<script src="theme/assets/js/jquery.scrollTo.min.js"></script>
<script src="theme/plugins/switchery/switchery.min.js"></script>

<!-- App js -->
<script src="theme/assets/js/jquery.core.js"></script>
<script src="theme/assets/js/jquery.app.js"></script>
<script type="text/javascript">
    function proc_name_fn(proc_name){
        if(proc_name == 'Sales_by_Year'){
                    document.getElementById('Sales_by_Year_div').style.display = 'block';//SHow
                    document.getElementById('Customer_max_orders_div').style.display = 'none';//Hide
                    document.getElementById('get_amount_div').style.display = 'none';
                }else if(proc_name == 'Customer_max_orders'){
                    document.getElementById('Customer_max_orders_div').style.display = 'block';
                    document.getElementById('Sales_by_Year_div').style.display = 'none';
                    document.getElementById('get_amount_div').style.display = 'none';
                }else if(proc_name == 'Ten_Most_Expensive_Dishes'){
                    document.getElementById('Customer_max_orders_div').style.display = 'none';
                    document.getElementById('Sales_by_Year_div').style.display = 'none';
                    document.getElementById('get_amount_div').style.display = 'none';
                }else if(proc_name == 'get_amount'){
                    document.getElementById('Customer_max_orders_div').style.display = 'none';
                    document.getElementById('Sales_by_Year_div').style.display = 'none';
                    document.getElementById('Ten_Most_Expensive_Dishes_div').style.display = 'none';
                    document.getElementById('get_amount_div').style.display = 'block';
                }else if(proc_name == 'allocate_table'){
                    document.getElementById('Customer_max_orders_div').style.display = 'none';
                    document.getElementById('Sales_by_Year_div').style.display = 'none';
                    document.getElementById('Ten_Most_Expensive_Dishes_div').style.display = 'none';
                    document.getElementById('get_amount_div').style.display = 'none';
                    document.getElementById('allocate_table_div').style.display = 'block';
                }
            }
        </script>
    </body>
    </html>