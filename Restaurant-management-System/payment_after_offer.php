<?php


include("connection.php");


if(isset($_REQUEST['submit']))
{
    $sql = "call la_bourse.payment_after_offer('1')";
    //echo $sql;
    $result = mysqli_query($conn, $sql);

    if (!$result) {
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

        <title>Zircos - Responsive Admin Dashboard Template</title>

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
                                                        
                                                        
                                                       
                                                        <button type="submit" class="btn btn-md btn-success" name="submit"> check product details </button>
                                                        

                                                    </form>


                                       </div>
                                       
                                      

                                        <div class="table-responsive">
                                            <table class="table m-0 table-colored table-primary">
                                                <thead>
                                                    <tr>
                                                        
                                                        <th>input_payment_id</th>
                                                        <th>pay_amount</th>
                                                

                                                        
                                                       
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                	<?php

                                                    if(isset($_REQUEST['submit'])){


                                                                    	if ($result->num_rows > 0) {
                    														    // output data of each row
                    														    while($row = $result->fetch_assoc()) {
                    														       

                    														        echo ' <tr>
                                                                            <td>'.$row['input_payment_id'].'</td>
                                                                            <td>'.$row['pay_amount'].'</td>
                                                                        

                                                                        </tr>';
                    														    }
                    														} else {
                    														    echo "0 results";
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
        <script src="theme/assets/js/jquery.min.js"></script>
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

    </body>
</html>